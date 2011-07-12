class CommitController < ApplicationController
  def show
    sha_1 = params[:id]
    @commit = grit_repo.commit(sha_1) if sha_1

    unless @commit
      render :nothing => true, :status => 404
      return
    end

    render :layout => false
  end
end
