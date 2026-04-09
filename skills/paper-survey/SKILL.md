---
name: paper-survey
description: >
  给定研究方向，自动搜索 arXiv 近期论文并生成结构化 survey 报告。
  触发词：survey, 帮我调研, 论文综述, paper survey。
---

# Paper Survey — 自动文献综述

## 目标
给定一个研究主题/方向，搜索 15-20 篇近期相关论文，生成结构化的 survey 报告（markdown 格式）。

## 触发词
`survey [主题]` · `帮我调研 [主题]` · `论文综述 [主题]` · `paper survey [主题]`

---

## 第 1 步 — 解析主题

从用户输入中提取核心研究方向。示例：
- "survey agentic memory systems" → topic = "agentic memory systems"
- "帮我调研 LLM reasoning with RL" → topic = "LLM reasoning with reinforcement learning"

## 第 2 步 — 搜索论文

使用 `tavily_search` 或 `web_search` 搜索近期论文：

```
Query 1: "{topic} arxiv 2025 2026"
Query 2: "{topic} survey recent advances"
Query 3: "{sub-topic-1} arxiv"  （按需补充覆盖面）
```

也可以尝试：`web_fetch("https://arxiv.org/search/?query={topic}&searchtype=all&order=-announced_date_first")`

收集 15-20 篇论文。对每篇提取：标题、作者、arXiv ID、日期、一句话摘要。

## 第 3 步 — 分类与分析

将论文按方法或应用领域分为 3-5 个子方向。
识别：主要趋势、常用技术、开放问题。

## 第 4 步 — 生成报告

输出如下结构的 markdown 文件：

```markdown
# Survey: {Topic}
> 生成日期: {date} | 论文数量: {count} | 时间跨度: {date range}

## 概览
{2-3 段对该领域的总体概述}

## 论文分类

### 分类 1: {子方向名称}
| # | 标题 | 作者 | 年份 | 核心贡献 |
|---|------|------|------|----------|
| 1 | ... | ... | ... | ... |

### 分类 2: {子方向名称}
...

## 主要趋势
1. {趋势 1 及其证据}
2. {趋势 2 及其证据}
3. {趋势 3 及其证据}

## 开放问题
1. {问题 1}
2. {问题 2}
3. {问题 3}

## Top 5 必读论文
| # | 论文 | 推荐理由 |
|---|------|----------|
| 1 | [{title}](https://arxiv.org/abs/{id}) | {reason} |
| 2 | ... | ... |

## 参考文献
{完整列表，附 arXiv 链接}
```

## 第 5 步 — 保存并汇报

将报告保存到当前工作目录，文件名为 `survey_{topic_slug}_{date}.md`。
在对话中输出简要摘要和文件路径。

---

## 第 6 步 — 更新偏好

交付 survey 报告后，观察用户反馈：
- 如果用户对某些论文给出正面评价 → 在 config.yaml 中提升相关关键词权重
- 如果用户说某些论文不相关 → 降低相关关键词权重
- 如果用户要求对某个子方向做进一步调研 → 添加为新兴趣方向

按照 `skills/preference-evolving/SKILL.md` 中的流程更新 config.yaml。

---

## 提示
- 优先选取最近 12 个月内的论文，除非该主题需要历史背景
- 同时包含高引用的基础性工作和最新的预印本
- 对覆盖面的不足要坦诚说明——注明哪些子领域需要更深入的搜索
- 如果用户已有研究偏好配置，利用它来突出个人相关度高的论文
