# Blog Crew

Eight-agent system for writing, designing, and shipping blog posts on itstrieu.github.io.

## The crew

| Agent | Role | When they work |
|-------|------|----------------|
| **Orchestrator** | Coordinates handoffs, resolves conflicts, sequences work | Always active |
| **Career Coach** | Shapes narrative angle from Kathy's full background | Early — before writing |
| **Positioning Strategist** | Ensures the post advances the blog's arc | Early — topic selection |
| **Reader Advocate** | Represents the target audience, catches blind spots | Mid — reviews drafts |
| **Copy Editor** | Prose quality, tone, rhythm, grammar | Late — after content is shaped |
| **SEO Strategist** | Slugs, meta, OG tags, internal linking | Late — after content is final |
| **UI/UX Designer** | Reading experience, typography, visual hierarchy | Parallel with writing |
| **Front-End Dev** | Jekyll/Liquid/SCSS implementation | Last — implements designs |

## How to invoke

Open a session in the `itstrieu.github.io` directory and ask for the blog crew. The orchestrator (Claude) will spin up agents as needed. To invoke a specific agent, reference its definition file:

```
Spin up the copy editor — here's the draft: [paste or point to file]
```

Each agent definition in this directory contains the full prompt, context access rules, and voice guidelines needed to brief a fresh agent.

## Workflow

```
1. TOPIC SELECTION
   Career Coach + Positioning Strategist → suggest angles, pick one

2. OUTLINE & DRAFT
   Career Coach shapes narrative → Writer (you) drafts → Reader Advocate reviews

3. EDIT
   Copy Editor refines prose → Reader Advocate confirms it lands

4. PUBLISH PREP
   SEO Strategist sets meta/OG/slug → UI/UX Designer reviews layout
   → Front-End Dev implements any changes → Ship
```

## Voice reference

Precise, unhurried, confident. No exclamation points. No "boost your productivity" copy. When in doubt, write less. See the home-level CLAUDE.md for the full voice spec.
