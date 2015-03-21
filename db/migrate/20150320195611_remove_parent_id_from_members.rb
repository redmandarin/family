class RemoveParentIdFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :parent_id
  end
end
