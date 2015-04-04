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
    let!(:clan) { create(:clan) }
    let!(:another_clan) { create(:clan) }
    let!(:user) { create(:user) }
    let!(:member) { create(:member) }
    let!(:another_member) { create(:member) }
    let!(:new_member) { build(:member) }
    let!(:another_user) { create(:user) }
    let!(:connection) { build(:connection, procreator: member, baby: another_member) }

    context 'clan member' do
      before do
        user.add_role(:clan_member, clan)
        user.clans << clan
        member.clans << clan
        new_member.clans << clan
        another_member.clans << clan
        another_user.clans << another_clan
        connection.clan = clan
      end


      it { should be_able_to :read, Member }
      it { should be_able_to :create, Member, user: user }

      it { should be_able_to :create, connection, user: user }

      it { should be_able_to :update, create(:article, user: user), user: user }
    end
  end

  describe 'not clan member' do
    let!(:clan) { create(:clan) }
    let!(:another_clan) { create(:clan) }
    let!(:user) { create(:user) }
    let!(:member) { create(:member) }
    let!(:another_member) { create(:member) }
    let!(:another_user) { create(:user) }
    let!(:connection) { build(:connection, procreator: member, baby: another_member) }

    before do
      member.clans << clan
    end

      it { should_not be_able_to :update, clan }
      it { should be_able_to :create, Clan }
      it { should_not be_able_to :create, connection }
      it { should_not be_able_to :update, create(:article, user: another_user), user: user }
      it { should_not be_able_to :destroy, create(:article, user: another_user), user: user }
  end

  describe 'for admin' do
    let(:user) { create(:user) }

    before { user.add_role(:admin) }

    it { should be_able_to :manage, :all }
    # Should be able to manage :all
  end
end
