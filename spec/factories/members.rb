FactoryGirl.define do
  factory :women_member, class: Member do
    first_name "MyString"
    last_name "MyString"
    middle_name "MyString"
    birth_date "2015-02-26"
    death_date "2015-02-26"
    sex "male"
  end

  factory :member do
    first_name "MyString"
    last_name "MyString"
    middle_name "MyString"
    birth_date "2015-02-26"
    death_date "2015-02-26"
    sex "female"
    association :partner, factory: :women_member
  end

end
