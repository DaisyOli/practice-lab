# A short synthetic dialogue whose turns the learner puts back in order.
class Dialogue < ApplicationRecord
  # Outcome of one reconstruction attempt, comparing the learner's order to the expected one.
  Check = Data.define(:submitted_turns, :expected_turns) do
    def correct?
      submitted_turns == expected_turns
    end

    def correct_at?(index)
      submitted_turns[index] == expected_turns[index]
    end

    def correct_count
      submitted_turns.each_index.count { |index| correct_at?(index) }
    end
  end

  has_many :turns, -> { order(:position) }, class_name: "DialogueTurn", dependent: :destroy

  validates :title, :language, presence: true
  validates :cefr_level, inclusion: { in: Cefr::LEVELS }

  # Never returns the turns already in the correct order, so there is always something to do.
  def shuffled_turns(random: Random.new)
    expected = turns.to_a
    return expected if expected.size < 2

    loop do
      shuffled = expected.shuffle(random: random)
      return shuffled unless shuffled == expected
    end
  end

  # A submission is valid only if it contains every turn of this dialogue exactly once.
  def valid_submission?(turn_ids)
    turn_ids.sort == turns.ids.sort
  end

  def check(turn_ids)
    raise ArgumentError, "submission must contain every turn exactly once" unless valid_submission?(turn_ids)

    by_id = turns.index_by(&:id)
    Check.new(submitted_turns: turn_ids.map { |id| by_id.fetch(id) }, expected_turns: turns.to_a)
  end
end
