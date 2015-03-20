class DropAndCreateConnections < ActiveRecord::Migration
  def change
    drop_table :connections
    create_table :connections do |t|
      t.integer :parent_id
      t.integer :child_id
    end

    add_column :members, :ancestry, :string

    add_index :members, :ancestry
  end
end
