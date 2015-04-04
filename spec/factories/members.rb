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
    bio "Some long text"
    association :partner, factory: :woman_member

    after(:create) { |member| member.clan = create(:clan) }
  end

  factory :member_with_baby do
    first_name "Mystring"
    last_name "Mystring"
    middle_name "Mystring"
    birth_date "2015-02-26"
    death_date "2015-02-26"
    sex "male"
    association :partner, factory: :woman_member

    after(:create) { |member| member.babies << create(:member) }
  end

end
