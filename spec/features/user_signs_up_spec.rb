require "rails_helper"

feature "user signs up" do
  scenario "successfully" do
    visit root_path
    click_on "Sign up"

    fill_in "Email", with: "someone@example.com"
    fill_in "Password", with: "password"
    click_on "Sign up"

    expect(page).to have_current_user("someone@example.com")
  end

  def have_current_user(email)
    have_css("[data-role=current-user]", text: email)
  end
end
