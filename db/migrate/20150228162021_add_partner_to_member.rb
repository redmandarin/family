class AddPartnerToMember < ActiveRecord::Migration
  def change
    add_column :members, :partner_id, :integer
  end
end
