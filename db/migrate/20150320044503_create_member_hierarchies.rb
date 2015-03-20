class CreateMemberHierarchies < ActiveRecord::Migration
  def change
    drop_table :connections
    create_table :connections, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :connections, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "member_anc_desc_idx"

    add_index :connections, [:descendant_id],
      name: "member_desc_idx"
  end
end
