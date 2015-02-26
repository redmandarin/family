class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birth_date
      t.date :death_date
      t.integer :sex

      t.timestamps null: false
    end
  end
end
