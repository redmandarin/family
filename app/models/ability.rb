class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.has_role?(:admin) ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities

    can :create, Clan
    can :update, Clan do |clan|
      user.has_role?(:admin, clan)
    end

    can :manage, Connection do |connection|
      (connection.procreator.clans.to_a & user.clans.to_a).any? &&
      (connection.baby.clans.to_a & user.clans.to_a).any?
    end

    can :read, [:big_tree, :tree]
    can :create, Member
    can :update, Member do |member|
      user.clans.to_set.subset? member.clans.to_set
    end
    can :destroy, Member do |member|
      user.has_role?(:admin, member.clan)
    end

    can :create, Article
    can :manage, Article do |article|
      article.user == user
    end
  end
end
