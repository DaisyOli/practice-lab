# CLAUDE.md — Practice Lab

## Project Overview

**Practice Lab** is an experimental EdTech sandbox for prototyping and validating new language-learning interactions before they are considered for integration into the production applications **Practice-FR** and **Practice-BR**.

This project must remain completely independent from the production applications.

The goal is not to build a third SaaS product.

The goal is to create a safe R&D environment where new exercise formats, gamification mechanics, feedback systems and learning UX ideas can be implemented quickly, tested with synthetic data, evaluated, refactored and discarded when necessary.

Practice Lab may also be used during AI-assisted coding evaluation sessions.

---

## Why This Project Exists

Practice-FR and Practice-BR are production EdTech applications.

Experimenting directly inside production products creates unnecessary complexity:

- experimental features can pollute production architecture;
- unfinished ideas require migrations, conditionals and cleanup;
- UX ideas may look good conceptually but fail when implemented;
- gamification systems are difficult to evaluate before they exist;
- exercise formats often need several iterations before they are pedagogically useful;
- production applications include real users and data, which must never be exposed in experimental AI coding sessions.

Practice Lab separates **experimentation** from **production**.

The intended workflow is:

**Idea → Practice Lab prototype → evaluation → iterate/discard → optionally port to Practice-FR / Practice-BR**

---

# Core Principles

## 1. Experimental, not production

Prefer speed, clarity and reversibility over production complexity.

Do not add infrastructure unless an experiment genuinely requires it.

Avoid building features simply because the production apps have them.

---

## 2. No real user data

This project must contain only synthetic or hard-coded test data.

Never introduce:

- production databases;
- user exports;
- learner names;
- teacher names;
- emails belonging to real users;
- payment data;
- analytics containing real users;
- API keys;
- credentials;
- production secrets.

Seed data must be fictional.

---

## 3. No production authentication or billing

Do NOT implement:

- Devise authentication;
- Stripe;
- subscriptions;
- payment flows;
- invitation systems;
- CPF/OPCO reporting;
- transactional emails;
- production analytics.

If an experiment needs different learner profiles, simulate them with synthetic models or fixtures.

---

## 4. Pedagogy before novelty

Every experiment must answer four questions:

1. **What learning problem does this solve?**
2. **What learner interaction are we testing?**
3. **How will we know whether the interaction is useful?**
4. **What would justify porting this feature into Practice-FR or Practice-BR?**

Do not add features solely because they are technically interesting.

---

## 5. Reusable ideas, independent code

Practice Lab may explore ideas that could later be reimplemented in Practice-FR or Practice-BR.

However:

- do not depend on production repositories;
- do not share production databases;
- do not import secrets;
- do not assume internal production APIs;
- keep experiments understandable in isolation.

The architectural ideas may be portable even when the code is not copied directly.

---

# Recommended Stack

Prefer technologies already familiar from the Practice ecosystem so validated ideas can be ported later.

## Backend

- Ruby on Rails 7.1+
- Ruby 3.3+
- PostgreSQL

## Frontend

- Rails server-rendered views
- Hotwire
  - Turbo
  - Stimulus
- Tailwind CSS
- DaisyUI where useful

Avoid introducing React unless an experiment specifically requires client-side complexity that Hotwire cannot reasonably support.

## Testing

- RSpec
- FactoryBot

Keep tests focused on experiment behavior rather than chasing production-level coverage metrics.

## Version Control

- Git
- GitHub

Use small, understandable commits.

---

# Product Structure

The application should be organized around **experiments**.

Suggested conceptual structure:

```text
Practice Lab

Experiments
├── Dialogue Reconstruction
├── Error Detective
├── Branching Scenario
├── Mastery Map
└── Missions

Synthetic Data
├── Learners
├── Activities
└── Progress

Experiment Notes
├── Hypothesis
├── Observations
├── Technical trade-offs
└── Port / Iterate / Discard decision
```

Do not over-engineer an abstract framework for experiments at the beginning.

Start concrete and extract shared abstractions only when repetition appears.

---

# MVP — Version 0.1

The first version should be intentionally small.

## Required

### 1. Home / Experiments index

A clean page showing available experiments.

Each experiment card should contain:

- title;
- short pedagogical purpose;
- status:
  - Idea
  - Prototype
  - Testing
  - Validated
  - Archived
- button to open the experiment.

Initial experiments may be seeded.

---

### 2. First experiment: Dialogue Reconstruction

This is the first feature to implement.

## Learning goal

Test whether reconstructing an entire dialogue creates a richer language-learning activity than ordering isolated sentences.

It should help learners notice:

- conversational logic;
- turn-taking;
- discourse connectors;
- register;
- cause/effect;
- question/answer relationships.

## Initial behavior

Display a short dialogue whose turns are shuffled.

Example:

```text
— Você já foi ao Rio?
— Sim, fui no ano passado.
— E o que você mais gostou?
— Das praias, sem dúvida.
```

The learner must place the dialogue turns in the correct order.

### MVP interaction options

Choose the simplest reliable implementation first.

Possible implementation:

- sortable cards using Stimulus;
- submit the order;
- compare with expected order;
- show result and feedback;
- allow retry.

Do not add AI to version 0.1.

---

### 3. Synthetic learner selector

Add 2–3 fictional learner profiles to allow future experiments with levels.

Example:

- Clara — A1
- Matteo — B1
- Sofia — C1

These are fictional identities.

The learner profile can initially be selected without authentication.

---

### 4. CEFR metadata

Activities should be able to declare a CEFR level.

Use:

- A1
- A2
- B1
- B2
- C1
- C2

Do not implement complex access rules yet.

---

### 5. Experiment notes

Each experiment should have a simple developer/product note area or markdown file answering:

```text
Learning problem:
Hypothesis:
Interaction being tested:
What worked:
What did not:
Technical observations:
Would this be worth porting to Practice?
```

These notes are part of the value of Practice Lab.

---

# Initial Backlog

After Dialogue Reconstruction is functional, these are the next experiments.

## Experiment 2 — Error Detective

The learner receives a sentence containing one or more errors and must identify/correct them.

Possible dimensions:

- grammar;
- agreement;
- vocabulary;
- register;
- word order;
- pragmatic appropriateness.

Important future direction:

Difficulty should eventually depend on CEFR level.

An A1 learner must not be evaluated according to C1 expectations.

No AI is required for the initial prototype.

---

## Experiment 3 — Branching Scenario

Create short interactive communication scenarios.

Example:

```text
You arrive at a hotel and your room is not ready.

What do you say?
```

The learner chooses or writes a response.

The scenario then changes based on that choice.

Use this experiment to explore:

- pragmatic competence;
- communication strategies;
- register;
- realistic consequences.

Start with deterministic branches.

Do not introduce LLM branching in the first iteration.

---

## Experiment 4 — Mastery Map

Explore gamification based on **competence mastery**, not only frequency.

Possible skill dimensions:

- Listening
- Reading
- Vocabulary
- Grammar
- Written production
- Spoken production

The goal is to test whether a learner benefits from seeing strengths and weak areas instead of only streaks or points.

Use synthetic progress data initially.

---

## Experiment 5 — Missions / Quests

Prototype short learning missions.

Examples:

```text
Complete 3 activities this week.
Practice listening twice.
Redo one activity you previously struggled with.
Complete one B1 dialogue activity.
```

Explore:

- completion state;
- progress visualization;
- rewards;
- weekly reset;
- optional vs required missions.

Do not build a complex rewards economy initially.

---

# Future Experiment Ideas

These are ideas, not commitments.

## Exercise types

- Listening sequence reconstruction
- Dialogue completion with contextual choices
- Register transformation
- Spot-the-inconsistency
- Sentence expansion
- Reformulation challenge
- Vocabulary in context
- Timeline reconstruction
- Information-gap activity
- Pronoun/reference tracking
- Connector choice
- Pragmatic response ranking
- Micro-story reconstruction

## Gamification

- skill-based XP;
- mastery levels;
- weekly quests;
- adaptive challenges;
- weak-skill missions;
- achievement collections;
- optional streak recovery;
- learner-generated goals.

## Feedback UX

Test different ways to explain mistakes:

- immediate correction;
- delayed correction;
- hint before answer;
- explanation after second attempt;
- confidence indicator;
- “why this answer?”;
- contrastive examples;
- CEFR-adjusted explanations.

---

# AI Experiments — Later Phase

Practice Lab may eventually include AI-assisted experiments, but AI should not be added simply because the project is AI-adjacent.

Potential future uses:

## AI feedback comparison

Compare two feedback strategies for an open response.

Evaluate:

- accuracy;
- tone;
- usefulness;
- CEFR appropriateness;
- verbosity;
- consistency.

---

## AI-generated activities

Generate draft activities from structured prompts.

Every generated activity must remain a draft until reviewed.

Potential evaluation rubric:

- pedagogical coherence;
- plausible distractors;
- level appropriateness;
- progression of difficulty;
- linguistic correctness;
- cultural authenticity;
- repetition avoidance.

---

## Model-task comparison

Different tasks may use different model strategies.

A model suitable for high-quality low-volume content generation may not be the right choice for high-volume feedback.

Keep evaluation criteria explicit.

---

# Coding Standards

Prefer:

- small controllers;
- clear models;
- service objects only when they genuinely simplify behavior;
- Rails conventions;
- readable code over clever abstractions;
- progressive enhancement;
- semantic HTML;
- accessible interactions;
- small Stimulus controllers;
- simple database schemas.

Avoid:

- premature abstractions;
- unnecessary APIs;
- SPA architecture without a clear reason;
- complex dependency chains;
- speculative scalability;
- “enterprise” architecture for experimental prototypes.

---

# AI Coding Assistant Evaluation

When this repository is used during AI-assisted coding evaluation sessions, the developer may need to compare two proposed solutions.

When evaluating competing implementations, consider:

1. Correctness
2. Fit with existing architecture
3. Simplicity
4. Maintainability
5. Testability
6. Accessibility
7. Failure handling
8. Unnecessary complexity
9. Ease of future porting into Practice applications

The preferred solution is not necessarily the longest or most sophisticated one.

Favor the smallest solution that correctly solves the problem and fits the architecture.

---

# Important Privacy Rules

Never add to this repository:

- production credentials;
- `.env` secrets;
- API keys;
- Stripe keys;
- Resend keys;
- Anthropic/OpenAI keys;
- production database dumps;
- user information;
- client information;
- real student responses;
- real audio recordings;
- confidential educational records.

Before committing, always inspect staged changes for secrets or personal data.

---

# Relationship to Practice-FR and Practice-BR

Practice-FR and Practice-BR are production applications.

Practice Lab is their **experimental R&D playground**, not a shared production dependency.

A successful experiment may later inspire an implementation in either application.

Do not modify Practice-FR or Practice-BR from this repository.

Do not create runtime dependencies between them.

---

# README Positioning

The public-facing description should communicate something close to:

> **Practice Lab is an experimental EdTech playground for prototyping language-learning interactions, exercise formats and gamification mechanics before they reach production products.**
>
> It uses synthetic data only and focuses on rapid experimentation, pedagogical validation and reusable product ideas.

---

# First Development Session

Work incrementally.

## Step 1

Initialize the Rails application and configure PostgreSQL, Tailwind and Stimulus.

## Step 2

Create the Experiments index with seeded experiments.

## Step 3

Create a minimal `Experiment` model only if persistence adds real value.

Avoid building a generic plugin system.

## Step 4

Implement **Dialogue Reconstruction**.

Start with one synthetic Portuguese example.

## Step 5

Add RSpec tests for ordering validation.

## Step 6

Improve the interaction and accessibility.

## Step 7

Write experiment notes describing what was learned.

Stop here before adding another experiment.

---

# Definition of Done for v0.1

Version 0.1 is complete when:

- the application runs locally;
- the experiments index exists;
- Dialogue Reconstruction works end-to-end;
- all content is synthetic;
- a fictional learner and CEFR level can be selected;
- the learner can reorder, submit and retry a dialogue;
- automated tests cover the core ordering logic;
- the repository contains no secrets or real user data;
- the README clearly explains the purpose of Practice Lab;
- the project is small enough to understand in a few minutes.

Do **not** expand scope before this is complete.
