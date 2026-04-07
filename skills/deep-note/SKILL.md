---
name: deep-note
description: >
  Given a specific paper (arXiv link or ID), generate a structured Deep Note
  with 7 sections covering motivation, method, experiments, and critical analysis.
  Trigger: deep note, 帮我读, 论文笔记, read this paper.
---

# Deep Note — Single-Paper Deep Reading Note

## Goal
Given one paper (arXiv link, ID, or PDF URL), produce a structured 7-section deep
reading note in markdown.

## Triggers
`deep note [link]` · `帮我读 [link]` · `论文笔记 [link]` · `read this paper [link]`

---

## Step 1 — Parse Input

Extract the paper identifier:
- arXiv link → extract ID (e.g., `2401.12345`)
- arXiv ID → use directly
- PDF URL → fetch and process

## Step 2 — Fetch Paper Content

Strategy (try in order):
1. `web_fetch("https://arxiv.org/abs/{id}")` for abstract + metadata
2. `web_fetch("https://arxiv.org/html/{id}")` for full HTML version (preferred)
3. If HTML unavailable, `web_fetch("https://ar5iv.labs.arxiv.org/html/{id}")`

Extract: title, authors, abstract, full text (sections, figures, tables).

**Important:** If the paper is long (>300 lines), focus on: abstract, introduction,
method section, experiment results, and conclusion. Skip related work details.

## Step 3 — Generate Deep Note

Use this 7-section template:

```markdown
# {Paper Title}

> **Authors:** {authors}
> **Published:** {date} | **arXiv:** [{id}](https://arxiv.org/abs/{id})
> **Generated:** {today's date}

## 1. 一句话总结 (One-Line Summary)
{One sentence capturing the core contribution}

## 2. 动机与问题 (Motivation & Problem)
- What problem does this paper address?
- Why is it important / what gap does it fill?
- What are the limitations of prior work?

## 3. 方法 (Method)
- Core technical approach (with key equations if applicable)
- Architecture / algorithm overview
- What makes this different from prior approaches?

## 4. 实验 (Experiments)
- Datasets and baselines used
- Key results (quote specific numbers)
- Ablation study highlights

## 5. 亮点与局限 (Strengths & Limitations)
**Strengths:**
- {strength 1}
- {strength 2}

**Limitations:**
- {limitation 1}
- {limitation 2}

## 6. 相关工作脉络 (Related Work Context)
- Where does this fit in the research landscape?
- Key related papers and how they differ

## 7. 个人思考 (Personal Thoughts)
- Potential extensions or follow-up ideas
- Relevance to current research trends
- Would I recommend reading this? Why?
```

## Step 4 — Save & Report

Save to the current working directory as `deepnote_{arxiv_id}_{date}.md`.
Output a brief summary in chat with the file path and the one-line summary.

---

## Step 5 — Update Preferences

After delivering the deep note, observe user feedback:
- If user finds the paper valuable → boost related topic keywords in config.yaml
- If user says it was not useful → reduce related topic weights
- If this paper introduces a new research direction for the user → add as new interest

Follow the procedure in `skills/preference-evolving/SKILL.md` to update config.yaml.

---

## Quality Guidelines
- Be specific: quote numbers, name techniques, reference figures/tables
- Be critical: don't just summarize — evaluate strengths AND weaknesses
- Be concise: each section should be 3-8 bullet points, not paragraphs
- Use the paper's own terminology consistently
- If you cannot access the full paper, be transparent about it and work with the abstract
