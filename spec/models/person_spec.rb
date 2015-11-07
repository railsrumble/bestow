require "rails_helper"

describe Person do
  it { should belong_to(:list) }

  it { should validate_presence_of(:name) }
end
