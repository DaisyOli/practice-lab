require "rails_helper"

RSpec.describe Experiment do
  it "is valid with the factory defaults" do
    expect(build(:experiment)).to be_valid
  end

  it "rejects an unknown status" do
    expect(build(:experiment, status: "shipped")).not_to be_valid
  end

  it "requires a unique slug" do
    create(:experiment, slug: "dialogue-reconstruction")

    expect(build(:experiment, slug: "dialogue-reconstruction")).not_to be_valid
  end
end
