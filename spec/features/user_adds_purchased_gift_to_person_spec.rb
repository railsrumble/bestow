require "rails_helper"

feature "user adds purchased gift to person" do
  scenario "successfully" do
    user = create(:user)
    list = create(:list, user: user)
    person = create(:person, list: list)

    visit list_person_path(person.list, person, as: user)
    click_on "Add purchased gift"

    fill_in "Name", with: "Unicorn statue"
    fill_in "Url", with: "www.amazon.com"
    fill_in "Amount", with: 201.00
    click_on "Add purchased gift"

    expect(page).to have_purchased_gift_on_list("Unicorn statue")
    expect(page).to have_purchased_gift_url("www.amazon.com")
    expect(page).to have_purchase_gift_amount("$201.00")
  end

  def have_purchased_gift_on_list(name)
    have_role_with_text("name", name)
  end

  def have_purchased_gift_url(url)
    have_role_with_text("url", url)
  end

  def have_purchase_gift_amount(amount)
    have_role_with_text("amount", amount)
  end
end
