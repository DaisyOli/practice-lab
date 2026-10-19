FactoryBot.define do
  factory :learner do
    sequence(:name) { |n| "Learner #{n}" }
    cefr_level { "A1" }
  end
end
