class ChangeConnection < ActiveRecord::Migration
  def change
    drop_table :connections
    create_table :connections do |t|
      t.integer :procreator_id
      t.integer :baby_id
    end
  end
end
