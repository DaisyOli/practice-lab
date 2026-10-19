FactoryBot.define do
  factory :dialogue_turn do
    dialogue
    sequence(:position)
    text { "Tudo bem?" }
  end
end
