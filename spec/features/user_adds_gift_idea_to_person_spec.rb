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

  scenario "using an amazon url" do
    user = create(:user)
    list = create(:list, user: user)
    person = create(:person, list: list)
    stub_amazon_lookup(amazon_information)

    visit list_person_path(person.list, person, as: user)
    click_on "Add gift idea"

    expect(page).to have_amazon_lookup

    fill_in "Amazon Url", with: amazon_information[:url]
    click_on "Lookup"

    expect(value_for_input("name")).to eq(amazon_information[:name])
    expect(value_for_input("url")).to eq(amazon_information[:url])
    expect(value_for_input("amount")).to eq(amazon_information[:price])

    expect(page).not_to have_amazon_lookup
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

  def have_amazon_lookup
    have_css(".amazon_lookup")
  end

  def value_for_input(name)
    find("[name='gift_idea[#{name}]']")[:value]
  end

  def amazon_information
    {
      url: "http://www.amazon.com/gp/product/B003KYTT7S?colid=Q4FSQPNF7G2W&coliid=I3FQGED4ZCN2K7&ref_=wl_it_dp_o_pC_nS_ttl",
      name: "Melissa & Doug Cook's Corner Wooden Kitchen",
      price: "95.99",
    }
  end

  def stub_amazon_lookup(amazon_details)
    allow(Vacuum).to receive(:new).and_return(StubbedVacuum.new(amazon_details))
  end
end
