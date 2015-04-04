# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  middle_name :string
#  birth_date  :date
#  death_date  :date
#  sex         :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  partner_id  :integer
#  image       :string
#  ancestry    :string
#  bio         :text
#
# Indexes
#
#  index_members_on_ancestry  (ancestry)
#

class Member < ActiveRecord::Base
  include Petrovich::Extension

  attr_accessor :clan

  mount_uploader :image, ImageUploader

  enum sex: [:male, :female]

  belongs_to :partner, class_name: "Member"

  has_many :memberships
  has_many :clans, through: :memberships, source: :membershipable, source_type: 'Clan'
  has_many :connections, foreign_key: 'procreator_id', dependent: :destroy
  has_many :babies, through: :connections
  has_many :reverse_connections, class_name: 'Connection', foreign_key: 'baby_id', dependent: :destroy
  has_many :procreators, through: :reverse_connections
  has_many :articles, through: :memberships, source: :membershipable, source_type: 'Article'

  has_ancestry

  validates :first_name, :last_name, :birth_date, :sex, presence: true

  before_save :titleize
  after_save :update_partner

  petrovich firstname: :my_first_name

  resourcify

  def my_first_name
    self.first_name
  end

  def my_gender
    self.sex.to_sym
  end

  def full_name
    full_name = self.first_name + " " + self.middle_name + " " + self.last_name
    full_name.mb_chars.split(" ").map(&:capitalize).join(" ")
  end

  def full_name_with_year
    self.full_name + " (" + self.birth_year + ")"
  end

  def birth_year
    self.birth_date.year.to_s
  end

  def titleize
    [:first_name, :middle_name, :last_name].each do |name|
      # self.send(name).mb_chars[0].upcase
      new_name = self.send(name).mb_chars.capitalize
      self.send("#{name}=", new_name)
    end
  end

  def update_partner
    if self.partner
      self.partner.update_columns(partner_id: self.id)
    end
  end
end
