
class TreeController < ApplicationController

  def index
    path = REPOSITORY_PATH
    branch = params[:branch] || 'master'
    tree = Tree.new(path, branch, {:brances => ['20110613m', 'ticket/id/1621', 'spike/apply_design']})

    res = {
      :target_branch => tree.target_branch_name,
      :data =>{ :nodes => tree.nodes, :edges => tree.edges },
      :points => tree.points }

    respond_to do |format|
      format.json { render :json => res.to_json }
    end
  end

end
