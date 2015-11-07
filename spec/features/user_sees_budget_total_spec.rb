require "rails_helper"

feature "user sees budget total" do
  scenario "for a list" do
    list = create(:list)
    create(:person, list: list, amount: 10)
    create(:person, list: list, amount: 115.5)

    visit list_path(list, as: list.user)

    expect(page).to have_total("$125.50")
  end

  def have_total(amount)
    have_role_with_text("total-amount", amount)
  end
end
