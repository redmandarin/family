require_relative '../feature_helper'

feature 'index page' do
  given(:members) { create_list(:member, 100) }

  scenario 'index' do
    members
    visit members_path
    save_and_open_page
  end
end