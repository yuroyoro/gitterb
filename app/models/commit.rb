# coding: utf-8

class Commit
  extend Forwardable

  ATTRIBUTES = %w[tree author authored_date committer committed_date message short_message author_string ]

  def_delegators :@commit,*ATTRIBUTES
  attr_reader :commit, :repo, :parents, :children

  def initialize(commit, repo)
    @repo = repo
    @commit = commit
    @parents = []
    @children = []
  end

  def id
    @commit.id
  end

  def eql?(other)
    case other
    when Commit
      id == other.id
    else
      false
    end
  end

  def hash
    id.hash
  end

  def to_s
    "#<Commit:#{short_id} @children = #{@children.size}:#{@children.map(&:short_id)} @parents = #{@parents.size}:#{@parents.map(&:short_id)} >"
  end

  def add_parent(c)
    @parents << c
  end

  def add_child(c)
    @children << c
  end

  def short_id
    id[0..7]
  end

  def middle_id
    id[0..20]
  end

  def setup_parents_and_children
    @parents  = find_parents
    @children = find_children
  end

  def author_name
    author.name.force_encoding('utf-8')
  end

  def committer_name
    committer.name.force_encoding('utf-8')
  end

  def find_parents
    commit.parents.map{|c| Commit.new(c, repo) }
  end

  def find_children
    repo.repo.git.rev_list({:all => true, :parents => true},  %q!|  grep " 1aee0e024f85f6921a61eb3c578f18dcadca170e" | cut -d ' ' -f1!).split("\n").map{|sha_1| repo.commit(sha_1) }
  end

  def stats
    @stats ||= Grit::CommitStats.find_all(repo.repo, id, options = {:m => true, :max_count => 1}).first.last
  end


  def commit_log
    msg = []
    msg << "Commit #{id}"
    msg << "Author: #{author_name} <#{author.email.force_encoding('utf-8')}>"
    msg << "Date:   #{authored_date}"
    msg << ""
    m = message.force_encoding('utf-8').gsub(/"/, "”") rescue message
    m.each_line{|s| msg << "    #{s}" }
    msg.join("\n")
  end

  def to_node(node_size = 100)
    { :id => short_id,
      :sha_1 => id,
      :shape => "ELLIPSE",
      :color => "#F5F5F5",
      :borderColor => "#2D2D2D",
      :labelFontColor => "#2D2D2D",
      :size => node_size,
      :fontsize => 20,
      :label => short_id,
      :anchor => "center",
      :v_anchor => "middle",
      :tips => commit_log
    }
  end

  def diffs
    if commit.parents.empty?
       @commit.diffs.map{|d| CommitDiff.new(d) }
    else
      text = @repo.repo.git.native("diff", {:full_index => true, :C => true}, commit.parents.first.id, id)
      Grit::Diff.list_from_string(commit.repo, text).map{|d| CommitDiff.new(d)}
    end
  end
end
