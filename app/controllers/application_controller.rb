class ApplicationController < ActionController::Base
  protect_from_forgery

  def grit_repo
    return @repo if @repo
    if repo_name = params[:repo]
      @repo = Repository.find(repo_name)
    else
      @repo = Repository.first
    end
  end

end
