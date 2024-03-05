require "rails_helper"

feature "Honeypots" do
  scenario "when signing in" do
    visit new_user_session_path
    within("form") do
      fill_in "user[email]", with: "user@example.com"
      fill_in "user[password]", with: "caplin123"

      # when the dummy field is filled in, the response should be an empty page
      fill_in "user[dummie_hpot_field]", with: "abcde"

      click_button "Log in"
    end
    expect(page).not_to have_css("body")
  end
end
