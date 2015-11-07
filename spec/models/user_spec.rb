require "rails_helper"

describe User do
  it { should have_many(:invitations) }
  it { should have_many(:lists) }

  describe "#all_lists" do
    it "includes owned lists and shared lists" do
      user = create(:user)
      other_user = create(:user)
      owned_list = create(:list, user: user)
      shared_list = create(:list, user: other_user)
      create(:list_share, list: shared_list, user: user)

      expect(user.all_lists).to match_array([owned_list, shared_list])
    end
  end
end
