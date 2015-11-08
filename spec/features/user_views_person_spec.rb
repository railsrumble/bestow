require "rails_helper"

feature "user sees totals per person" do
  scenario "total amounts budgeted and spent on purchased gifts" do
    user = create(:user)
    list = create(:list, user: user)
    person = create(:person, name: "Rails Rumble Team", amount: 100, list: list)
    create(:purchased_gift, amount: 50, person: person)
    create(:purchased_gift, amount: 25, person: person)
    visit list_person_path(person.list, person, as: user)

    expect(page).to have_person_name("Rails Rumble Team")
    expect(page).to have_budgeted_total("$100.00")
    expect(page).to have_spent_total("$75.00")
  end

  def have_person_name(name)
    have_role_with_text("person-name", name)
  end

  def have_budgeted_total(amount)
    have_role_with_text("total-budgeted", amount)
  end

  def have_spent_total(amount)
    have_role_with_text("total-spent", amount)
  end
end