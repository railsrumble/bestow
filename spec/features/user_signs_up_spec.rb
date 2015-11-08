require "rails_helper"

feature "user signs up" do
  scenario "successfully" do
    visit root_path
    click_sign_up

    fill_in "Email", with: "someone@example.com"
    fill_in "Password", with: "password"
    click_on "Sign up"

    expect(page).to have_current_user("someone@example.com")
  end

  def have_current_user(email)
    have_role_with_text("current-user", email)
  end

  def click_sign_up
    all(".sign-up-nav").first.click
  end
end
