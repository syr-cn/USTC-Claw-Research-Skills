---
name: ustc-claw-research
description: >
  即插即用的研究生论文助手，两大核心能力：(1) 给定研究方向，自动 survey 相关论文并生成结构化报告；
  (2) 给定一篇论文，生成 Deep Note 深度阅读笔记。
  触发词：survey, 帮我调研, 论文综述, deep note, 帮我读, 论文笔记, paper survey, 读这篇论文,
  安装这个repo, install this repo
metadata:
  openclaw:
    homepage: https://github.com/syr-cn/USTC-Claw-Research-Skills
    version: "1.0.0"
    author: AlphaLab-USTC
---

# USTC Claw Research Skills

即插即用的研究生论文助手。两个原子 skill，一句话安装+配置。

## 一句话安装

当用户说类似以下内容时，执行 Setup 流程：

```
安装这个 repo：https://github.com/syr-cn/USTC-Claw-Research-Skills ，并且配置我的偏好：[研究方向]
```

### Setup 流程

1. **Clone repo：**
   ```bash
   cd ~/.openclaw/workspace/skills
   git clone https://github.com/syr-cn/USTC-Claw-Research-Skills.git
   ```

2. **解析用户偏好，生成 config.yaml：**
   从用户的一句话中提取研究方向关键词，写入配置文件：
   ```bash
   cat > ~/.openclaw/workspace/skills/USTC-Claw-Research-Skills/config.yaml << 'CONF'
   # 用户研究偏好（自动生成）
   research_interests:
     - "{keyword_1}"
     - "{keyword_2}"
     - "{keyword_3}"
   # 语言偏好：zh / en / auto
   language: auto
   # survey 默认论文数量
   survey_paper_count: 20
   # deep note 模板语言
   note_language: zh
   CONF
   ```

3. **确认安装成功：**
   回复用户：已安装，展示 config 内容，告知可用命令。

## Skills

| # | Skill | 触发词 | 功能 |
|---|-------|--------|------|
| 1 | **Paper Survey** 📡 | `survey [方向]` / `帮我调研 [方向]` | 给定研究方向，自动搜索 arXiv 论文，生成结构化 survey 报告 |
| 2 | **Deep Note** 📝 | `deep note [arXiv link]` / `帮我读 [link]` | 给定论文，生成 7-section 深度阅读笔记 |
| 3 | **Preference Evolving** 🧬 | 自动触发 / `更新偏好` | 从交互中学习研究偏好，持续更新 config.yaml 权重 |

## Preference Evolving 机制

Agent 会在每次 survey / deep note 交互后自动检测偏好信号：
- 👍 正面反馈（"这篇不错"）→ 提升关键词权重
- 👎 负面反馈（"不太相关"）→ 降低关键词权重
- 🆕 新方向请求 → 自动添加新关键词
- 📉 反复忽略某类论文 → 标记为低优先级

所有变更记录在 `config.yaml` 的 `preference_history` 中，完全透明可追溯。

## Config 说明

安装后会在 skill 目录下生成 `config.yaml`，包含：
- `research_interests`: 用户研究方向关键词列表（用于 survey 排序和推荐）
- `language`: 输出语言偏好
- `survey_paper_count`: survey 默认搜索论文数
- `note_language`: deep note 笔记语言

用户可随时修改配置：`更新我的研究偏好：[新方向]`
