class Member < ActiveRecord::Base

  has_many :connections, foreign_key: 'parent_id', dependent: :destroy
  has_many :children, through: :connections
  has_many :reverse_connections, class_name: 'Connection', foreign_key: 'child_id', dependent: :destroy
  has_many :parents, through: :reverse_connections

  validates :first_name, :last_name, :birth_date, :sex, presence: true
end
