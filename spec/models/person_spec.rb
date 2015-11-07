require "rails_helper"

describe Person do
  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
end
