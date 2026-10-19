FactoryBot.define do
  factory :dialogue do
    title { "No Rio" }
    cefr_level { "A2" }
    language { "pt-BR" }

    trait :with_turns do
      after(:create) do |dialogue|
        [
          "Você já foi ao Rio?",
          "Sim, fui no ano passado.",
          "E o que você mais gostou?",
          "Das praias, sem dúvida."
        ].each.with_index(1) do |text, position|
          dialogue.turns.create!(text: text, position: position)
        end
      end
    end
  end
end
