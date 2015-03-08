FactoryGirl.define do
  factory :connection do
    association :parent, factory: :member
    association :child, factory: :member
  end

end
