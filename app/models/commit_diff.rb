require 'diff/lcs'

class CommitDiff
  extend Forwardable

  attr_reader :patch, :delta, :additions, :deletions

  def initialize(patch)
    @patch = patch
    @delta = patch.delta
    @additions, @deletions = patch.stat
  end

  def raw_diff
    @diff.diff
  end

  def total
    additions +  deletions
  end

  def status
    delta.status
  end

  def a_path
    delta.old_file[:path]
  end

  def b_path
    delta.new_file[:path]
  end

  def status_str
    if status == :removed
      "D"
    else
      status.to_s.upcase[0]
    end
  end

  def pathname
    return a_path unless status == :renamed

    "{#{a_path} -> #{b_path}}"
  end

end
