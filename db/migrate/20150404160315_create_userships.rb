class CreateUserships < ActiveRecord::Migration
  def change
    create_table :userships do |t|
      t.integer :user_id
      t.integer :usershipable_id
      t.string :usershipable_type

      t.timestamps null: false
    end
  end
end
