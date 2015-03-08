class ConnectionsController < ApplicationController
  before_action :authenticate_user!, except: :index

  authorize_resource
  respond_to :html, :js

  def index
    @connections = Connection.all_connections(Member.find(params[:member_id]))
  end
  
  def create
    new_param = connection_params[:parent_id] ? { child_id: params[:member_id] } :  { parent_id: params[:member_id] }
    Connection.create(connection_params.merge(new_param))
    respond_with(@connection)
  end

  def destroy
    @connection = Connection.find(params[:id])
    respond_with(@connection.destroy)
  end

  private
  def connection_params
    params.require(:connection).permit(:parent_id, :child_id)
  end
end
