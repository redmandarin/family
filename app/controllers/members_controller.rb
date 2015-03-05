class MembersController < ApplicationController
  before_action :set_member, only: [:edit]
  respond_to :html

  def new
    @member = Member.new
  end
  
  def create
    respond_with(@member = Member.create(member_params))
  end

  def show
    respond_with(@member = Member.find(params[:id]))
  end

  def edit
  end

private
  def member_params
    params.require(:member).permit(:first_name, :last_name, :middle_name, :sex, :birth_date, :death_date, :partner_id, :image)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
