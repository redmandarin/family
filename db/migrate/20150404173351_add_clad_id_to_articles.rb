class AddCladIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :clan_id, :integer
  end
end
