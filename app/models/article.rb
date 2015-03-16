class Article < ActiveRecord::Base
  has_and_belongs_to_many :members
  belongs_to :user

  validates :title, :body, :user_id, presence: true
end
