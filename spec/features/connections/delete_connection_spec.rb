require_relative '../feature_helper'

feature 'delete connection' do
  given!(:member) { create(:member) }
  given!(:another_member) { create(:member, first_name: "Захар") }
  given!(:connection) { create(:connection, baby: member, procreator: another_member) }

  scenario 'succesfully delete' do
    sign_in(create(:user))
    visit member_connections_path(member)
    click_on("Удалить связь")

    expect(page).not_to have_content("Захар")
  end
end