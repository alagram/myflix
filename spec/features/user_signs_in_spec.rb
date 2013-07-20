require 'spec_helper'

feature 'User signs in' do
  background do
    User.create(email: "kofi@example.com", password: "12345", full_name: "Kofi Agram")
  end

  scenario "with existing username" do
    visit sign_in_path
    fill_in "Email Address", with: "kofi@example.com"
    fill_in "Password", with: "12345"
    click_button "Sign in"
    expect(page).to have_content "Kofi Agram"
  end
end