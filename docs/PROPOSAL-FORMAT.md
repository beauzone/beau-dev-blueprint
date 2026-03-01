# PROPOSAL-FORMAT.md — Multi-LLM Architecture Review Workflow

> Spec for design and architecture proposals that are reviewed by multiple AI models before a human makes final decisions. Read this if you are participating in a proposal as either the Primary Author or a Reviewer.

---

## Overview

This workflow enables multiple AI models to collaborate on architecture and design proposals with structured human oversight. The human (HITL — Human In The Loop) makes all final decisions. AI models contribute analysis, challenge assumptions, surface tradeoffs, and synthesize disagreements — but they do not decide.

**The flow:**

```
Author drafts proposal
       ↓
Reviewer 1 produces structured review
       ↓
Reviewer 2 produces structured review (optional)
       ↓
Author produces synthesis (NOT a defense — a navigation)
       ↓
Human reads synthesis, makes decisions, asks follow-up questions
       ↓
Author incorporates decisions → Final Specification
       ↓
Finalized decisions promoted to docs/decisions/ARCHITECTURE.md as new D-numbers
```

**All proposals live in `docs/proposals/` as a single growing document.**
Each proposal is one file: `PROP-{NNN}-{short-title}.md`
The document grows in sections as each participant contributes.

---

## BLUF Communication Standard

**All human-facing output in this workflow follows BLUF: Bottom Line Up Front.**

The human is not reading at LLM speed. They do not need background, theory, or a recap of the review process. They need the minimum information required to make a decision. If they want more context, they will ask.

**The rule:** Lead with the conclusion. Put reasoning after, not before.

### What this means in practice

**For Section 4.5 (Decisions Required) — the most critical:**
- State the decision in one sentence
- List options as single-line bullets
- Give your recommendation in one line
- Add one sentence of reasoning — maximum
- Each decision item must fit in 5 lines or fewer
- The human must be able to read all of Section 4.5 in under 2 minutes

**For reviews (Sections 2–3):**
- State each concern in 1–3 sentences: label, what's wrong, suggested fix
- No preamble. No "I noticed that..." or "Upon reflection..."
- The label `[V]`, `[T]`, or `[P]` does the categorization work — don't explain the category in prose

**The test:** Read your output. Find the first sentence that actually tells the human something they need to act on. Move that sentence to the top. Delete everything before it.

**Do not:**
- Summarize the review process before stating decisions
- Explain why a concern exists before stating the concern
- Repeat information already present in earlier sections of the document
- Use more words to signal thoroughness — the structure does that, not the word count

**Do:**
- State the decision, option, or recommendation first
- Use the document structure (section numbers, labels, tables) to carry context
- Trust the human to ask if they need more depth

---

## Platform & Ecosystem Awareness

Most systems are designed to be vendor, platform, model, and deployment-model agnostic. **"Agnostic" means no hard dependencies — it does not mean indifferent.** Proposals that touch integration points must account for the platforms target users actually run.

When a proposal involves authentication, data storage, API design, output formats, notification patterns, or user/role management — surface platform compatibility explicitly. Do not assume agnosticism resolves the question.

### Platform Tiers

**Tier 1 — Assume present in the target customer environment (80%+ penetration)**

| Category | Platforms |
|---|---|
| Cloud infrastructure | AWS, Microsoft Azure, Google Cloud Platform |
| Email & productivity | Microsoft 365 (Exchange, SharePoint, Teams), Google Workspace (Gmail, Drive, Docs) |
| Communications | Slack, Microsoft Teams |
| CRM | Salesforce, HubSpot CRM |
| Identity & SSO | Microsoft Entra ID (Azure AD), Okta, Google Identity |

**Tier 2 — Common in 40–60% of target environments**

| Category | Platforms |
|---|---|
| Marketing automation | HubSpot Marketing Hub, Salesforce Marketing Cloud, Marketo (Adobe), Pardot |
| Project management | Asana, Monday.com, Jira (Atlassian) |
| Data warehouse | Snowflake, Google BigQuery, Amazon Redshift, Databricks |
| Analytics & BI | Looker (Google), Tableau (Salesforce), Microsoft Power BI |
| Document collaboration | Notion, Confluence (Atlassian), SharePoint |
| File storage | SharePoint, Google Drive, Box, Dropbox |

### When to flag platform compatibility

Only flag when the proposal makes a choice that actually differs between platforms, or where a stated compatibility requirement is at risk. Do not flag platforms speculatively on every proposal.

**Flag when the proposal involves:**
- **Authentication / identity** — any SSO, RBAC, or access token decision has implications for Entra ID, Okta, and Google Identity (SCIM provisioning, OAuth flows, SAML)
- **Data storage or file format** — where outputs land (SharePoint vs Google Drive vs S3 vs local) and what format affects downstream usability
- **API design or integration points** — REST + JSON is the lowest common denominator; flag if a design creates friction with major platform APIs
- **Output destinations** — if a deliverable is designed to be sent, posted, or synced somewhere, name which platforms must be compatible
- **Notification or webhook patterns** — Slack and Teams webhooks are near-universal in enterprise; email is always present
- **User/role management** — decisions about multi-user access should account for SCIM provisioning patterns and enterprise SSO

**Do not flag when:** the proposal involves only internal logic, configuration structure, or content that has no external integration surface.

### How to categorize platform compatibility concerns

| Situation | Label |
|---|---|
| Design violates a stated compatibility requirement | `[V]` |
| Design works but creates meaningful friction with a Tier 1 platform | `[T]` |
| Design creates friction with a Tier 2 platform | `[T]` — lower priority, note the tier |
| Design creates friction with a niche or non-standard platform | `[P]` or omit — not worth surfacing |

**The goal is not to design for every platform.** It is to ensure the human understands compatibility tradeoffs for the platforms their users actually run.

---

## The Two Roles

The human will tell you at the start of the session which role you are playing. Your reading list, your output format, your mindset, and your discipline are different depending on the role.

---

### Role 1: Primary Author / Architect

**You are assigned this role when:** the human asks you to write an architecture proposal, design a new component, or draft a spec for review.

**Your job:**
- Write a complete, clear proposal that reviewers can engage with
- Be explicit about assumptions and tradeoffs you already see
- Flag your own open questions proactively — don't hide uncertainty
- After reviews arrive: synthesize fairly, not defensively
- Produce a HITL decision summary that genuinely helps the human decide — not one that argues for your position

**What to read before drafting:**
1. Project status doc (see `docs/AI-COLLABORATOR-GUIDE.md` for path)
2. `docs/decisions/ARCHITECTURE.md` — all existing decisions
3. Any standards or format docs relevant to what you're proposing
4. Any existing proposal documents in `docs/proposals/` that are related

**Mindset:** You have thought about this problem more than anyone else in this conversation. Write with confidence. But when synthesizing reviews, your job is to navigate disagreements honestly — not to win them. If a reviewer is right, say so explicitly and update the proposal. If you disagree, explain why clearly and frame it as a decision for the human, not a judgment call you've already made.

**What "synthesizing fairly" means:**
- Group by topic/decision area, not by reviewer name
- For each area: state the question, state all positions with reasoning, state the tradeoff
- If you agree with a reviewer's point: say "Reviewer X raised this; I agree and the proposal should be updated to..."
- If you disagree: say "Reviewer X raised this; I disagree because Y. The tradeoff is Z. The human should decide."
- Never summarize reviewer feedback in a way that makes it sound weaker than it is

**What the synthesis is NOT:**
- Not a defense of the original proposal
- Not a recap organized by reviewer ("Reviewer 1 said... Reviewer 2 said...")
- Not a place to relitigate closed design decisions
- Not a place to make decisions — surface them for the human

---

### Role 2: Reviewer / Architecture Reviewer

**You are assigned this role when:** the human asks you to review an existing proposal and provide feedback.

**Your job:**
- Evaluate the proposal against the project's stated requirements and existing architecture decisions
- Raise concerns that are specific, referenced, and actionable
- Distinguish between violations, tradeoffs, and preferences (see below)
- Ask clarifying questions when you genuinely don't understand intent — don't assume bad intent

**What to read before reviewing:**
1. Project status doc (see `docs/AI-COLLABORATOR-GUIDE.md` for path)
2. `docs/decisions/ARCHITECTURE.md` — all existing decisions; evaluate the proposal's consistency with them
3. The proposal document itself — read it fully before writing a single word of review
4. Any standards or format docs relevant to what's being proposed

**Mindset:** You are evaluating the proposal on its own terms before you evaluate it on yours. A proposal that makes choices you wouldn't have made is not necessarily a bad proposal. Engage with the author's reasoning before proposing alternatives.

**The three-category discipline — every piece of feedback must be categorized:**

| Category | Label | Meaning |
|---|---|---|
| **Violation** | `[V]` | This contradicts a stated requirement, an existing architecture decision, or a non-negotiable constraint. It must change. |
| **Tradeoff** | `[T]` | This is a legitimate design choice, but it has costs that aren't acknowledged. The human should understand the tradeoff before deciding. |
| **Preference** | `[P]` | I would have approached this differently. This is my opinion, not an objective problem. |

**You must label every substantive concern with `[V]`, `[T]`, or `[P]`.** This is the most important discipline in the entire workflow. Unlabeled concerns make synthesis impossible and waste the human's decision-making time.

**What good reviewer feedback looks like:**
- Specific: references a section, decision, or specific detail — not "the approach feels off"
- Actionable: proposes a modification with rationale, or asks a clarifying question
- Scoped: does not propose a rewrite of the entire proposal; proposes targeted changes
- Honest about category: does not label preferences as violations

**What reviewers must NOT do:**
- Propose rewrites — propose specific modifications with rationale
- Relitigate closed decisions without new information
- Treat aesthetic disagreement as an architectural concern
- Label preferences as violations to make them sound more urgent

---

## Document Template

Every proposal document follows this exact structure. Do not add sections. Do not skip sections. Mark sections as `N/A` if genuinely not applicable — do not omit them.

---

```markdown
# PROP-{NNN}: {Title}

**Status:** Draft | Under Review | Synthesis Ready | Decisions Pending | Finalized | Superseded
**Phase context:** {brief context — current sprint, milestone, or phase}
**Related decisions:** {D-numbers from ARCHITECTURE.md, or "None"}
**Author:** {LLM model name / identifier}
**Created:** {YYYY-MM-DD}
**Last updated:** {YYYY-MM-DD}
**Reviewers:** {LLM model name(s) — filled in as reviews are added}

---

## Section 1 — Proposal

*Written by the Author. Do not edit this section after reviews begin. If you want to update based on review feedback, do it in the Final Specification (Section 6).*

### 1.1 Problem Statement

[What problem is being solved? Why does it need to be solved? Why now?
Be specific — "the system needs more flexibility" is not a problem statement.]

### 1.2 Proposed Solution

[High-level description of the approach. One paragraph. Details go in 1.3.]

### 1.3 Design Details

[The full specification. Schema changes, file structure, behavioral rules, naming conventions,
new sections, new fields — whatever is relevant to this proposal.
Be complete. Reviewers cannot evaluate what isn't written down.]

### 1.4 Alternatives Considered

[What other approaches were evaluated? Why were they rejected?
If you only considered one approach, say so and explain why alternatives weren't explored.]

### 1.5 Impact Assessment

| Area | Impact |
|---|---|
| Existing components | [which parts of the system are affected, and how] |
| Interfaces / contracts | [API changes, schema changes, breaking contracts?] |
| Documentation | [which docs need updating] |
| Migration | [is existing content or data affected? is migration required?] |
| Breaking changes | [yes/no — what breaks if this is adopted] |
| Platform compatibility | [which Tier 1/2 platforms are affected and what the compatibility posture is — or "N/A: no external integration surface"] |

### 1.6 Author's Open Questions

[Things you are genuinely uncertain about and want reviewer input on.
Numbering: AQ1, AQ2, AQ3...]

### 1.7 Success Criteria

[How will we know this proposal is correctly implemented?
What does "done" look like?]

---

## Section 2 — Review 1

**Reviewer:** {LLM model name / identifier}
**Date:** {YYYY-MM-DD}
**Overall assessment:** Approve | Approve with modifications | Needs revision | Reject

*Reviewers: label every concern [V], [T], or [P]. See PROPOSAL-FORMAT.md for definitions.*

### 2.1 Points of Agreement

[What you agree with and why. Be specific — "looks good" is not useful.]

### 2.2 Concerns

[Label each concern [V], [T], or [P] and number them C1, C2, C3...
3 lines per concern, maximum. No preamble.]

**C1 [V/T/P]:** {what's wrong — one sentence}
**Ref:** {section number or decision record reference}
**Fix:** {specific change — one sentence, or "See RQ1" if clarification needed first}

### 2.3 Clarifying Questions

[Things you need clarified before you can fully evaluate.
Numbering: RQ1, RQ2, RQ3... (Reviewer Questions, distinct from Author Questions AQ1...)]

### 2.4 Reviewer Summary

[2–4 sentences: overall read, most important concern, what would make you change your assessment.]

---

## Section 3 — Review 2 (if applicable)

**Reviewer:** {LLM model name / identifier}
**Date:** {YYYY-MM-DD}
**Overall assessment:** Approve | Approve with modifications | Needs revision | Reject

*Same structure as Section 2. Note any points where you agree or disagree with Review 1.*

### 3.1 Points of Agreement

### 3.2 Concerns

### 3.3 Clarifying Questions

### 3.4 Agreement / Disagreement with Review 1

[Where do you agree with Review 1? Where do you see it differently? Be specific.]

### 3.5 Reviewer Summary

---

## Section 4 — Author Synthesis

**Author:** {LLM model name / identifier}
**Date:** {YYYY-MM-DD}

*Do not organize this section by reviewer. Organize by topic/decision area.
This section is a navigation tool for the human — not a defense of the proposal.*

### 4.1 Points of Consensus

[What all reviewers agreed on. These are likely safe to proceed with as-is.
If you agree and are updating the proposal, say so explicitly.]

### 4.2 Points of Divergence

[For each area where reviewers disagreed with each other or with the proposal:]

**Topic: {name}**
- **Author position:** {your position}
- **Reviewer position(s):** {what reviewers said, fairly represented}
- **Tradeoff:** {what is gained and lost by each path}
- **Author's recommendation:** {what you think is right and why — honest, not defensive}
- → **Decision required from human:** yes | no (if no, explain why)

[Repeat for each area of divergence]

### 4.3 Author Responses to Reviewer Questions

[Respond to each RQx from the reviews.
Format: **RQ1 response:** {your answer}]

### 4.4 Proposed Updates to Original Proposal

[List any changes you are making to the proposal based on reviewer feedback.
These are changes you agree with — not contested points.
Format: "Updating Section 1.3: {what's changing and why}"]

### 4.5 Decisions Required from Human

*This is the primary output of the synthesis. The human reads this section first.*

**BLUF discipline is mandatory here.** Each decision item must fit in 5 lines or fewer. The human must be able to read all of Section 4.5 in under 2 minutes. No preamble. No recap. State the decision, the options, your recommendation, and stop. If they want background, they will ask.

[Numbered list. Each item is a specific binary or multiple-choice decision.]

**Decision 1: {Title — one line stating what needs to be decided}**
- **A:** {option} — {one-phrase consequence}
- **B:** {option} — {one-phrase consequence}
- **Recommend A** — {one sentence, max}

**Decision 2: {Title}**
[same format — 5 lines max]

**Clarifications needed (not decisions):**
[One line per question. No explanation unless the question is ambiguous without it.]
- {Q1: specific question}
- {Q2: specific question}

---

## Section 5 — HITL Decision Log

*Filled in by the human (or transcribed from the conversation by the Author).*

**Date:** {YYYY-MM-DD}

### 5.1 Human Decisions

**Decision 1:** {Human's answer — verbatim or close paraphrase}
**Decision 2:** {Human's answer}
[...]

### 5.2 Clarifications Provided

[Human's answers to clarification questions from Section 4.5]

### 5.3 Follow-up Discussion

[If the human asked questions or additional discussion was needed before decisions were final,
summarize the key exchanges here.]

### 5.4 Final Decision Summary

| Decision | Choice | Rationale |
|---|---|---|
| 1 | {Option chosen} | {Human's stated reason, or "Per discussion above"} |
| 2 | {Option chosen} | {Human's stated reason} |

---

## Section 6 — Final Specification

**Status:** Finalized
**Date:** {YYYY-MM-DD}
**Author:** {LLM model name / identifier}

*The complete, finalized spec incorporating all decisions from Section 5.
This is the document that gets implemented. It supersedes Section 1.*

### 6.1 Final Design

[Complete specification, updated to reflect all decisions.]

### 6.2 Impact on ARCHITECTURE.md

[List the new D-numbers that should be added to docs/decisions/ARCHITECTURE.md as a result of this proposal.
Format:
**D{NN}: {Decision title}** — {1–2 sentence summary for the ARCHITECTURE.md entry}]

### 6.3 Implementation Checklist

[Everything that needs to happen to implement this proposal, in dependency order.]

- [ ] {Task 1}
- [ ] {Task 2}
- [ ] {Task 3}

### 6.4 Files to Create or Modify

| File | Action | Notes |
|---|---|---|
| `path/to/file` | Create / Modify / Delete | {what changes} |

```

---

## Status States

| Status | Meaning |
|---|---|
| **Draft** | Author has written Section 1. No reviews yet. |
| **Under Review** | One or more reviews in progress or complete. Author synthesis not yet written. |
| **Synthesis Ready** | Author has completed Section 4. Human has not yet made decisions. |
| **Decisions Pending** | Human is engaged, decisions are being made. Section 5 being filled in. |
| **Finalized** | All decisions made. Section 6 complete. Ready to implement. |
| **Superseded** | Replaced by a later proposal (link to replacement). |

Update the `**Status:**` field in the document header whenever the status changes.

---

## Filing Conventions

### Numbering
Proposals are numbered sequentially: `PROP-001`, `PROP-002`, `PROP-003`...
Check `docs/proposals/` for the highest existing number before creating a new proposal.

### File naming
`PROP-{NNN}-{short-kebab-case-title}.md`

Examples:
- `PROP-001-auth-provider-selection.md`
- `PROP-002-data-storage-schema.md`
- `PROP-003-api-versioning-strategy.md`

### Location
All proposal documents live in `docs/proposals/`.

### Cross-referencing
When a proposal's decision is promoted to `docs/decisions/ARCHITECTURE.md`, add a reference in the proposal document's Section 6.2, and add a footnote in ARCHITECTURE.md:

```
**D{NN}: {Title}** — {description}
*Review trail: [PROP-{NNN}](../proposals/PROP-{NNN}-{title}.md)*
```

---

## Promoting Decisions to ARCHITECTURE.md

When a proposal is Finalized, the Author is responsible for:

1. Adding each new design decision from Section 6.2 to `docs/decisions/ARCHITECTURE.md` as a new D-number entry
2. Including a "Review trail" link back to the proposal document
3. Committing the finalized proposal document and ARCHITECTURE.md update together in a single commit

**D-numbers are permanent and sequential.** Never reuse a D-number. Never renumber existing decisions. The next D-number after the current highest is yours.

---

## Quality Checklist for Authors

Before marking a proposal as ready for review:

- [ ] Section 1.1 states a specific problem, not a vague goal
- [ ] Section 1.3 is complete enough that a reviewer can evaluate it without asking "what do you mean?"
- [ ] Section 1.4 lists at least one alternative that was considered (even if quickly rejected)
- [ ] Section 1.5 impact assessment is honest — not minimized
- [ ] Section 1.5 platform compatibility row is filled in — either named platforms with posture, or "N/A: no external integration surface"
- [ ] Section 1.6 open questions are genuinely open — not rhetorical
- [ ] Section 1.7 success criteria are specific enough to verify

Before marking a synthesis as ready for human review:

- [ ] Section 4.5 decisions are framed as options, not as "Reviewer X thinks vs Reviewer Y thinks"
- [ ] Every decision in 4.5 has a clear "Recommend" with a one-sentence reason
- [ ] Every decision item in 4.5 is 5 lines or fewer — no exceptions
- [ ] Section 4.5 can be read in full in under 2 minutes
- [ ] Reviewer concerns are represented fairly — not softened
- [ ] Points where author agreed with reviewers are explicitly called out in 4.4
- [ ] No open reviewer questions (RQx) have been left unanswered in 4.3
- [ ] No section opens with a preamble — lead with the substance

## Quality Checklist for Reviewers

Before submitting a review:

- [ ] Every concern in Section 2.2 is labeled [V], [T], or [P]
- [ ] Every concern is 3 lines or fewer (what's wrong / reference / fix)
- [ ] Every [V] concern cites the specific requirement or decision it violates
- [ ] Every [P] concern is honest about being a preference — not dressed up as a tradeoff
- [ ] Suggested modifications are specific changes, not rewrites
- [ ] Clarifying questions (2.3) are one line each — genuine questions, not rhetorical objections
- [ ] Platform compatibility has been assessed — Tier 1 friction flagged as [T] or [V] where the proposal has an external integration surface; Tier 2 friction flagged as lower-priority [T]

---

*Last updated: 2026-03-01*
