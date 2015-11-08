require "rails_helper"

feature "user changes list records" do
  scenario "updates successfully" do
    user = create(:user)
    list = create(:list, name: "First list", user: user)

    visit list_path(list, as: user)
    click_on "Edit"

    fill_form(
      "List",
      name: "Revised list name",
    )
    click_on "Save changes"

    expect(page).to have_list("Revised list name")
  end

  scenario "deletes list" do
    user = create(:user)
    create(:list, name: "First list", user: user)
    list = create(:list, name: "List to delete", user: user)

    visit list_path(list, as: user)
    click_on "Delete"

    expect(page).to have_list("First list")
    expect(page).to_not have_list("List to delete")
  end
end
