require 'grit'

class Tree

  attr_accessor :repo, :commits, :max_count, :branch, :target_branch_name,  :nodes, :edges, :points

  def initialize(repository, target_branch_name = 'master',  opts = {})
    @repo = Grit::Repo.new(repository)
    @max_count= opts[:max_count] || 300
    @max_count = false if max_count < 0
    @target_branch_name  = target_branch_name
    @branch = branch_of(@target_branch_name)
    @branches = (opts[:brances] || []).map{|b| branch_of(b)}

    @commits = repo.commits(@target_branch_name, @max_count).map{|c| Commit.new(c) }.reverse
    @commits_hash = @commits.inject({}){|h,c| h[c.id] = c;h}
    @commits.each{|c|
      parents = c.commit.parents.map{|p| @commits_hash[p.id]}.reject(&:nil?)
      parents.each{|p| c.add_parent(p) }
      parents.each{|p| p.add_child(c) }
    }

    branches_commits = {}
    @branches.each{|b|
      merge_base = @repo.git.merge_base({}, @target_branch_name, b.name).chomp
      next unless @commits_hash.keys.include?(merge_base)

      @repo.commits_between(merge_base, b.name).map{|c| Commit.new(c)}.each{|c|
        branches_commits[c.id] ||= c
      }
    }
    @commits += branches_commits.values
    branches_commits.values.each{|c| @commits_hash[c.id] = c }
    branches_commits.values.each{|c|
      parents = c.commit.parents.map{|p| @commits_hash[p.id]}.reject(&:nil?)
      parents.each{|p| c.add_parent(p) }
      parents.each{|p| p.add_child(c) }
    }

    build
    @nodes, @points = to_nodes_and_points(opts)
    @edges = to_edges
  end

  def branch_of(branch_name)
    @repo.get_head(branch_name)
  end

  private

  def to_nodes_and_points(opts = {})
    node_size = opts[:node_size].try(&:to_i) || 100
    mergin = opts[:mergin].try(&:to_i) ||  50
    branches = repo.heads.select{|h| @commits_hash.keys.include?(h.commit.id)}
    branch_lane_count = 0
    start_commits = @commits.select{|c| c.parents.empty? }.map(&:id)

    nodes = []
    points = []

    @lanes.each_with_index do |lane,y|
      branch_count = lane.commits.reject(&:nil?).map{|c| branches.select{|b| b.commit.id == c.id}.size }.max || 0
      lane.commits.each_with_index do |c, x|
        next unless c

        point_y = y * (node_size + mergin) + (branch_lane_count * 40)
        point_x = x * (node_size + mergin)

        branches.select{|b| b.commit.id == c.id}.each_with_index{|b,i|
          branch_node = branch_to_node(b)
          branch_y = point_y - ((i + 1) * 100)
          branch_x = point_x
          nodes << branch_node
          points << {:id => branch_node[:id], :x => branch_x, :y => branch_y }
        }

        node = c.to_node
        nodes << node
        points << {:id => c.short_id, :x => point_x, :y => point_y }

        if start_commits.include?(c.id)
          s_id = "s_#{c.short_id}"
          nodes << { :id => s_id,
            :shape => "RECTANGLE",
            :color => "#FFFFFF",
            :anchor => "right",
            :borderColor => "#FFFFFF",
            :size => 30,
            :fontsize => 30,
            :label => "more commits..."}

          points <<  {:id => s_id, :x => point_x - 150, :y => point_y }
        end
      end
      branch_lane_count += branch_count
    end

    [nodes, points]
  end

  def to_edges
    ids = @lanes.map(&:commits).flatten.reject(&:nil?).map(&:id)
    branches = repo.heads.select{|h| ids.include?(h.commit.id)}
    start_commits = @commits.select{|c| c.parents.empty? }

    all_commits = @lanes.map(&:commits).flatten.reject(&:nil?)
    all_commits_ids = all_commits.map(&:id)
    all_commits.map{|c|
      c.parents.select{|p| all_commits_ids.include?(p.id)}.map{|p| to_edge(c,p) }
    }.flatten + branches.map{|b| branch_to_edge(b) } + start_commits.map{|c|
      { :id => "s_#{c.short_id}_#{c.short_id}",
        :target => c.short_id, :source => "s_#{c.short_id}",
        :directed => false,
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

    if next_lane = lanes[(pos + 1)..(lanes.size)].find(&:open?)
      next_lane.add(src, commit, next_col)
    else
      lanes <<  Lane.new(src, commit, next_col)
    end
  end

  def branch_to_node(b)
    { :id => b.name,
      :shape => "RECTANGLE",
      :color => "#333333",
      :borderColor => "#2D2D2D",
      :anchor => "left",
      :size => 30,
      :fontsize => 30,
      :label => b.name }
  end

  def to_edge(src, dst)
    { :id => "#{src.id[0..7]}_#{dst.id[0..7]}",
      :source => src.short_id, :target => dst.short_id,
      :directed => true,
      :style => 'SOLID' }
  end

  def branch_to_edge(b)
    { :id => "#{b.name}_#{b.commit.id[0..7]}",
      :target => b.name, :source => b.commit.id[0..7],
      :directed => false,
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


