# All seed content is fictional/synthetic. Never add real learner data here.
# Idempotent: safe to run repeatedly with bin/rails db:seed.

[
  {
    slug: "dialogue-reconstruction",
    title: "Dialogue Reconstruction",
    status: "prototype",
    purpose: "Reorder the shuffled turns of a short dialogue to notice turn-taking, " \
             "question/answer pairs and discourse connectors."
  },
  {
    slug: "error-detective",
    title: "Error Detective",
    status: "idea",
    purpose: "Spot and correct errors in a sentence, with expectations adjusted to the learner's CEFR level."
  },
  {
    slug: "branching-scenario",
    title: "Branching Scenario",
    status: "idea",
    purpose: "Choose how to respond in a realistic situation and see the conversation change, " \
             "to practise register and pragmatic competence."
  },
  {
    slug: "mastery-map",
    title: "Mastery Map",
    status: "idea",
    purpose: "Show strengths and weak areas across skills instead of only streaks or points."
  },
  {
    slug: "missions",
    title: "Missions",
    status: "idea",
    purpose: "Short weekly learning goals to test whether quests encourage varied, deliberate practice."
  }
].each do |attrs|
  Experiment.find_or_initialize_by(slug: attrs[:slug]).update!(attrs)
end

# Fictional learner profiles (not real people).
[
  { name: "Clara", cefr_level: "A1" },
  { name: "Matteo", cefr_level: "B1" },
  { name: "Sofia", cefr_level: "C1" }
].each do |attrs|
  Learner.find_or_initialize_by(name: attrs[:name]).update!(attrs)
end

# Synthetic dialogues for Dialogue Reconstruction.
# Each must have exactly one plausible order; see docs/experiments/dialogue_reconstruction.md.
[
  {
    title: "Uma viagem ao Rio",
    cefr_level: "A2",
    language: "pt-BR",
    turns: [
      "Você já foi ao Rio?",
      "Sim, fui no ano passado.",
      "E o que você mais gostou?",
      "Das praias, sem dúvida."
    ]
  },
  {
    title: "Remarcando o almoço",
    cefr_level: "B1",
    language: "pt-BR",
    turns: [
      "Oi, Marina! Posso te pedir um favor?",
      "Claro, pode falar.",
      "Será que a gente pode mudar o almoço de quinta para sexta?",
      "Sexta eu não consigo, mas sábado ficaria ótimo.",
      "Combinado, então. Sábado ao meio-dia?"
    ]
  }
].each do |attrs|
  dialogue = Dialogue.find_or_initialize_by(title: attrs[:title])
  dialogue.update!(attrs.except(:turns))
  dialogue.turns.destroy_all
  attrs[:turns].each.with_index(1) do |text, position|
    dialogue.turns.create!(text: text, position: position)
  end
end
