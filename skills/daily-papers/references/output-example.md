<!-- 
  本文件为 daily-papers skill 的输出格式示例。
  实际输出中的论文内容、arXiv ID、日期等均为动态生成。
  Agent 生成报告时应严格参考此格式。
-->

# 📡 每日论文推送 — 2026年4月10日

> 研究方向: LLM Reasoning · Agentic Memory · RL for LLM
> 来源: arXiv (cs.CL, cs.AI, cs.LG) | 论文数: 12
> 生成模型: GLM-4-Plus | 偏好配置: config.yaml

---

## 🔥 今日重点推荐

### 1. Recursive Reasoning Agents: Learning to Decompose and Self-Correct
**作者:** Yifan Li, Zhihao Zhang, Wei Chen (Tsinghua University)
**arXiv:** [2604.05821](https://arxiv.org/abs/2604.05821) | cs.AI | 2026-04-09

**核心贡献:** 提出递归推理框架 R2Agent，让 agent 在推理过程中自动将复杂问题分解为子问题，并在子问题求解失败时递归回溯修正。
- 在 GPQA-Diamond 上将 pass@1 从 51.2% 提升至 63.7%
- 关键创新：引入"推理栈"机制，维护分解树的状态追踪
- 与 config.yaml 偏好匹配度: ⭐⭐⭐ (agentic + reasoning)

---

### 2. Memory-Augmented Reasoning: Retrieval Meets Chain-of-Thought
**作者:** Sarah Park, David Kim, Jianfeng Gao (Microsoft Research)
**arXiv:** [2604.05733](https://arxiv.org/abs/2604.05733) | cs.CL | 2026-04-09

**核心贡献:** 将外部记忆检索与 CoT 推理深度融合，提出 MemCoT 架构——在推理的每一步动态检索相关知识片段辅助下一步推导。
- 在知识密集型推理任务(MuSiQue, HotpotQA)上提升 8-12%
- 记忆更新采用对比学习，推理过程中在线优化记忆表征
- 与 config.yaml 偏好匹配度: ⭐⭐⭐ (agentic memory + reasoning)

---

## 📋 今日论文列表

### LLM Reasoning（5篇）

| # | 标题 | 机构 | 一句话摘要 |
|---|------|------|-----------|
| 3 | [Reward Shaping for Long-Horizon Reasoning](https://arxiv.org/abs/2604.05692) | UC Berkeley | 针对长链推理中奖励稀疏问题，提出基于中间状态价值估计的 reward shaping 方法，MATH-500 提升 4.2% |
| 4 | [SpeculativeCoT: Fast and Faithful Chain-of-Thought](https://arxiv.org/abs/2604.05641) | CMU | 用小模型起草推理链、大模型验证，推理速度提升 2.8× 而准确率仅降 0.3% |
| 5 | [Process Reward Models Need Less Data Than You Think](https://arxiv.org/abs/2604.05588) | DeepMind | 发现只需 5K 高质量步骤级标注即可训练出有效 PRM，重新定义了数据效率基线 |
| 6 | [Reasoning in Latent Space via Discrete Flow Matching](https://arxiv.org/abs/2604.05510) | UIUC + Meta | 将离散流匹配应用于潜空间推理，在规划类任务上超越自回归 CoT |

### Agentic Systems（4篇）

| # | 标题 | 机构 | 一句话摘要 |
|---|------|------|-----------|
| 7 | [Agent-as-Critic: Self-Evaluating Tool Use in LLM Agents](https://arxiv.org/abs/2604.05477) | Stanford | Agent 在工具调用后自动评估执行结果质量，决定是否重试或换工具 |
| 8 | [Persistent Memory for Conversational Agents](https://arxiv.org/abs/2604.05423) | Google | 提出分层持久记忆架构（工作记忆 + 长期记忆 + 情景记忆），7 天对话连贯性提升 34% |
| 9 | [Multi-Agent Debate Improves Factuality](https://arxiv.org/abs/2604.05389) | Anthropic | 多 agent 辩论机制在事实性生成任务上将幻觉率从 12.3% 降至 4.1% |
| 10 | [Agentic Workflow Synthesis from Natural Language](https://arxiv.org/abs/2604.05301) | PKU | 自然语言描述自动编译为 agent 工作流 DAG，支持条件分支和并行执行 |

### RL for LLM（2篇）

| # | 标题 | 机构 | 一句话摘要 |
|---|------|------|-----------|
| 11 | [GRPO++: Variance Reduction for Group Relative Policy Optimization](https://arxiv.org/abs/2604.05267) | ByteDance | 在 GRPO 基础上引入控制变量法降低梯度方差，训练稳定性显著提升 |
| 12 | [Curriculum RL for Mathematical Reasoning](https://arxiv.org/abs/2604.05198) | Zhipu AI | 自适应课程学习策略，根据模型当前能力动态选择训练题目难度 |

---

## 📊 今日统计

| 子方向 | 篇数 | 匹配度 |
|--------|------|--------|
| LLM Reasoning | 5 | ⭐⭐⭐ |
| Agentic Systems | 4 | ⭐⭐⭐ |
| RL for LLM | 2 | ⭐⭐ |
| 跨领域（重点推荐） | 2 | ⭐⭐⭐ |
| **合计** | **12** | — |

## 💡 趋势观察

今日推送中有 3 篇论文同时涉及"agent + memory"和"reasoning"的交叉，延续了近两周"推理型 agent"的研究热度。此外，潜空间推理方向（#6）值得持续关注——这是本周第 3 篇相关工作。

---

*本推送由 GLM-4-Plus 基于 config.yaml 中的研究偏好自动筛选生成。论文 arXiv ID 为模拟生成，具体内容请以 arXiv 原文为准。*
*如需调整推送偏好，回复："更新我的研究方向"*
