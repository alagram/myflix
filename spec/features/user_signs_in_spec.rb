require 'spec_helper'

feature 'User signs in' do
  background do
    @user = Fabricate(:user, full_name: "Kofi Agram")
  end

  scenario "with existing username" do
    sign_in(@user)
    expect(page).to have_content "Kofi Agram"
  end

  scenario "with incorrect username" do
    visit sign_in_path
    fill_in "Email Address", with: @user.email
    fill_in "Password", with: "54321"
    click_button "Sign in"
    expect(page).to have_content "Invalid email or password."
  end
end