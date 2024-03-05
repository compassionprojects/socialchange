require "rails_helper"

feature "Honeypots" do
  scenario "when signing in" do
    visit new_user_session_path
    within("form") do
      fill_in "user[email]", with: "user@example.com"
      fill_in "user[password]", with: "caplin123"

      # when the dummy field is filled in, the response should be an empty page
      find_field("user[dummie_hpot_field]").set("abcde")
    end
    click_button "Log in"
    expect(page).not_to have_css("body") # should not have any html
  end

  scenario "when signing up" do
    visit new_user_registration_path
    within("form") do
      fill_in "user[name]", with: "User Name"
      fill_in "user[email]", with: "user@example.com"
      fill_in "user[password]", with: "caplin123"
      fill_in "user[password_confirmation]", with: "caplin123"
      find_field("user[dummie_hpot_field]").set("abcde")
    end
    click_button "Sign up"
    expect(page).not_to have_css("body") # should not have any html
  end

  scenario "forgot password" do
    visit new_user_password_path
    within("form") do
      fill_in "user[email]", with: "user@example.com"
      find_field("user[dummie_hpot_field]").set("abcde")
    end
    click_button "Reset password"
    expect(page).not_to have_css("body") # should not have any html
  end
end
