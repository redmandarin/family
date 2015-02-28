class Member < ActiveRecord::Base

  has_many :connections, foreign_key: 'parent_id', dependent: :destroy
  has_many :children, through: :connections
  has_many :reverse_connections, class_name: 'Connection', foreign_key: 'child_id', dependent: :destroy
  has_many :parents, through: :reverse_connections
  belongs_to :partner, class_name: "Member"

  validates :first_name, :last_name, :birth_date, :sex, presence: true
end
