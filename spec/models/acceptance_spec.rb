require "rails_helper"

describe Acceptance do
  describe "#save" do
    it "creates the user" do
      new_user_attributes = {
        email: "spiderman@example.com",
        password: "password",
      }

      acceptance = Acceptance.new(stubbed_invitation, new_user_attributes)
      acceptance.save

      user = acceptance.user
      expect(user.email).to eq(new_user_attributes[:email])
    end

    it "shares the list with the user" do
      list = create(:list)
      invitation = create(:invitation, list: list)

      acceptance = Acceptance.new(invitation, user_attributes)
      acceptance.save

      created_user = acceptance.user
      expect(created_user.others_lists).to include(list)
    end
  end

  def stubbed_invitation
    create(:invitation, accepted_at: nil).tap do |invitation|
      allow(invitation).to receive(:accept).and_return(true)
    end
  end

  def user_attributes
    { email: "someone@example.com", password: "password" }
  end
end
