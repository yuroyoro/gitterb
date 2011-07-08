class ApplicationController < ActionController::Base
  protect_from_forgery

  def repository_path
    Gitterb::Application::REPOSITORY
  end

  def grit_repo
    @repo ||= Grit::Repo.new(repository_path)
    @repo
  end

end
