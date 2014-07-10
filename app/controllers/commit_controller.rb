class CommitController < ApplicationController
  def show
    sha_1 = params[:id]
    @commit = repository.commit(sha_1).tap{|c| c.setup_parents_and_children } if sha_1

    unless @commit
      render :nothing => true, :status => 404
      return
    end

    render :layout => false
  end
end
