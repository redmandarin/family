# == Schema Information
#
# Table name: clans
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Clan < ActiveRecord::Base
  has_many :userships, as: :usershipable
  has_many :users, through: :userships
  has_many :memberships, as: :membershipable
  has_many :members, through: :memberships
  has_many :articles

  validates :name, presence: true

  resourcify

  def has_member_or_user?(user)
    self.members.include?(user) || self.users.include?(user)
  end
end
