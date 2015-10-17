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

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_many :members }
  it { should belong_to :user }
  it { should belong_to :clan }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
end
