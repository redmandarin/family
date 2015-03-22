class Membership < ActiveRecord::Base
  belongs_to :membershipable, polymorphic: true
  belongs_to :member
end