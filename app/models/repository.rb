class Repository
  extend Forwardable

  ATTRIBUTES = %w[git head heads get_head is_head? tags refs ]

  def_delegators :@repo,*ATTRIBUTES

  attr_reader :repo, :path, :name, :ticket_url, :rev_url, :file_url

  def initialize(path, opts = {})
    @path = path
    @repo ||= Grit::Repo.new(path)
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

  def branches
    @repo.heads.map(&:name).sort
  end

  def commit(sha_1)
    c = @repo.commit(sha_1)
    Commit.new(c, self) if c
  end

  def commits(start = 'master', max_count = 10, skip = 0)
    @repo.commits(start, max_count, skip).map{|c| Commit.new(c, self)}
  end

  def commits_between(from, to)
    @repo.commits_between(from, to).map{|c| Commit.new(c, self)}
  end

end
