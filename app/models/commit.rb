require 'albino'

class Commit
  extend Forwardable

  ATTRIBUTES = %w[ id repo tree diffs author authored_date committer committed_date message short_message author_string]

  def_delegators :@commit,*ATTRIBUTES
  attr_reader :commit, :parents, :children

  def initialize(commit)
    @commit = commit
    @parents = []
    @children = []
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

  def commit_log
    msg = []
    msg << "Commit #{id}"
    msg << "Author: #{committer.name.force_encoding('utf-8')} <#{committer.email.force_encoding('utf-8')}>"
    msg << "Date:   #{committed_date}"
    msg << ""
    message.force_encoding('utf-8').each_line{|s| msg << "    #{s}" }
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

  def diff_htmls
    diffs.map{|diff| self.to_diff_html(diff) }
  end

  def self.to_diff_html(diff)
    Albino.colorize(diff.diff, :diff).sub(/<pre><span/, "<pre>\n<span")
  end

end
