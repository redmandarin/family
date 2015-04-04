# == Schema Information
#
# Table name: memberships
#
#  id                  :integer          not null, primary key
#  member_id           :integer
#  membershipable_id   :integer
#  membershipable_type :integer
#

class Membership < ActiveRecord::Base
  belongs_to :membershipable, polymorphic: true
  belongs_to :member
end
