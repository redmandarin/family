class Member < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  enum sex: [:male, :female]

  belongs_to :partner, class_name: "Member"

  has_many :connections, foreign_key: 'procreator_id', dependent: :destroy
  has_many :babies, through: :connections
  has_many :reverse_connections, class_name: 'Connection', foreign_key: 'baby_id', dependent: :destroy
  has_many :procreators, through: :reverse_connections

  has_and_belongs_to_many :articles # ! Переделать

  has_ancestry

  validates :first_name, :last_name, :birth_date, :sex, presence: true

  before_save :titleize

  def full_name
    full_name = self.first_name + " " + self.middle_name + " " + self.last_name
    full_name.mb_chars.split(" ").map(&:capitalize).join(" ")
  end

  def titleize
    [:first_name, :middle_name, :last_name].each do |name|
      # self.send(name).mb_chars[0].upcase
      new_name = self.send(name).mb_chars.capitalize
      self.send("#{name}=", new_name)
    end
  end
end
