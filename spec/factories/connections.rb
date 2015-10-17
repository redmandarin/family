# == Schema Information
#
# Table name: connections
#
#  id            :integer          not null, primary key
#  procreator_id :integer
#  baby_id       :integer
#

FactoryGirl.define do
  factory :connection do
    association :procreator, factory: :member
    association :baby, factory: :member
  end

end
