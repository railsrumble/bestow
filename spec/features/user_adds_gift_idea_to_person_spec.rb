require "rails_helper"

feature "user adds gift idea to person" do
  scenario "successfully" do
    user = create(:user)
    list = create(:list, user: user)
    person = create(:person, list: list)

    visit list_person_path(person.list, person, as: user)
    click_on "Add gift idea"

    fill_form(
      "GiftIdea",
      name: "Socks",
      url: "www.amazon.com",
      amount: "25.00",
    )
    click_on "Add gift idea"

    expect(page).to have_gift_idea_on_list("Socks")
    expect(page).to have_gift_idea_url("www.amazon.com")
    expect(page).to have_gift_idea_amount("$25.00")
  end

  scenario "without a name" do
    user = create(:user)
    list = create(:list, user: user)
    person = create(:person, list: list)

    visit list_person_path(person.list, person, as: user)
    click_on "Add gift idea"

    fill_in "Amount", with: 25.00
    click_on "Add gift idea"

    expect(page).to have_error
  end

  def have_gift_idea_on_list(name)
    have_role_with_text("name", name)
  end

  def have_gift_idea_url(url)
    have_role_with_text("url", url)
  end

  def have_gift_idea_amount(amount)
    have_role_with_text("amount", amount)
  end

  def have_error
    have_css(".error")
  end
end
