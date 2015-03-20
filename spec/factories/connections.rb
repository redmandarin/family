FactoryGirl.define do
  factory :connection do
    association :procreator, factory: :member
    association :baby, factory: :member
  end

end
