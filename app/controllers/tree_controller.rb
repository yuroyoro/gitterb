
class TreeController < ApplicationController

  def index
    branch = params[:branch] || 'master'
    all = params[:all].nil? ? true : params[:all] != 'false'
    max_count = params[:max_count].try(:to_i) || 100
    max_count = 100 unless max_count > 0

    tree = Tree.new(grit_repo, branch, :all => all, :max_count => max_count)

    res = {
      :target_branch => tree.target_branch_name,
      :data =>{ :nodes => tree.nodes, :edges => tree.edges },
      :points => tree.points }

    respond_to do |format|
      format.json { render :json => res.to_json }
    end
  end

end
