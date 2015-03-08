require_relative '../feature_helper'

feature 'Connection' do
  given(:member) { create(:member, first_name: "Аркадий", middle_name: "Германович", last_name: "Гуськов") }
  given(:another_member) { create(:member, first_name: "Петр", middle_name: "Аркадьевич", last_name: "Гуськов") }
  
  scenario 'does not see create connection link' do
    visit(member_path(member))
    expect(page).not_to have_link("Редактировать связи")
  end

  scenario 'create Connection' do
    sign_in(create(:user))
    visit(member_path(member))
    click_on "Редактировать связи"
    select "Петр Аркадьевич Гуськов", from: "Кто?"
    select "Ребенок", from: "Тип связи"
    click_on "Добавить связь"

    expect(page).to have_content("Сын Гуськов Петр Аркадьевич")
  end
end