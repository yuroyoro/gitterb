class IndexController < ApplicationController
  def index
    @repo_name = params[:repo] || Repository.first.name
    @branch = params[:branch] || 'master'
    @all = params[:all].nil? ? true : params[:all] != 'false'
    @max_count = params[:max_count].try(:to_i) || 100
    @max_count = 100 unless @max_count > 0
    @branches = repository.branches.map(&:name).sort
  end
end
