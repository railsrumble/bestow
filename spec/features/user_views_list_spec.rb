require "rails_helper"

feature "user sees list of lists" do
  scenario "for their lists as well as shared" do
    user = create(:user)
    other_user = create(:user)
    list = create(:list)
    second_list = create(:list, user: user)
    shared_list = create(:list, user: other_user)

    create(:list_share, list: shared_list, user: user)

    visit lists_path(as: list.user)

    expect(page).to have_list(list.name)
    expect(page).to have_list(second_list.name)
    expect(page).to have_list(shared_list.name)
  end
end
