# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  clan_id    :integer
#

class Article < ActiveRecord::Base
  has_many :memberships, as: :membershipable
  has_many :members, through: :memberships
  belongs_to :user
  belongs_to :clan

  validates :title, :body, :user_id, presence: true
end
