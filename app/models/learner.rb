# A fictional learner profile. Selected per browser session; there is no authentication.
class Learner < ApplicationRecord
  validates :name, presence: true
  validates :cefr_level, inclusion: { in: Cefr::LEVELS }

  def label
    "#{name} — #{cefr_level}"
  end
end
