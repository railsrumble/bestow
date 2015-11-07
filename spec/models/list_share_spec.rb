require "rails_helper"

describe ListShare do
  it { should belong_to(:list) }
  it { should belong_to(:user) }
end
