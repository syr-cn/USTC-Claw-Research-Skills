---
name: ustc-claw-research
description: >
  即插即用的研究生论文助手，两大核心能力：(1) 给定研究方向，自动 survey 相关论文并生成结构化报告；
  (2) 给定一篇论文，生成 Deep Note 深度阅读笔记。
  触发词：survey, 帮我调研, 论文综述, deep note, 帮我读, 论文笔记, paper survey, 读这篇论文
metadata:
  openclaw:
    homepage: https://github.com/syr-cn/USTC-Claw-Research-Skills
    version: "1.0.0"
    author: AlphaLab-USTC
---

# USTC Claw Research Skills

即插即用的研究生论文助手。两个原子 skill，零配置开箱即用。

## Skills

| # | Skill | 触发词 | 功能 |
|---|-------|--------|------|
| 1 | **Paper Survey** 📡 | `survey [方向]` / `帮我调研 [方向]` | 给定研究方向，自动搜索 arXiv 论文，生成结构化 survey 报告 |
| 2 | **Deep Note** 📝 | `deep note [arXiv link]` / `帮我读 [link]` | 给定论文，生成 7-section 深度阅读笔记 |

## 一句话安装

把这句话发给你的 OpenClaw / Codex / Claude Code agent：

```
帮我安装 USTC Claw Research Skills：https://raw.githubusercontent.com/syr-cn/USTC-Claw-Research-Skills/main/docs/install.md
```

## 快速配置（可选）

安装后告诉 agent 你的研究方向即可个性化推荐：

```
我的研究方向是：强化学习 + 大语言模型推理 + Agent 记忆系统
```

不配置也能用，只是搜索结果不会按个人兴趣排序。
