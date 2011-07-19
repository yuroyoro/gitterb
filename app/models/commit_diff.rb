require 'diff/lcs'

class CommitDiff
  extend Forwardable

  ATTRIBUTES = %w[ a_path b_path a_blob b_blob a_mode b_mode new_file deleted_file renamed_file similarity_index ]
  def_delegators :@diff, *ATTRIBUTES

  attr_reader :lines, :additions, :deletions

  def initialize(diff)
    @diff = diff
    @lines, @additions, @deletions  = parse(diff.diff)
  end

  def raw_diff
    @diff.diff
  end

  def total
    @additions + @deletions
  end

  def status
    if renamed_file
      :renamed
    elsif new_file
      :added
    elsif deleted_file
      :removed
    else
      :modified
    end
  end

  def status_str
    if status == :removed
      "D"
    else
      status.upcase[0]
    end
  end

  def pathname
    return a_path unless status == :renamed

    lcs_diff = Diff::LCS.sdiff(a_path, b_path)

    diff_list = [[]]

    lcs_diff.each do |d|
      if d.action == '=' && d.old_element == '/' && d.new_element == '/'
        diff_list << []
      else
        diff_list.last << d
      end
    end

    diff_list.map{|dl|
      if dl.find{|d| d.action != '='}
        old = dl.map{|d| d.old_element }.join('')
        new = dl.map{|d| d.new_element }.join('')
        "{#{old} -> #{new}}"
      else
        dl.map{|d| d.old_element }.join('')
      end
    }.join("/")
  end

  Line = Struct.new(:num_l, :num_r, :line, :mode)

  private
  def parse(diff)
    line_num_l = $2.to_i
    line_num_r = $5.to_i

    a = d = 0
    l = []
    parsing = false
    diff.lines.each do |line|
      if line =~ /^@@ (\+|\-)(\d+)(,\d+)? (\+|\-)(\d+)(,\d+)? @@.*$/
        line_num_l = $2.to_i
        line_num_r = $5.to_i
        l << Line.new(nil, nil, line.chomp, :sep)
        parsing = true
      elsif parsing
        if line[0, 1] == "+"
          line_num_r += 1
          l << Line.new(nil, line_num_r, line.chomp, :add)
          a += 1
        elsif line[0, 1] == "-"
          line_num_l += 1
          l << Line.new( line_num_l, nil, line.chomp, :del )
          d += 1
        else
          line_num_r += 1
          line_num_l += 1
          l << Line.new(line_num_l,line_num_r, line.chomp, :eq)
        end
      end
    end
    [l, a, d]
  end

end
