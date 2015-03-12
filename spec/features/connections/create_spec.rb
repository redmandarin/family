require_relative '../feature_helper'

feature 'Connection' do
  given(:member) { create(:member, first_name: "Аркадий", middle_name: "Германович", last_name: "Гуськов") }
  given!(:another_member) { create(:member, first_name: "Петр", middle_name: "Аркадьевич", last_name: "Гуськов") }
  
  scenario 'does not see create connection link' do
    visit(member_path(member))
    expect(page).not_to have_link("Редактировать связи")
  end

  describe 'create conneciton' do
    before do
      sign_in(create(:user))
      visit(new_member_connection_path(member))
    end

    scenario 'create child Connection' do
      select "Петр Аркадьевич Гуськов", from: "Кто?"
      select "Ребенок", from: "Тип связи"
      click_on "Сохранить связь"

      within ".children" do
        expect(page).to have_content("Петр Аркадьевич Гуськов")
      end
    end

    scenario 'create parent Connection' do
      select "Аркадий Германович Гуськов", from: "Кто?"
      select "Родитель", from: "Тип связи"
      click_on "Сохранить связь"

      within ".parents" do
        expect(page).to have_content("Аркадий Германович Гуськов")
      end
    end
  end
end