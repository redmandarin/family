# == Schema Information
#
# Table name: clans
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Clan, type: :model do
  it { should have_many(:users) }
  it { should have_many(:userships) }
  it { should have_many(:members) }
  it { should have_many(:memberships) }
  it { should have_many(:articles) }

  it { should validate_presence_of(:name) }

  describe "#has_member_or_user?(member)" do
    let(:member) { create(:member) }
    let(:another_member) { create(:member) }
    let(:clan) { create(:clan) }

    before do
      clan.members << member
    end

    it { expect(clan.has_member_or_user?(member)).to eq(true) }
    it { expect(clan.has_member_or_user?(another_member)).to eq(false) }
  end
end
