class Repository
  extend Forwardable

  ATTRIBUTES = %w[git head heads get_head is_head? refs ]

  def_delegators :@repo,*ATTRIBUTES

  attr_reader :repo, :path, :name, :ticket_url, :rev_url, :file_url

  def initialize(path, opts = {})
    @path = path
    @repo ||= Rugged::Repository.new(path)
    @name = opts[:name] || File.basename(path)
    @ticket_url = opts[:ticket_url]
    @rev_url = opts[:rev_url]
    @file_url = opts[:file_url]
  end

  def self.repos
    return @repos if @repos
    @repos = Gitterb::Application.repositories.map{|path, opts| Repository.new(path, opts) }
  end

  def self.repo_names
    repos.map(&:name)
  end

  def self.find(repo_name)
    repos.find{|r| r.name == repo_name }
  end

  def self.first
    repos.first
  end

  def self.find_all
    repos
  end

  def tags
    repo.tags
  end

  def branches
    repo.branches.to_a.reject{|b| b.target.class == Rugged::Reference }
  end

  def branche_names
    branches.map(&:name).sort
  end

  def branche_of(name)
    repo.branches[name]
  end

  def commit(sha_1)
    c = @repo.lookup(sha_1)
    Commit.new(c, self) if c
  end

  def commits(start = 'master', max_count = 10, skip = 0)
    i = 0
    res = []
    walker =  Rugged::Walker.new(repo)
    walker.push(start)

    walker.each {|c|
      i = i + 1
      puts "#{i} : #{c.oid} #{c.message}"
      next  if i - 1 < skip
      break if res.length > max_count
      res << Commit.new(c, self)
    }

    return res
  end

  def commits_between(from, to)
    res = []
    walker =  Rugged::Walker.new(repo)
    walker.push(from)

    walker.each {|c|
      res << Commit.new(c, self)
      break if c.oid == to
    }

    return res
  end

end
