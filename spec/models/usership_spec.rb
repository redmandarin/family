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

require 'rails_helper'

RSpec.describe Usership, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:usershipable) }
end
