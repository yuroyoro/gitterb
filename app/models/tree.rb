require 'grit'

class Tree
  attr_accessor :repo, :commits, :depth, :branches, :nodes, :edges

  def initialize(repository, opts = {})
    @repo = Grit::Repo.new(repository)
    @depth = opts[:depth].try{|n| n.to_a} || 100
    @branches = (opts[:branches].present? ? opts[:branches] : ['master'] ).reject(&:nil?).map{|b| branch_of(b)}
    @commits = @branches.inject({}){|h,b|
      @repo.commits(b.name, @depth).each{|c| h[c.id] ||= c}
      h
    }

    nodes_and_edges

  end

  def branch_of(branch_name)
    @repo.get_head(branch_name)
  end

  private

  def to_node(commit)
    { :id => commit.id,
      :shape => "ELLIPSE",
      :color => "#F5F5F5",
      :size => 100,
      :fontsize => 20,
      :label => commit.id[0..7],
      :anchor => "center",
      :tips => commit_log(commit) }
  end

  def branch_to_node(b)
    { :id => b.name,
      :shape => "RECTANGLE",
      :color => "#333333",
      :anchor => "left",
      :size => 30,
      :fontsize => 30,
      :label => b.name }
  end

  def to_edge(src, dst)
    { :id => "#{src.id[0..7]}_#{dst.id[0..7]}",
      :source => src.id, :target => dst.id ,
      :directed => true,
      :style => 'SOLID' }
  end

  def branch_to_edge(b)
    { :id => "#{b.name}_#{b.commit.id[0..7]}",
      :target => b.name, :source => b.commit.id ,
      :directed => false,
      :style => 'DOT'}
  end

  def commit_log(commit)
    msg = []
    msg << "commit #{commit.id}"
    msg << "Author: #{commit.committer.name.force_encoding('utf-8')} <#{commit.committer.email.force_encoding('utf-8')}>"
    msg << "Date:   #{commit.committed_date}"
    msg << ""
    commit.message.force_encoding('utf-8').each_line{|s| msg << "    #{s}" }
    msg.join("\n")
  end

  def nodes_and_edges
    @nodes = []
    @edges = []
    dummy = []

    cms = @commits.values.sort_by{|c| c.committed_date}

    @nodes +=  cms.map{|c| to_node(c)}
    @edges +=  cms.map{|c| c.parents.map{|p|
      if @commits.keys.include?(p.id)
        to_edge(c, p)
      else
        unless c.parents.size > 1
          n = dummy.size
          dummy << {
              :id => "dummy_#{n}",
              :shape => "ELLIPSE",
              :color => "#333333",
              :anchor => "left",
              :size => 30,
              :opacity => 0,
              :fontsize => 30,
              :label => "dummy_#{n}"
            }
          {
            :id => "#{c.id[0..7]}_dummy_#{n}",
            :target => c.id, :source=> "dummy_#{n}",
            :opacity => 0,
            :directed => true,
            :style => 'SOLID'
          }
        end
      end
    }}.flatten.reject(&:nil?)

    @branches.each{|b|
      @nodes << branch_to_node(b)
      @edges << branch_to_edge(b)
    }

    branch_names = @branches.map(&:name)
    other_branches = @repo.heads.reject{|h| branch_names.include?(h.name)}.select{|h| @commits.include?(h.commit.id) }
    other_branches.each{|b|
      @nodes << branch_to_node(b)
      @edges << branch_to_edge(b)
    }
    @nodes += dummy
  end

end


