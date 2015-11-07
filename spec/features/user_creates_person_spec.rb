require "rails_helper"

feature "user creates person" do
  scenario "successfully" do
    visit root_path(as: create(:user))
    click_on "Add person"

    fill_in "Name", with: "Jolly Nick"
    fill_in "Amount", with: 20.00
    click_on "Add person"

    expect(page).to have_person_on_list("Jolly Nick")
    expect(page).to have_budgeted_amount_for("$20.00")
  end

  scenario "without a name" do
    visit root_path(as: create(:user))
    click_on "Add person"

    fill_in "Amount", with: 20.00
    click_on "Add person"

    expect(page).to have_error
  end

  def have_person_on_list(name)
    have_css("[data-role=person]", text: name)
  end

  def have_budgeted_amount_for(amount)
    have_css("[data-role=amount]", text: amount)
  end

  def have_error
    have_css(".error")
  end
end
