# USTC Claw Research Skills 🔬

即插即用的研究生论文助手，为 [OpenClaw](https://github.com/openclaw/openclaw) 打造。

## Features

| Skill | Command | Description |
|-------|---------|-------------|
| **Paper Survey** 📡 | `survey [topic]` | 给定研究方向，自动搜索 arXiv 论文，生成结构化 survey 报告 |
| **Deep Note** 📝 | `deep note [link]` | 给定一篇论文，生成 7-section 深度阅读笔记 |

## Quick Start

### Install

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/syr-cn/USTC-Claw-Research-Skills.git
```

### Use

```
# Survey a research area
survey agentic memory systems

# Read a specific paper
deep note https://arxiv.org/abs/2401.12345
```

### Optional: Personalize

Tell your agent your research direction for better recommendations:

```
我的研究方向是：强化学习 + LLM推理 + Agent记忆系统
```

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) with web search (Tavily or Brave)
- No additional API keys needed

## License

MIT

## Author

[AlphaLab @ USTC](https://github.com/AlphaLab-USTC)
