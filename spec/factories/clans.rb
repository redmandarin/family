# == Schema Information
#
# Table name: clans
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :clan do
    name "MyString"
  end

end
