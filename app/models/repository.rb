class Repository
  extend Forwardable

  ATTRIBUTES = %w[git head heads get_head is_head? tags refs ]

  def_delegators :@repo,*ATTRIBUTES

  attr_reader :repo, :path, :name

  def initialize(path, name = nil)
    @path = path
    @repo ||= Grit::Repo.new(path)
    @name = name || File.basename(path)
  end

  def self.repo_names
    config.map{|path, name| name || File.basename(path)}
  end

  def self.config
    @config = Gitterb::Application.repositories
  end

  def self.find(repo_name)
    path, name = config.find{|path, name| repo_name == name}
    Repository.new(path, name) if path
  end

  def self.first
    path, name = config.first
    Repository.new(path, name)
  end

  def self.find_all
    config.map{|path, name| Repository.new(path, name) }
  end

  def branches
    @repo.heads.map(&:name).sort
  end

  def commit(sha_1)
    Commit.new(@repo.commit(sha_1))
  end

  def commits(start = 'master', max_count = 10, skip = 0)
    @repo.commits(start, max_count, skip).map{|c| Commit.new(c)}
  end

  def commits_between(from, to)
    @repo.commits_between(from, to).map{|c| Commit.new(c)}
  end

end
