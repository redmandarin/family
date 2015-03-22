require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :membershipable }
  it { should belong_to :member }
end