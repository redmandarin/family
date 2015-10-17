# == Schema Information
#
# Table name: connections
#
#  id            :integer          not null, primary key
#  procreator_id :integer
#  baby_id       :integer
#

class Connection < ActiveRecord::Base
  attr_accessor :type, :clan

  belongs_to :procreator, class_name: 'Member'
  belongs_to :baby, class_name: 'Member'

  validates :procreator_id, :baby_id, presence: true

  after_save :set_parent_ancestry
  before_destroy :erase_ancestry

  def self.all_connections(member)
    Connection.where(["procreator_id = ? or baby_id = ?", member.id, member.id])
  end

  private

  def set_parent_ancestry
    self.baby.update_attributes(parent_id: self.procreator_id) if self.procreator.sex == "male"
  end

  def erase_ancestry
    self.baby.update_attributes(parent_id: nil) if self.procreator.sex == "male"
  end
end
