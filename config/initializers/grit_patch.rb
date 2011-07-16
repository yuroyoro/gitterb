Grit.debug = true
puts "grit patching"

module Grit
  class Git
    def options_to_argv(options)
    argv = []
    options.sort_by{|k| k.to_s.length}.each do |key, val|
      if key.to_s.size == 1
        if val == true
          argv << "-#{key}"
        elsif val == false
          # ignore
        else
          argv << "-#{key}"
          argv << val.to_s
        end
      else
        if val == true
          argv << "--#{key.to_s.tr('_', '-')}"
        elsif val == false
          # ignore
        else
          argv << "--#{key.to_s.tr('_', '-')}=#{val}"
        end
      end
    end
    argv
    end
  end
end
