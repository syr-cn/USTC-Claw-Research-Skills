---
name: paper-survey
description: >
  Given a research direction, automatically search arXiv for recent papers
  and generate a structured survey report. Trigger: survey, 帮我调研, 论文综述, paper survey.
---

# Paper Survey — Automated Literature Survey

## Goal
Given a research topic/direction, search for 15-20 recent relevant papers and produce
a structured survey report in markdown.

## Triggers
`survey [topic]` · `帮我调研 [topic]` · `论文综述 [topic]` · `paper survey [topic]`

---

## Step 1 — Parse Topic

Extract the core research direction from user input. Examples:
- "survey agentic memory systems" → topic = "agentic memory systems"
- "帮我调研 LLM reasoning with RL" → topic = "LLM reasoning with reinforcement learning"

## Step 2 — Search Papers

Use `tavily_search` or `web_search` to find recent papers:

```
Query 1: "{topic} arxiv 2025 2026"
Query 2: "{topic} survey recent advances"
Query 3: "{sub-topic-1} arxiv"  (if needed for coverage)
```

Also try: `web_fetch("https://arxiv.org/search/?query={topic}&searchtype=all&order=-announced_date_first")`

Collect 15-20 papers. For each extract: title, authors, arXiv ID, date, one-sentence summary.

## Step 3 — Categorize & Analyze

Group papers into 3-5 sub-topics based on methodology or application area.
Identify: key trends, common techniques, open problems.

## Step 4 — Generate Report

Output a markdown file with this structure:

```markdown
# Survey: {Topic}
> Generated: {date} | Papers: {count} | Period: {date range}

## Overview
{2-3 paragraph overview of the field}

## Paper Categories

### Category 1: {Sub-topic Name}
| # | Title | Authors | Year | Key Contribution |
|---|-------|---------|------|-----------------|
| 1 | ... | ... | ... | ... |

### Category 2: {Sub-topic Name}
...

## Key Trends
1. {Trend 1 with evidence}
2. {Trend 2 with evidence}
3. {Trend 3 with evidence}

## Open Problems
1. {Problem 1}
2. {Problem 2}
3. {Problem 3}

## Top 5 Must-Reads
| # | Paper | Why Read |
|---|-------|----------|
| 1 | [{title}](https://arxiv.org/abs/{id}) | {reason} |
| 2 | ... | ... |

## References
{Full list with arXiv links}
```

## Step 5 — Save & Report

Save the report to the current working directory as `survey_{topic_slug}_{date}.md`.
Output a brief summary in chat with the file path.

---

## Step 6 — Update Preferences

After delivering the survey report, observe user feedback:
- If user highlights specific papers positively → boost those topic keywords in config.yaml
- If user says certain papers are irrelevant → reduce those topic weights
- If user requests a follow-up survey on a sub-topic → add that as a new interest

Follow the procedure in `skills/preference-evolving/SKILL.md` to update config.yaml.

---

## Tips
- Prefer papers from the last 12 months unless the topic requires historical context
- Include both highly-cited foundational work AND cutting-edge preprints
- Be honest about coverage gaps — note if certain sub-areas need deeper search
- If user has a research profile config, use it to highlight personally relevant papers
