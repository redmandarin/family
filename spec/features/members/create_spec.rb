require_relative "../feature_helper"

describe "Create member", type: :feature do

  before { create(:member, first_name: 'Юлия', last_name: 'Гуськова')}

  it 'create member' do
    visit(new_member_path)

    fill_in("Имя", with: 'Иван')
    fill_in("Отчество", with: 'Павлович')
    fill_in("Фамилия", with: 'Гуськов')
    select '1812', from: 'member_birth_date_1i'
    select '1', from: 'member_birth_date_2i'
    select '20', from: 'member_birth_date_3i'
    # select '1872', from: 'member_death_date_1i'
    # select '1', from: 'member_death_date_2i'
    # select '20', from: 'member_death_date_3i'
    select("Юлия Гуськова", from: "Супруг/супруга")
    select("мужчина", from: "Пол")
    attach_file 'Изображение', "#{Rails.root}/spec/support/1.jpg"
    click_on 'Сохранить'

    expect(page).to have_content("Иван")
    expect(page).to have_content("Павлович")
    expect(page).to have_content("Гуськов")
    expect(page).to have_content("Дата рождения: 20.01.1812")
    expect(page).to have_css("img[src*='1.jpg']")
    # expect(page).to have_content("Дата смерти: 20.01.1872")
    expect(page).to have_content("Супруг/супруга: Юлия Mystring Гуськова")
  end

end