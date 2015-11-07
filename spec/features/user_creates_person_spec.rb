require "rails_helper"

feature "user creates person" do
  scenario "successfully" do
    visit root_path(as: create(:user))
    click_on "Add person"

    fill_in "Name", with: "Jolly Nick"
    fill_in "Amount", with: 20.00
    attach_file "Avatar", "spec/support/fixtures/nick.jpg"
    click_on "Add person"

    expect(page).to have_person_on_list("Jolly Nick")
    expect(page).to have_budgeted_amount_for("$20.00")
    expect(image_url).to include("nick")
  end

  scenario "without a name" do
    visit root_path(as: create(:user))
    click_on "Add person"

    fill_in "Amount", with: 20.00
    click_on "Add person"

    expect(page).to have_error
  end

  scenario "without a picture" do
    visit root_path(as: create(:user))
    click_on "Add person"

    fill_in "Name", with: "Jolly Nick"
    click_on "Add person"

    expect(image_url).to include("missing")
  end

  def have_person_on_list(name)
    have_role_with_text("person", name)
  end

  def have_budgeted_amount_for(amount)
    have_role_with_text("amount", amount)
  end

  def image_url
    find("[data-role=person-image] img")[:src]
  end

  def have_error
    have_css(".error")
  end
end
