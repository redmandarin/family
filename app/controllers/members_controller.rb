class MembersController < ApplicationController
  before_action :set_member, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  authorize_resource

  def index
    respond_with(@members = Member.all)
  end

  def new
    respond_with(@member = Member.new)
  end
  
  def create
    respond_with(@member = Member.create(member_params))
  end

  def show
    respond_with(@member = Member.find(params[:id]))
  end

  def edit
  end

  def update
    @member.update(member_params)
    respond_with(@member)
  end

  def destroy
    respond_with(@member.destroy)
  end

private
  def member_params
    params.require(:member).permit(:first_name, :last_name, :middle_name, :sex, :birth_date, :death_date, :partner_id, :image)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
