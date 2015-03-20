class AddParentToMember < ActiveRecord::Migration
  def change
    add_column :members, :parent_id, :integer
  end
end
