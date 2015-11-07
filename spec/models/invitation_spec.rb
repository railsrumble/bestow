require "rails_helper"

describe Invitation do
  it { should belong_to(:list) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:list) }
  it { should validate_presence_of(:user) }

  describe "#deliver" do
    it "saves and sends a valid invitation" do
      list = create(:list)
      allow(InvitationMailer).to receive(:invitation).and_return(mailer_double)
      invitation = build(:invitation, user: list.user, list: list)

      result = invitation.deliver

      expect(invitation).to be_persisted
      expect(InvitationMailer).to have_received(:invitation).with(invitation.id)
      expect(result).to be_truthy
    end

    it "doesn't send an invalid invitation" do
      allow(InvitationMailer).to receive(:invitation).and_return(mailer_double)
      invitation = build(:invitation, email: "")

      result = invitation.deliver

      expect(InvitationMailer).to have_received(:invitation).exactly(0).times
      expect(result).to be_falsey
    end

    def mailer_double
      double(deliver_later: true)
    end
  end

  describe "#code" do
    it "generates a code" do
      invitation = create(:invitation)

      expect(invitation.code).to be_present
    end

    it "generates a new code for each invitation" do
      first_invitation = create(:invitation)
      second_invitation = create(:invitation)

      expect(first_invitation.code).not_to eq(second_invitation.code)
    end
  end

  describe "#accept" do
    it "sets the accepted" do
      invitation = create(:invitation)

      invitation.accept

      expect(invitation.accepted).to be_truthy
    end
  end
end
