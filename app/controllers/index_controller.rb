class IndexController < ApplicationController
  def index
    @branch = params[:branch] || 'master'
    @all = params[:all].nil? ? true : params[:all]
    @max_count = params[:max_count].try(:to_i) || 100
    @max_count = 100 unless @max_count > 0
    @branches = grit_repo.heads.map(&:name)
  end
end
