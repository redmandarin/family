# == Schema Information
#
# Table name: memberships
#
#  id                  :integer          not null, primary key
#  member_id           :integer
#  membershipable_id   :integer
#  membershipable_type :integer
#

require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :membershipable }
  it { should belong_to :member }
end
