require "rails_helper"

RSpec.describe Dialogue do
  let(:dialogue) { create(:dialogue, :with_turns) }
  let(:correct_ids) { dialogue.turns.ids }

  describe "#shuffled_turns" do
    it "contains every turn exactly once" do
      expect(dialogue.shuffled_turns).to match_array(dialogue.turns)
    end

    it "never returns the turns in the correct order" do
      100.times do |seed|
        expect(dialogue.shuffled_turns(random: Random.new(seed))).not_to eq(dialogue.turns.to_a)
      end
    end

    it "returns a single-turn dialogue unchanged instead of looping forever" do
      single = create(:dialogue)
      single.turns.create!(text: "Oi!", position: 1)

      expect(single.shuffled_turns.map(&:text)).to eq([ "Oi!" ])
    end
  end

  describe "#valid_submission?" do
    it "accepts every turn exactly once, in any order" do
      expect(dialogue.valid_submission?(correct_ids.reverse)).to be(true)
    end

    it "rejects a submission with a missing turn" do
      expect(dialogue.valid_submission?(correct_ids.first(3))).to be(false)
    end

    it "rejects a submission with a duplicated turn" do
      expect(dialogue.valid_submission?(correct_ids.first(3) + [ correct_ids.first ])).to be(false)
    end

    it "rejects a turn from another dialogue" do
      other_turn = create(:dialogue_turn)

      expect(dialogue.valid_submission?(correct_ids.first(3) + [ other_turn.id ])).to be(false)
    end

    it "rejects ids that could not be parsed" do
      expect(dialogue.valid_submission?(correct_ids.first(3) + [ nil ])).to be(false)
    end
  end

  describe "#check" do
    it "is correct when the turns are in their expected positions" do
      check = dialogue.check(correct_ids)

      expect(check).to be_correct
      expect(check.correct_count).to eq(4)
    end

    it "marks each turn as in the right or wrong place" do
      first, second, third, fourth = correct_ids
      check = dialogue.check([ second, first, third, fourth ])

      expect(check).not_to be_correct
      expect(check.correct_count).to eq(2)
      expect((0..3).map { |index| check.correct_at?(index) }).to eq([ false, false, true, true ])
    end

    it "returns the submitted turns in the learner's order" do
      check = dialogue.check(correct_ids.reverse)

      expect(check.submitted_turns.map(&:text).first).to eq("Das praias, sem dúvida.")
    end

    it "raises for an invalid submission" do
      expect { dialogue.check(correct_ids.first(3)) }.to raise_error(ArgumentError)
    end
  end
end
