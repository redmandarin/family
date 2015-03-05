class Member < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  enum sex: [:male, :female]

  has_many :connections, foreign_key: 'parent_id', dependent: :destroy
  has_many :children, through: :connections
  has_many :reverse_connections, class_name: 'Connection', foreign_key: 'child_id', dependent: :destroy
  has_many :parents, through: :reverse_connections
  belongs_to :partner, class_name: "Member"

  validates :first_name, :last_name, :birth_date, :sex, presence: true

  def full_name
    full_name = self.first_name + " " + self.middle_name + " " + self.last_name
    full_name.mb_chars.split(" ").map(&:capitalize).join(" ")
  end
end
