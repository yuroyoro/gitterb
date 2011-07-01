
class TreeController < ApplicationController

  def index
    path = REPOSITORY_PATH
    # branches = ['20110613m',  'ticket/id/1619_qrcode','ticket/id/1621', 'spike/apply_design', 'ticket/id/1544_CPC_log_api', 'master']

    tree = Tree.new(path)

    respond_to do |format|
      format.json { render :json => { :nodes => tree.nodes, :edges => tree.edges }.to_json }
    end
  end

end
