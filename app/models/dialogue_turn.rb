# One line of a dialogue. `position` is the correct place of the turn (1-based).
class DialogueTurn < ApplicationRecord
  belongs_to :dialogue

  validates :text, presence: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }, uniqueness: { scope: :dialogue_id }
end
