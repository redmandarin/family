class Article < ActiveRecord::Base
  has_many :memberships, as: :membershipable
  has_many :members, through: :memberships
  belongs_to :user

  validates :title, :body, :user_id, presence: true
end