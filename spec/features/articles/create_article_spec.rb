require_relative '../feature_helper'

feature 'create Article' do
  given(:user) { create(:user) }
  given!(:member) { create(:member, first_name: "name") }
  background { sign_in user }

  scenario 'create' do
    visit new_article_path
    fill_in "Заголовок", with: "Заголовок"
    fill_in "Тело статьи", with: "Тело статьи"
    check member.full_name
    click_on "Сохранить статью"

    expect(page).to have_content("Заголовок")
    expect(page).to have_content("Тело статьи")
    expect(page).to have_link(member.full_name)
  end
end