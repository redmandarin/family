class Connection < ActiveRecord::Base
  belongs_to :parent, class_name: 'Member'
  belongs_to :child, class_name: 'Member'

  validates :parent_id, :child_id, presence: true
end
