module CommitHelper

  def gravator_link(commit, type = :author)
    "http://www.gravatar.com/avatar/#{Digest::MD5.new.update(commit.send(type).email).to_s}.png"
  end

  def time_ago_in_words(time)
    a = (Time.now - time).to_i

    case a
      when 0              then return 'just now'
      when 1              then return 'a second ago'
      when 2..59          then return a.to_s + ' seconds ago'
      when 60..119        then return 'a minute ago'
      when 120..3540      then return (a/60).to_i.to_s + 'minutes ago'
      when 3541..7100     then return 'an hour ago'
      when 7101..82800    then return ((a+99)/3600).to_i.to_s + ' hours ago'
      when 82801..172000  then return 'a day ago'
      when 172001..432000 then return ((a+800)/(60*60*24)).to_i.to_s + ' days ago'
    end

    time
  end

  def message_with_link(commit)
    message = commit.message
    repo = commit.repo
    msg = []
    message.force_encoding('utf-8').each_line{|s|
      msg << s.gsub(/ #(\d+) /){|v| link_to_issue(commit, $1)}
    }
    msg.join("\n")
  end

  def commit_log_with_link(commit)
    repo = commit.repo
    id = commit.id

    msg = []
    msg << "Commit #{link_to_commit(commit)}"
    msg << "Author: #{commit.committer.name.force_encoding('utf-8')} <#{commit.committer.email.force_encoding('utf-8')}>"
    msg << "Date:   #{commit.committed_date}"
    msg << ""
    msg << message_with_link(commit)
    msg.join("\n")
  end

  def link_to_commit(commit, length = nil, options = {})
    c_id = length.nil? ? commit.id : commit.id[0..length]
    if commit.repo.rev_url
      link_to c_id, commit.repo.rev_url % [c_id], options.merge({:target => "_blank"})
    else
      c_id
    end
  end

  def link_to_issue(commit, issue)
    if commit.repo.ticket_url
      link_to issue, commit.repo.ticket_url % [issue], {:target => "_blank"}
    else
      issue
    end
  end

  def link_to_file(commit, path, name = nil)
    name = path unless name
    if commit.repo.file_url
      link_to name , commit.repo.file_url % [commit.id, path], {:target => "_blank"}
    else
      name
    end
  end

  def commit_explain(commit)
    diffs = commit.diffs
    additions = diffs.map(&:additions).sum
    deletions = diffs.map(&:deletions).sum
    "Showing #{diffs.size} changed file#{diffs.size == 1 ? "" : "s"} with " +
      [ additions > 0 ? "#{additions.to_s} addition#{additions == 1 ? "" : "s"}" : nil,
        deletions > 0 ? "#{deletions.to_s} deletion#{deletions == 1 ? "" : "s"}" : nil].reject(&:nil?).join(" and ") + "."
  end

  def diffstat_bar(diff)
    return [0, 0] if diff.total == 0
    [(diff.additions * 100 /diff.total) / 20, (diff.deletions * 100 /diff.total) / 20 ]
  end

  def to_line_num_l(line)
    if line.mode == :sep
      "..."
    else
      line.num_l ? line.num_l : ""
    end
  end

  def to_line_num_r(line)
    if line.mode == :sep
      "..."
    else
      line.num_r ? line.num_r : ""
    end
  end

  def to_html_line(line)

    l = CGI.escapeHTML(line.line.force_encoding('utf-8'))
    case line.mode
    when :sep
      "<div class='gc'>#{l}</div>"
    when :add
      "<div class='gi'>#{l}</div>"
    when :del
      "<div class='gd'>#{l}</div>"
    else
      "<div>#{l}</div>"
    end
  end

  def envelope_title(text)
    s = "<span>#{text[0]}</span>#{text[1..text.length]}"
    s + ("&nbsp;" * (7 - text.length))
  end

end

