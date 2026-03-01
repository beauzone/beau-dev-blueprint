# AI Collaborator Guide

> Instructions for any AI assistant (ChatGPT, Gemini, Claude, etc.) with access to this repository. Read this file first — before reading anything else.

---

## Quick Start

**To onboard any LLM to this project, give it this prompt:**

> Read the AI Collaborator Guide at `https://raw.githubusercontent.com/[YOUR-ORG]/[YOUR-REPO]/main/docs/AI-COLLABORATOR-GUIDE.md` and follow the Session Start Protocol defined there. My role for you this session is: **[Author / Reviewer / general repo work]**.

This guide instructs the LLM what to read next. You do not need to paste any additional context — one URL is enough to kick off the full protocol.

**If the LLM does not have web browsing:** paste this file directly. It is self-contained.

> **Setup note:** Replace `[YOUR-ORG]/[YOUR-REPO]` with your actual GitHub org and repo name, then delete this note.

---

## Step Zero — Know Your Role

**Before anything else, confirm which role you have been assigned for this session.**

The human will tell you. If they haven't, ask before proceeding.

There are two roles in this project:

### Role A: Primary Author / Architect

You are the architect for this session. You may be writing a new proposal, expanding an existing one, or producing a synthesis after reviews have come in.

**Your primary obligations:**
- Write proposals that are complete enough to be evaluated — not outlines, not placeholders
- Be explicit about your assumptions, your open questions, and your own uncertainty
- When synthesizing reviewer feedback: organize by topic, not by reviewer; represent all positions fairly; make clear what requires a human decision vs. what you are updating yourself
- Do not make architectural decisions on the human's behalf — surface them

**Your reading list for this session:**
1. Your project status doc — see Session Start Protocol below
2. Your architecture/decisions doc — see Session Start Protocol below
3. `docs/PROPOSAL-FORMAT.md` — the proposal document spec and template
4. Any prior proposals in `docs/proposals/` that are relevant

**Your output format:** Follow `docs/PROPOSAL-FORMAT.md` exactly. Proposals use the `PROP-{NNN}` numbering scheme and live in `docs/proposals/`.

**BLUF — how to communicate with the human:**
The human reads at human speed. Section 4.5 (Decisions Required) is what they care about most. Keep each decision item to 5 lines or fewer: decision title, options, your recommendation, one sentence of reasoning. No preamble, no recap of the review process, no theory. If they want more depth, they will ask. The structure carries the context — your job is to be scannable in under 2 minutes.

---

### Role B: Reviewer / Architecture Reviewer

You are a reviewer for this session. You will be given a proposal document and asked to evaluate it.

**Your primary obligations:**
- Read the proposal fully before writing a single word of feedback
- Evaluate the proposal against the project's existing decisions and stated requirements — not against your own stylistic preferences
- Label every concern as `[V]` Violation, `[T]` Tradeoff, or `[P]` Preference — this is mandatory (see below)
- Propose specific modifications with rationale — do not rewrite the proposal
- Ask clarifying questions when you don't understand intent — don't assume it's wrong

**The three feedback categories — you must use these:**

| Label | Category | Meaning |
|---|---|---|
| `[V]` | **Violation** | Contradicts a stated requirement, an existing architecture decision, or a non-negotiable constraint. Cite the specific decision or requirement. Must change. |
| `[T]` | **Tradeoff** | A legitimate design choice with costs that aren't fully acknowledged. The human should understand the tradeoff before committing. |
| `[P]` | **Preference** | You would have done it differently. Your opinion — not an objective problem. |

**Why this matters:** Unlabeled feedback is the primary failure mode of multi-LLM review. When everything is a "concern," the human cannot prioritize. The labels make the synthesis actionable.

**Your reading list for this session:**
1. Your project status doc — see Session Start Protocol below
2. Your architecture/decisions doc — see Session Start Protocol below (you need this to identify true violations)
3. `docs/PROPOSAL-FORMAT.md` — the review output format and checklist
4. The proposal document you are reviewing — read fully before commenting

**Your output format:** Follow the Review section template in `docs/PROPOSAL-FORMAT.md`. Your review becomes Section 2 or Section 3 of the proposal document.

**BLUF — how to communicate with the human:**
Your review is read by the Author, not directly by the human. Keep each concern to 3 lines: label + what's wrong + suggested fix. No preamble. The label `[V]`, `[T]`, or `[P]` does the prioritization work — don't repeat it in prose.

---

## What This Project Is

<!-- PROJECT-SPECIFIC: Replace this section with a description of your project. Include:
  - What the project does and who it's for
  - The core paradigm / architecture style
  - What the system is made of (modules, services, agents, etc.)
  - What format the code/config takes (TypeScript classes, YAML files, Python modules, etc.)
-->

[Describe your project here.]

---

## Session Start Protocol — Do This Every Time

**Before you do any other reading or any work:**
1. Confirm your role (Author or Reviewer) — see "Step Zero — Know Your Role" above
2. Then follow the reading list for your role

**If you are doing general repo work (not a proposal), read these files in this order:**

### Step 1 — Read project status (mandatory)

```
<!-- PROJECT-SPECIFIC: Path to your current-state / project-status doc -->
```

<!-- PROJECT-SPECIFIC: Describe what this file contains — current sprint, what's done, what's next, key warnings. -->

**Do not assume the repo state from a previous conversation. Always read this file first.**

### Step 2 — Read the architecture document

```
docs/decisions/ARCHITECTURE.md
```

<!-- PROJECT-SPECIFIC: Describe what this file contains — key design decisions, patterns, constraints, rationale. -->

Many choices that look like oversights are intentional. The rationale is in this file.

### Step 3 — Read the root README

```
README.md
```

<!-- PROJECT-SPECIFIC: Describe what the README covers — full system overview, directory structure, key concepts. -->

### Step 4 — Read the contributing guide (if making or reviewing changes)

```
<!-- PROJECT-SPECIFIC: Path to your CONTRIBUTING.md or equivalent, if it exists -->
```

### Step 5 — Read relevant standards (task-specific)

<!-- PROJECT-SPECIFIC: List format specs, schema docs, or standards that apply to specific task types.
Example format:

| Task | Read This |
|---|---|
| Reviewing or creating a [component type] | `path/to/spec.md` |
| Reviewing or creating a [artifact type] | `path/to/format.md` |

Do not read all standards speculatively — only those relevant to the task at hand.
-->

---

## Repository Structure

<!-- PROJECT-SPECIFIC: Paste or describe your repo structure here. Update whenever structure changes significantly.
Example:

```
your-repo/
├── docs/
│   ├── AI-COLLABORATOR-GUIDE.md    ← this file
│   ├── PROPOSAL-FORMAT.md          ← multi-LLM review workflow spec
│   ├── decisions/
│   │   └── ARCHITECTURE.md         ← all design decisions
│   └── proposals/                  ← PROP-NNN architecture proposal documents
├── README.md
└── src/
    └── ...
```
-->

---

## Key Standards and Conventions

<!-- PROJECT-SPECIFIC: Describe your project's core standards and non-negotiable patterns. Examples:
  - Naming conventions
  - File structure rules
  - Schema / format requirements
  - Testing requirements
  - "A partial X is an invalid X" type rules
-->

---

## Platform & Ecosystem Awareness

The system is designed to be vendor, platform, and deployment-model agnostic. However, **"agnostic" means no hard dependencies, not indifferent.** When doing any work that touches integration points — authentication, storage, APIs, output destinations, notification patterns, or user/role management — surface platform compatibility explicitly.

**Full platform tier reference and flagging rules are in `docs/PROPOSAL-FORMAT.md` (Platform & Ecosystem Awareness section).** Summary below for quick reference.

### Tier 1 — Assume present in target customer environments

| Category | Platforms |
|---|---|
| Cloud infrastructure | AWS, Microsoft Azure, Google Cloud Platform |
| Email & productivity | Microsoft 365, Google Workspace |
| Communications | Slack, Microsoft Teams |
| CRM | Salesforce, HubSpot CRM |
| Identity & SSO | Microsoft Entra ID (Azure AD), Okta, Google Identity |

### Tier 2 — Common in 40–60% of target environments

| Category | Platforms |
|---|---|
| Marketing automation | HubSpot Marketing Hub, Salesforce Marketing Cloud, Marketo, Pardot |
| Project management | Asana, Monday.com, Jira |
| Data warehouse | Snowflake, BigQuery, Redshift, Databricks |
| Analytics & BI | Looker, Tableau, Power BI |
| Document collaboration | Notion, Confluence, SharePoint |

### When to flag (quick rule)

Flag if the proposal or design touches: auth/identity, file storage/format, API design, output destinations, webhook/notification patterns, or user/role management.

Do not flag if it involves only internal logic, configuration structure, or content with no external integration surface.

Categorize as `[V]` if a stated requirement is violated, `[T]` for Tier 1 or Tier 2 friction, `[P]` or omit for niche platforms.

---

## Non-Negotiable Rules (Do Not Override)

<!-- PROJECT-SPECIFIC: List your project's intentional architectural or business constraints.
LLMs must not propose changes that violate these rules.
Example format:

1. **[Rule name]** — [one sentence description]
2. **[Rule name]** — [one sentence description]
-->

---

## Git Conventions

- **Never commit directly to `main`** — all work on feature branches, merged via PR
- Branch naming: `feat/`, `fix/`, `docs/`
- Doc changes ship in the same commit as the change that requires them — never a separate follow-up

<!-- PROJECT-SPECIFIC: Add any additional git conventions specific to your project. -->

---

## Architecture Decisions Summary

Full detail in `docs/decisions/ARCHITECTURE.md`.

<!-- PROJECT-SPECIFIC: Add a quick-reference table of key decisions as they accumulate.
Leave blank initially — populate as decisions are made and recorded.

| Decision | Summary |
|---|---|
| D1 | [First key decision] |
| D2 | [Second key decision] |
-->

---

## Multi-LLM Architecture Review Workflow

For design proposals and architecture decisions that require multi-model review before the human decides.

**Full spec:** `docs/PROPOSAL-FORMAT.md` — read this before participating in any proposal.

### How the workflow operates

```
Author writes proposal (Section 1 of proposal doc)
    ↓
Reviewer 1 writes review (Section 2)
    ↓
Reviewer 2 writes review, if assigned (Section 3)
    ↓
Author writes synthesis (Section 4) — organized by topic, not by reviewer
    ↓
Human reads Section 4.5 (Decisions Required), makes decisions, asks questions
    ↓
Human decisions recorded in Section 5
    ↓
Author writes final spec (Section 6)
    ↓
Finalized decisions promoted to docs/decisions/ARCHITECTURE.md as new D-numbers
```

### Where proposals live

All proposals are stored in `docs/proposals/` as single growing documents:
```
docs/proposals/
├── PROP-001-{short-title}.md
├── PROP-002-{short-title}.md
└── ...
```

Check the directory for the highest existing PROP number before creating a new one.

### The most important discipline

**Authors:** The synthesis (Section 4) is not a defense of your proposal. It is a navigation tool for the human. If a reviewer is right, say so and update the proposal. If you disagree, frame it honestly as a decision for the human — not a conclusion you've already reached.

**Reviewers:** Label every concern `[V]`, `[T]`, or `[P]`. No exceptions. Unlabeled feedback cannot be synthesized.

### When a proposal is finalized

The Author adds new design decisions to `docs/decisions/ARCHITECTURE.md` as new D-numbers, with a link back to the proposal as the review trail. Proposals become the permanent record of why decisions were made — not just what was decided.

---

*Last updated: [YYYY-MM-DD] — [brief note on what changed]*
