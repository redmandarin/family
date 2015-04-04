# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  clan_id    :integer
#

FactoryGirl.define do
  factory :article do
    user_id 1
title "MyString"
body "MyText"
  end

end
