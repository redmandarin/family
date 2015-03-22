class CreateMemberships < ActiveRecord::Migration
  def change
    drop_table :articles_members
    create_table :memberships do |t|
      t.integer :member_id
      t.integer :memberable_id
      t.string :memberable_type
    end
    add_index :memberships, [:member_id, :memberable_type]
  end
end
