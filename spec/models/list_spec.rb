require "rails_helper"

describe List do
  it { should belong_to(:user) }

  it { should have_many(:invitations) }
  it { should have_many(:people) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
end
