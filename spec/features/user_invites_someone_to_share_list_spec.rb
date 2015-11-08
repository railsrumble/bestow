require "rails_helper"

feature "user invites someone to share a list" do
  scenario "who does not have an account" do
    user = create(:user)
    list = create(:list, user: user, name: "Bob's List")

    visit list_path(list, as: user)

    invite_user "wife@example.com"

    using_session :wife do
      open_last_email
      click_first_link_in_email
      fill_in "Password", with: "password"
      click_on "Accept Invitation"

      expect(page).to have_list("Bob's List (shared from #{user.email})")
      expect(page).not_to have_invitation_form
    end
  end

  scenario "who does have an account" do
    user = create(:user)
    invited_user = create(:user, email: "user_to_share_with@example.com")
    list = create(:list, user: user, name: "Bob's List")

    visit list_path(list, as: user)

    invite_user "user_to_share_with@example.com"

    using_session :user_to_share_with do
      visit list_path(list, as: invited_user)

      expect(page).to have_list("Bob's List (shared from #{user.email})")
      expect(page).not_to have_invitation_form
    end
  end

  def invite_user(email)
    fill_in "Email", with: email
    click_on "Send Invitation"
  end

  def have_invitation_form
    have_role("invitation")
  end
end
