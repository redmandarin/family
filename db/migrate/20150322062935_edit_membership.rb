class EditMembership < ActiveRecord::Migration
  def change
    remove_column :memberships, :memberable_id
    remove_column :memberships, :memberable_type
    add_column :memberships, :membershipable_id, :integer
    add_column :memberships, :membershipable_type, :integer
  end
end
