FactoryBot.define do
  factory :experiment do
    sequence(:title) { |n| "Experiment #{n}" }
    sequence(:slug) { |n| "experiment-#{n}" }
    purpose { "Test a synthetic learning interaction." }
    status { "idea" }
  end
end
