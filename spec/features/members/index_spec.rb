require_relative '../feature_helper'

feature 'index page' do
  given(:members) { create_list(:member, 100) }

  # scenario 'index' do
  #   members
  #   visit members_path
  #   # save_and_open_page
  # end

  given!(:member) { create(:member) }
  given!(:wife_member) { create(:member, partner: member) }
  given!(:child) { create(:member) }
  given!(:another_child) { create(:member) }
  given!(:child_of_child) { create(:member) }
  given!(:connection) { create(:connection, procreator: member, baby: child)}
  given!(:another_another_connection) { create(:connection, procreator: member, baby: another_child)}
  given!(:another_connection) { create(:connection, procreator: child, baby: child_of_child)}

  scenario 'tree' do
    sign_in create(:user)
    members
    visit tree_member_path(member)

    save_and_open_page
  end
end