# Experiment notes — Dialogue Reconstruction

**Status:** Prototype (v0.1) · **Language:** pt-BR · **Levels seeded:** A2, B1

## Learning problem

Sentence-ordering exercises usually treat sentences as isolated items. Learners can solve them by grammar alone, without engaging with how a conversation actually works: who speaks next, which turn answers which question, and how connectors (*e*, *então*, *mas*) signal a follow-up.

## Hypothesis

Reconstructing a whole dialogue makes learners notice turn-taking, question/answer pairs, discourse connectors and register. This should make it a richer activity than ordering isolated sentences.

## Interaction being tested

- The turns of a short dialogue are shown shuffled. The shuffle never matches the correct order.
- The learner moves turns with **Move up / Move down** buttons, which work with a mouse, touch or keyboard. There is no drag-and-drop.
- On submit, each turn is marked "Right place" or "Wrong place", with a count (e.g. "2 of 4 turns are in the right place").
- **Try again** reshuffles the dialogue. A collapsible "Show the correct order" lets the learner see the answer when they choose to.
- A fictional learner (Clara A1, Matteo B1, Sofia C1) can be selected. Dialogues at that learner's CEFR level are highlighted but not restricted.

## How we would know it is useful

Not measured yet. These are the questions to answer when people try the prototype:

- Do learners explain their order using conversational cues ("this answers that question", "*E* means a follow-up") rather than guessing?
- How many attempts do they take, and does the per-turn feedback help on the second attempt?
- Do learners open "Show the correct order" too early, which would make the exercise passive?

## What worked

- Up/down buttons were reliable and simple to make accessible. Every move is announced ("Moved to position 2 of 4"), and focus stays on the pressed button. The interaction was checked end to end with keyboard only, in headless Chromium.
- Storing the correct order as `position` on each turn keeps the model trivial. Checking an attempt is a simple comparison.
- Rendering the result in a Turbo Frame gives in-place feedback and retry, with no client-side state.

## What did not / limitations

- **One valid order only.** Real dialogues can have more than one acceptable order. Seed dialogues must be written so that only one sequence is plausible. Supporting alternative orders would mean storing the accepted sequences rather than one `position` per turn.
- **"Right place" is strict.** If the learner gets the whole dialogue right but shifted by one position, every turn is marked wrong. Scoring correctly ordered *adjacent pairs* would be a fairer signal, and is worth testing next.
- **Moving a turn far is tedious** with up/down only (e.g. 5 presses for a long dialogue). That is acceptable at 4–5 turns but would not scale to long dialogues.
- **JavaScript is required to reorder.** Without it, the learner can read the turns but cannot change their order.
- **No speaker labels.** Showing speakers would give away the turn alternation. This is a deliberate choice, not yet validated with learners.
- Attempts are not stored, so there is no data on attempts or progress yet.

## Technical observations

- Rails 8.1 uses a separate CSRF token for each form. Scripts that post forms must use the token from the right form.
- A non-numeric `turn_ids[]` value used to crash the submission check. The specs caught this, and it is now treated as an invalid submission (422).
- daisyUI 5 runs without Node: the plugin file is downloaded into the repo and loaded with `@plugin` in the Tailwind v4 CSS.

## Would this be worth porting to Practice?

**Not yet decided — iterate first.** The interaction is cheap to port: two tables, one Stimulus controller, no dependencies. Before porting, it needs a few sessions with real learners (outside this repo) to test the hypothesis, plus a decision on adjacent-pair scoring and support for alternative orders.
