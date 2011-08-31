require 'grit'

class Tree

  attr_accessor :repo, :repository, :commits, :max_count, :branch, :target_branch_name,  :nodes, :edges, :points

  def initialize(repository, target_branch_name = 'master',  opts = {})
    @repository = repository

    @repo = @repository.repo
    @max_count= opts[:max_count] || 300
    @max_count = false if max_count < 0
    @target_branch_name  = target_branch_name
    @branch = branch_of(@target_branch_name)
    if opts[:all]
      @branches = @repo.heads.reject{|h| h.name == @target_branch_name}
    else
      @branches = (opts[:brances] || []).map{|b| branch_of(b)}
    end

    setup_commits

    build
    @nodes, @points = to_nodes_and_points(opts)
    @edges = to_edges
  end

  def branch_of(branch_name)
    @repo.get_head(branch_name)
  end

  private

  def setup_commits
    @commits = @repo.commits(@target_branch_name, @max_count).map{|c| Commit.new(c, @repository) }.reverse
    @main_commits_ids = @commits.map(&:id)
    @commits_hash = @commits.inject({}){|h,c| h[c.id] = c;h}

    @ommited_branches = {}
    @branches.each{|b|
      merge_base = @repo.git.merge_base({}, @target_branch_name, b.name).chomp
      next unless @main_commits_ids.include?(merge_base)

      cs = @repo.commits_between(merge_base, b.name)
      if cs.size > @max_count
        cs = cs[0..@max_count]
        @ommited_branches[cs.last.id] ||= DummyCommit.new
        @ommited_branches[cs.last.id].add_branch(b)
      end

      cs.reject{|c| @commits_hash[c.id]}.map{|c| Commit.new(c, @repository)}.uniq.each{|c|
        next if @commits_hash[c.id]
        @commits << c
        @commits_hash[c.id] ||= c
      }
    }

    @commits.uniq!

    @commits.each{|c|
      parents = c.commit.parents.map{|p| @commits_hash[p.id]}.reject(&:nil?)
      parents.each{|p| c.add_parent(p) }
      parents.each{|p| p.add_child(c) }
    }

    @ommited_branches.each{|sha_1, dc|
      parent = @commits_hash[sha_1]
      parent.add_child(dc)
      dc.add_parent(parent)
    }
  end

  def to_nodes_and_points(opts = {})
    node_size = opts[:node_size].try(&:to_i) || 100
    mergin = opts[:mergin].try(&:to_i) ||  50

    branches = repo.heads.select{|h| @commits_hash.keys.include?(h.commit.id)}
    tags = repo.tags.select{|t| @commits_hash.keys.include?(t.commit.id)}
    start_commits = @commits.select{|c| c.parents.empty? && c.commit.parents.present?}.map(&:id)

    nodes = []
    points = []

    lanes = @lanes.reverse.map{|lane|
      lane.commits.map{|c|
        { :refs=> branches.select{|b| b.commit.id == c.id} + tags.select{|t| t.commit.id == c.id},
          :start    => start_commits.include?(c.id),
          :main_line => @main_commits_ids.include?(c.id),
          :dummy => c.respond_to?(:dummy?),
          :divergence =>
             (c.parents.empty? or c.parents.size > 1 or c.children.empty? or c.children.size > 1) && (not c.respond_to?(:dummy?)),
          :node => c.to_node(node_size)
        } if c
      }
    }

    width = @lanes.map{|lane| lane.commits.size}.max
    lane_heights = [0] + lanes.map{|l|
      (node_size + mergin + 10) + ((l.map{|e|
        e ? [e[:brances].try(:size) || 0 , e[:tags].try(:size) || 0 ].max : 0
      }.max) * 100)
    }

    point_x = 0
    (0..width).each{|x|
      elems = lanes.map{|l| l[x]}
      narrow = (not elems.reject(&:nil?).any?{|e| e[:refs].present? or e[:start] or e[:divergence]} )

      w = narrow ? node_size / 2 : node_size
      point_x += node_size / 2 unless narrow

      elems.each_with_index{|e,y|
        next unless e
        point_y = lane_heights[0..y].sum

        e[:refs].each_with_index{|r,i|
          refs_node = refs_to_node(r)
          refs_y = point_y - ((i + 1) * 85)
          refs_x = point_x
          nodes << refs_node
          points << {:id => refs_node[:id], :x => refs_x, :y => refs_y }
        }

        node = e[:node]

        if e[:start]
          s_id = "s_#{node[:id]}"
          nodes << { :id => s_id,
            :shape => "RECTANGLE",
            :color => "#FFFFFF",
            :labelFontColor => "#2D2D2D",
            :anchor => "right",
            :v_anchor => "middle",
            :borderColor => "#FFFFFF",
            :size => 30,
            :fontsize => 30,
            :label => "more commits..."}

          points <<  {:id => s_id, :x => point_x - 150, :y => point_y }
        end

        if e[:main_line]
          node[:color] = "#FFFFCC"
          node[:borderColor] = "#FF8C00"
        end

        node[:color] = "#DDFFFF" if e[:divergence] or e[:start]
        node[:color] = "#FFDDDD" if e[:refs].present?
        node[:color] = "#CCCCCC" if e[:dummy]

        unless e[:refs].present? or e[:start] or e[:divergence]
          node[:size] = node_size / 2
          node[:v_anchor] = "top"
        end

        nodes << node
        points << {:id => node[:id], :x => point_x, :y => point_y }
      }

      point_x += (w + mergin)
    }

    [nodes, points]
  end

  def to_edges
    ids = @lanes.map(&:commits).flatten.reject(&:nil?).map(&:id)
    branches = repo.heads.select{|h| ids.include?(h.commit.id)}
    tags = repo.tags.select{|t| ids.include?(t.commit.id)}
    refs = branches + tags
    start_commits = @commits.select{|c| c.parents.empty? && c.commit.parents.present? }

    all_commits = @lanes.map(&:commits).flatten.reject(&:nil?)
    all_commits_ids = all_commits.map(&:id)
    all_commits.map{|c|
      c.parents.select{|p| all_commits_ids.include?(p.id)}.map{|p| to_edge(c,p) }
    }.flatten + refs.map{|r| refs_to_edge(r) } + start_commits.map{|c|
      { :id => "s_#{c.short_id}_#{c.short_id}",
        :target => c.short_id, :source => "s_#{c.short_id}",
        :directed => false,
        :color => '#CCCCCC',
        :style => 'DOT'}
    }
  end

  def build
    start_commits = @commits.select{|c| c.parents.empty? }
    @lanes = start_commits.map{|c| Lane.new(nil, c, 0) }

    col = 0

    while @lanes.any?{|l| l.has_next?(col)}
      lanes = @lanes.dup
      lanes.each{|lane| process_lane(col, lane, @lanes) }
      col += 1
    end

    @lanes.each{|lane| lane.close_waiting(col) }
  end

  def process_lane(col, lane, lanes)
    if lane.has_next?(col)
      c = lane.current(col)
      children = c.children.dup
      to_merge_commits, commits = children.partition{|p| find_waiting_lane(lanes, c, p) }

      to_merge_commits.each{|p| find_waiting_lane(lanes, c, p).found_parent(c, col + 1) }

      if commits.present?
        if h = commits.shift
          lane.add(c, h, col)
        end
        commits.each {|p| new_lane(col, c, p, lane, @lanes) }
      else
        lane.close
      end
    end
  end

  def find_waiting_lane(lanes, src, commit)
    lanes.find{|l| l.waiting_for?(src, commit) }
  end

  def new_lane(col, src, commit, lane, lanes)
    pos = lanes.index(lane)
    next_col = col + 1

    next_lane = lanes[(pos + 1)..(lanes.size)].find(&:open?) || lanes[0..pos].reverse.find(&:open?)
    if next_lane
      next_lane.add(src, commit, next_col)
    else
      lanes <<  Lane.new(src, commit, next_col)
    end
  end

  def refs_to_node(r)
    color = nil
    ref_id = nil
    case r
    when Grit::Head
      color = '#FF3333'
      ref_id = "b_#{r.name}"
    when Grit::Tag
      color = '#3333FF'
      ref_id = "t_#{r.name}"
    end

    { :id => ref_id,
      :shape => "RECTANGLE",
      :color => color,
      :labelFontColor => color,
      :borderColor => color,
      :anchor => "left",
      :v_anchor => "middle",
      :size => 30,
      :fontsize => 30,
      :label => r.name }
  end

  def to_edge(src, dst)
    color = @main_commits_ids.include?(src.id) ? '#999999' : '#CCCCCC'
    style = (src.respond_to?(:dummy?) || dst.respond_to?(:dummy) ) ? "DOT" : "SOLID"
    { :id => "#{src.short_id}_#{dst.short_id}",
      :source => src.short_id, :target => dst.short_id,
      :color => color,
      :directed => true,
      :style => style }
  end

  def refs_to_edge(r)
    case r
    when Grit::Head
      ref_id = "b_#{r.name}"
    when Grit::Tag
      ref_id = "t_#{r.name}"
    end
    { :id => "#{ref_id}_#{r.commit.id[0..7]}",
      :target => ref_id, :source => r.commit.id[0..7],
      :directed => false,
      :color => '#CCCCCC',
      :style => 'DOT'}
  end

  class Lane
    attr_accessor :commits

    def initialize(src, commit, offset)
      @commits = Array.new(offset)
      @open = false
      @waiting = nil
      @waiting_for = []
      add(src, commit, offset)
    end

    def to_s
      "#<Lane #{object_id} @open = #{@open} @waiting = #{@waiting} @waiting_for = #{@waiting_for} @commits = #{@commits.size}:last(#{@commits.last}) >"
    end

    def open?
      @open
    end

    def use?
      not @open
    end

    def current(pos)
      open? ? nil : @commits[pos]
    end

    def waiting?
      @waiting && @waiting_for.present?
    end

    def waiting_for?(src, commit)
      @waiting && commit.id == @waiting.id && @waiting_for.include?(src.id)
    end

    def has_next?(col)
      use? and (not waiting?) and current(col)
    end

    def close
      @open = true
    end

    def add(src, commit, col)
      if src && commit.parents.size > 1
        @waiting = commit
        @waiting_for = commit.parents.map(&:id).tap{|xs| xs.delete(src.id)}
      else
        if col > @commits.size
          @commits.fill(nil, @commits.size..(col - 1))
        end
        @commits << commit
      end

      @open = false
    end

    def found_parent(commit, col)
      @waiting_for.delete(commit.id)

      close_waiting(col) if @waiting_for.empty?
    end

    def close_waiting(col)
      if @waiting
        if col > @commits.size
          @commits.fill(nil, @commits.size..(col - 1))
        end
        @commits << @waiting

        @waiting = nil
        @waiting_for = []
      end
    end

  end

end

class DummyCommit < Commit

  attr_reader :branches
  def initialize
    @branches = []
    @parents = []
    @children = []
  end

  def id
    "dummy_#{parents.first.short_id}"
  end

  def short_id
    "dummy_#{parents.first.short_id}"
  end

  def dummy?
    true
  end

  def add_branch(b)
    @branches << b
  end

  def to_node(node_size = 100)
    { :id => id,
      :shape => "TRIANGLE",
      :color => "#F5F5F5",
      :borderColor => "#2D2D2D",
      :labelFontColor => "#2D2D2D",
      :size => node_size ,
      :fontsize => 20,
      :label => "...",
      :anchor => "center",
      :v_anchor => "top",
      :tips => "more commits for #{branches.map(&:name).join(", ")}"
    }
  end
end


