# Practice Lab

**Practice Lab is an experimental EdTech playground for prototyping language-learning interactions, exercise formats and gamification mechanics before they reach production products.**

It uses synthetic data only and focuses on rapid experimentation, pedagogical validation and reusable product ideas.

Practice Lab is a personal project by Daisy Oliani, who also solely owns the Practice-FR and Practice-BR apps. It is kept independent from them: it shares no code, database, credentials or users with them. Ideas that prove useful here may be reimplemented there later.

## Experiments

| Experiment | Status | Notes |
|---|---|---|
| Dialogue Reconstruction | Prototype | [docs/experiments/dialogue_reconstruction.md](docs/experiments/dialogue_reconstruction.md) |
| Error Detective | Idea | — |
| Branching Scenario | Idea | — |
| Mastery Map | Idea | — |
| Missions | Idea | — |

Each experiment has a notes file covering the learning problem, the hypothesis, what worked and what did not, and whether it is worth porting.

## Running locally

Requirements: Ruby 3.3.5 and PostgreSQL. No Node, Redis or API keys needed.

```sh
bin/setup          # installs gems, creates and seeds the database, starts the server
bin/dev            # later runs: Rails server + Tailwind watcher on http://localhost:3000
bin/rails db:seed  # reload the synthetic experiments, learners and dialogues
```

## Tests

```sh
bin/rspec
```

The specs cover the experiment behaviour (dialogue ordering and attempts), not production-level coverage. `bin/ci` also runs RuboCop, Brakeman and the dependency audits.

## Stack

Rails 8.1, PostgreSQL, Hotwire (Turbo + Stimulus via importmap), Tailwind CSS v4 with daisyUI 5 (vendored in `app/assets/tailwind/daisyui.mjs`), RSpec + FactoryBot.

## Ground rules

- **Synthetic data only.** Learners (Clara, Matteo, Sofia) and all content are fictional. Never add real learner data, exports, recordings or credentials.
- **No authentication, billing, emails or production analytics.** The learner is chosen with a selector and kept in the session.
- **No AI features yet.**
- **Small and reversible.** Start concrete; extract shared abstractions only when repetition appears.

See [CLAUDE.md](CLAUDE.md) for the full scope, principles and v0.1 Definition of Done.
