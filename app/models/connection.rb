class Connection < ActiveRecord::Base
  belongs_to :parent, class_name: 'Member'
  belongs_to :child, class_name: 'Member'

  validates :parent_id, :child_id, presence: true

  def self.all_connections(member)
    Connection.where(["parent_id = ? or child_id = ?", member.id, member.id])
  end
end
