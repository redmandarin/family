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

FactoryGirl.define do
  factory :usership do
    user_id 1
usershipable_id 1
usershipable_type "MyString"
  end

end
