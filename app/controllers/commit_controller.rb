class CommitController < ApplicationController
  def show
    sha_1 = params[:id]
    @commit = Commit.new(grit_repo.commit(sha_1))

    render :layout => false
  end
end
