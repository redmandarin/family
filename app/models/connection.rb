class Connection < ActiveRecord::Base
  attr_accessor :type
  
  belongs_to :procreator, class_name: 'Member'
  belongs_to :baby, class_name: 'Member'

  validates :procreator_id, :baby_id, presence: true

  def self.all_connections(member)
    Connection.where(["procreator_id = ? or baby_id = ?", member.id, member.id])
  end
end
