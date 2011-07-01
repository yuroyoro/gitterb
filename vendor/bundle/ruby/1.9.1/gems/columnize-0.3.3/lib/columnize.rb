#   Copyright (C) 2007, 2008, 2009, 2010, 2011 Rocky Bernstein
#   <rockyb@rubyforge.net>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#    02110-1301 USA.
#

# Author::    Rocky Bernstein  (mailto:rockyb@rubyforge.net)
#
# = Columnize
# Module to format an Array as an Array of String aligned in columns.
#
# == SYNOPSIS
# Display a list of strings as a compact set of columns.
#
#   For example, for a line width of 4 characters (arranged vertically):
#        ['1', '2,', '3', '4'] => '1  3\n2  4\n'
#   
#    or arranged horizontally:
#        ['1', '2,', '3', '4'] => '1  2\n3  4\n'
#        
# Each column is only as wide as necessary.  By default, columns are
# separated by two spaces (one was not legible enough).  


# Adapted from
# the routine of the same name in cmd.py

module Columnize

  DEFAULT_OPTS = {
    :displaywidth      => 80,
    :colsep            => '  ',
    :ljust             => true,
    :lineprefix        => '',
    :arrange_vertical  => true
  }

  module_function
  def parse_columnize_options(args)
    list = args.shift
    if 1 == args.size && args[0].kind_of?(Hash)
      return list, DEFAULT_OPTS.merge(args[0])
    else      
      opts = DEFAULT_OPTS.dup
      %w(displaywidth colsep arrange_vertical ljust lineprefix).each do |field|
        break if args.empty?
        opts[field.to_sym] = args.shift
      end
      return list, opts
    end
  end

  # Return a list of strings with embedded newlines (\n) as a compact
  # set of columns arranged horizontally or vertically.
  #
  # For example, for a line width of 4 characters (arranged vertically):
  #     ['1', '2,', '3', '4'] => '1  3\n2  4\n'
   
  # or arranged horizontally:
  #     ['1', '2,', '3', '4'] => '1  2\n3  4\n'
  #     
  # Each column is only as wide possible, no larger than
  # +displaywidth'.  If +list+ is not an array, the empty string, '',
  # is returned. By default, columns are separated by two spaces - one
  # was not legible enough. Set +colsep+ to adjust the string separate
  # columns. If +arrange_vertical+ is set false, consecutive items
  # will go across, left to right, top to bottom.

  def columnize(*args)

    list, opts = parse_columnize_options(args)
    # Some degenerate cases
    if not list.is_a?(Array)
      return ''
    end
    if list.size == 0
      return  "<empty>\n"
    end
    l = list.map{|li| li.to_s}
    if 1 == l.size
      return "#{l[0]}\n"
    end

    nrows = ncols = 0  # Make nrows, ncols have more global scope
    colwidths = []     # Same for colwidths
    opts[:displaywidth] = [4, opts[:displaywidth] - opts[:lineprefix].length].max
    if opts[:arrange_vertical]
      array_index = lambda {|num_rows, row, col| num_rows*col + row }
      # Try every row count from 1 upwards
      1.upto(l.size-1) do |_nrows|
        nrows = _nrows
        ncols = (l.size + nrows-1) / nrows
        colwidths = []
        totwidth = -opts[:colsep].length

        0.upto(ncols-1) do |_col|
          col = _col
          # get max column width for this column
          colwidth = 0
          0.upto(nrows-1) do |_row|
            row = _row
            i = array_index.call(nrows, row, col)
            if i >= l.size
              break
            end
            colwidth = [colwidth, l[i].size].max
          end
          colwidths << colwidth
          totwidth += colwidth + opts[:colsep].length
          if totwidth > opts[:displaywidth]
            ncols = col
            break
          end
        end
        if totwidth <= opts[:displaywidth]
          break
        end
      end
      # The smallest number of rows computed and the
      # max widths for each column has been obtained.
      # Now we just have to format each of the
      # rows.
      s = ''
      0.upto(nrows-1) do |_row| 
        row = _row
        texts = []
        0.upto(ncols-1) do |_col|
          col = _col
          i = array_index.call(nrows, row, col)
          if i >= l.size
            x = ""
          else
            x = l[i]
          end
          texts << x
        end
        while texts and texts[-1] == ''
          texts = texts[0..-2]
        end
        if texts.size > 0
          0.upto(texts.size-1) do |_col|
            col = _col
            if opts[:ljust]
                texts[col] = texts[col].ljust(colwidths[col])
            else
                texts[col] = texts[col].rjust(colwidths[col])
            end
          end
          s += "%s%s\n" % [opts[:lineprefix], texts.join(opts[:colsep])]
        end
      end
      return s
    else
      array_index = lambda {|num_rows, row, col| ncols*(row-1) + col }
      # Try every column count from size downwards
      # Assign to make enlarge scope of loop variables 
      totwidth = i = rounded_size = 0  
      l.size.downto(0) do |_ncols|
        ncols = _ncols
        # Try every row count from 1 upwards
        min_rows = (l.size+ncols-1) / ncols
        min_rows.upto(l.size) do |_nrows|
          nrows = _nrows
          rounded_size = nrows * ncols
          colwidths = []
          totwidth = -opts[:colsep].length
          colwidth = row = 0
          0.upto(ncols-1) do |_col|
            col = _col
            # get max column width for this column
            1.upto(nrows) do |_row|
              row = _row
              i = array_index.call(nrows, row, col)
              if i >= rounded_size 
                break
              elsif i < l.size
                colwidth = [colwidth, l[i].size].max
              end
            end
            colwidths << colwidth
            totwidth += colwidth + opts[:colsep].length
            if totwidth > opts[:displaywidth]
              break
            end
          end
          if totwidth <= opts[:displaywidth]
            # Found the right nrows and ncols
            nrows  = row
            break
          elsif totwidth >= opts[:displaywidth]
            # Need to reduce ncols
            break
          end
        end
        if totwidth <= opts[:displaywidth] and i >= rounded_size-1
            break
        end
      end
      # The smallest number of rows computed and the
      # max widths for each column has been obtained.
      # Now we just have to format each of the
      # rows.
      s = ''
      1.upto(nrows) do |row| 
        texts = []
        0.upto(ncols-1) do |col|
          i = array_index.call(nrows, row, col)
          if i >= l.size
            break
          else
            x = l[i]
          end
          texts << x
        end
        0.upto(texts.size-1) do |col|
          if opts[:ljust]
            texts[col] = texts[col].ljust(colwidths[col])
          else
            texts[col] = texts[col].rjust(colwidths[col])
          end
        end
        s += "%s%s\n" % [opts[:lineprefix], texts.join(opts[:colsep])]
      end
      return s
    end
  end
end
if __FILE__ == $0
  #
  include Columnize
  
  [[4, 4], [4, 7], [100, 80]].each do |width, num|
    data = (1..num).map{|i| i.to_s}
    [[false, 'horizontal'], [true, 'vertical']].each do |bool, dir|
      puts "Width: #{width}, direction: #{dir}"
      print columnize(data, width, '  ', arrange_vertical=bool)
      end
  end

  puts Columnize::columnize(5)
  puts columnize([])
  puts columnize(["a", 2, "c"], 10, ', ')
  puts columnize(["oneitem"])
  puts columnize(["one", "two", "three"])
  data = ["one",       "two",         "three",
          "for",       "five",        "six",
          "seven",     "eight",       "nine",
          "ten",       "eleven",      "twelve",
          "thirteen",  "fourteen",    "fifteen",
          "sixteen",   "seventeen",   "eightteen",
          "nineteen",  "twenty",      "twentyone",
          "twentytwo", "twentythree", "twentyfour",
          "twentyfive","twentysix",   "twentyseven"]
  
  puts columnize(data)
  puts columnize(data, 80, '  ', false)
end
