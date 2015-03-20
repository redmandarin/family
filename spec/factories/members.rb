FactoryGirl.define do
  factory :woman_member, class: Member do
    first_name "Mystring"
    last_name "Mystring"
    middle_name "Mystring"
    birth_date "2015-02-26"
    death_date "2015-02-26"
    sex "female"
  end

  factory :member do
    first_name "Mystring"
    last_name "Mystring"
    middle_name "Mystring"
    birth_date "2015-02-26"
    death_date "2015-02-26"
    sex "male"
    association :partner, factory: :woman_member
  end

end
