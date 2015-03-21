class Connection < ActiveRecord::Base
  attr_accessor :type
  
  belongs_to :procreator, class_name: 'Member'
  belongs_to :baby, class_name: 'Member'

  validates :procreator_id, :baby_id, presence: true

  after_save :set_parent_ancestry

  def self.all_connections(member)
    Connection.where(["procreator_id = ? or baby_id = ?", member.id, member.id])
  end

  private

  def set_parent_ancestry
    self.baby.update_attributes(parent_id: self.procreator_id)  
  end
end
