require "rails_helper"

feature "user sees budget total" do
  scenario "for multiple people" do
    user = create(:user)
    create(:person, user: user, amount: 10)
    create(:person, user: user, amount: 115.5)
    visit root_path(as: user)

    expect(page).to have_total("$125.50")
  end

  def have_total(amount)
    have_role_with_text("total-amount", amount)
  end
end
