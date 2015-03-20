require_relative '../feature_helper'

feature 'edit Article' do
  given(:user) { create(:user) }
  given!(:member) { create(:member, first_name: "name") }
  given!(:another_member) { create(:member, first_name: "Another") }

  background do 
    sign_in user
    visit new_article_path
    fill_in "Заголовок", with: "Заголовок"
    fill_in "Тело статьи", with: "Тело статьи"
    check member.full_name
    click_on "Сохранить статью"
  end

  scenario 'edit without members' do
    click_on "Редактировать статью"
    fill_in "Тело статьи", with: "Новое"
    uncheck member.full_name
    click_on "Сохранить изменения"

    expect(page).to have_content("Новое")
    expect(page).not_to have_content(member.full_name)
  end

  scenario 'edit with members' do
    click_on "Редактировать статью"
    fill_in "Тело статьи", with: "Новое"
    check another_member.full_name
    check member.full_name
    click_on "Сохранить изменения"

    expect(page).to have_content("Новое")
    expect(page).to have_content(member.full_name)
    expect(page).to have_content(another_member.full_name)
  end
end