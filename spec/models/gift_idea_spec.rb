require "rails_helper"

describe GiftIdea do
  it { should belong_to(:person) }

  it { should validate_presence_of(:name) }
end
