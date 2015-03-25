class ConnectionsController < ApplicationController
  before_action :set_member
  before_action :authenticate_user!, except: :index

  authorize_resource

  respond_to :html

  def index
    @parents = @member.procreators
    @children = @member.babies
    respond_with(@parents, @children) 
  end

  def new
    respond_with(@connection = Connection.new)
  end
  
  def create
    new_params = connection_params[:baby_id] ? { procreator_id: @member.id } : { baby_id: @member.id }
    @connection = Connection.create(connection_params.merge(new_params))
    respond_with @connection, location: -> { member_connections_path(@member) }
  end

  def destroy
    @connection = Connection.find(params[:id])
    respond_with(@connection.destroy, location: -> { member_connections_path(@member) })
  end

  private
  def connection_params
    params.require(:connection).permit(:procreator_id, :baby_id)
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
