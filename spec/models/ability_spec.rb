require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Member }
    it { should_not be_able_to :create, Member }
    it { should_not be_able_to :create, Article }
    it { should_not be_able_to :create, Connection }

    it { should_not be_able_to :update, Article }

    it { should_not be_able_to :destroy, Connection }
    it { should_not be_able_to :destroy, Member }
    it { should_not be_able_to :destroy, Article }
  end

  describe 'for user' do
    let(:user) { create(:user) }

    it { should be_able_to :create, Member }
    it { should be_able_to :create, Connection }

    it { should be_able_to :update, Article }

    it { should be_able_to :destroy, Article }
  end
end