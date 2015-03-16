class CreateArticlesMembers < ActiveRecord::Migration
  def change
    create_table :articles_members, id: false do |t|
      t.integer :member_id
      t.integer :article_id
    end
  end
end
