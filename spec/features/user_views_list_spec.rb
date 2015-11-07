require "rails_helper"

feature "user sees list of lists" do
  scenario "for their lists" do
    list = create(:list)
    second_list = create(:list, user: list.user)

    visit lists_path(as: list.user)

    expect(page).to have_list(list.name)
    expect(page).to have_list(second_list.name)
  end
end
