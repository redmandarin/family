# == Schema Information
#
# Table name: userships
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  usershipable_id   :integer
#  usershipable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Usership < ActiveRecord::Base
  belongs_to :user
  belongs_to :usershipable, polymorphic: true  
end
