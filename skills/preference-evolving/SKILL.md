---
name: preference-evolving
description: >
  Continuously learns user research preferences from interaction signals.
  Auto-updates config.yaml weights after survey/deep-note sessions.
  Triggers: after every paper-survey or deep-note interaction completes.
---

# Preference Evolving - Adaptive Research Taste Learning

## Goal
Observe user feedback during and after paper-survey / deep-note interactions,
detect implicit preference signals, and auto-update config.yaml to keep
recommendations aligned with evolving research interests.

## When to Trigger
Run this skill as a **post-step** after completing any paper-survey or deep-note task.
Also trigger when user explicitly updates preferences.

## Signal Detection

Watch for these cues in user responses:

| Signal | Example | Action |
|--------|---------|--------|
| Positive feedback | "interesting", "mark this" | Boost keyword weight +0.1 |
| Negative feedback | "not relevant", "skip" | Reduce keyword weight -0.1 |
| New topic request | "survey [new topic]" | Add keyword with weight 0.5 |
| Repeated ignoring | User skips same category 3x | Mark as low-priority (weight 0.2) |
| Explicit update | "update my interests" | Rewrite interests per user input |

## Config Schema (config.yaml)

```yaml
research_interests:
  - keyword: "agentic memory"
    weight: 0.9
    added: "2026-04-07"
    source: "initial setup"
  - keyword: "RL for LLM reasoning"
    weight: 0.7
    added: "2026-04-07"
    source: "user surveyed this topic"
language: auto
survey_paper_count: 20
note_language: zh
preference_history:
  - date: "2026-04-07"
    action: "added keyword: agentic memory (weight 0.9)"
    reason: "initial setup from user input"
```

## Update Procedure

### Step 1 - Detect Signal
After a survey/deep-note interaction ends, review the conversation for signals above.

### Step 2 - Read Current Config
Read `config.yaml` from the skill installation directory.
If it does not exist, create a default one from the user's initial message.

### Step 3 - Apply Changes
- For weight changes: clamp to [0.1, 1.0], round to 1 decimal
- For new keywords: add with weight 0.5, source = context description
- For removals: only remove if weight drops below 0.1

### Step 4 - Log History
Append an entry to preference_history with date, action, and reason.
Keep only the last 20 history entries to avoid file bloat.

### Step 5 - Write Config
Write updated config.yaml back. Inform user briefly:
"Updated your preferences: boosted [X], added [Y]"

## Integration with Other Skills

- **paper-survey Step 6**: After generating report, check user feedback and call this skill
- **deep-note Step 5**: After generating note, check user feedback and call this skill
- Both skills should read config.yaml at start to sort/filter results by keyword weights
