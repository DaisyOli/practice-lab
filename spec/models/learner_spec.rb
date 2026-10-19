require "rails_helper"

RSpec.describe Learner do
  it "accepts every CEFR level" do
    Cefr::LEVELS.each do |level|
      expect(build(:learner, cefr_level: level)).to be_valid
    end
  end

  it "rejects a level outside the CEFR scale" do
    expect(build(:learner, cefr_level: "D1")).not_to be_valid
  end
end
