# USTC Claw Research Skills 🔬

即插即用的研究生论文助手，为 [OpenClaw](https://github.com/openclaw/openclaw) 打造。

## Features

| Skill | Command | Description |
|-------|---------|-------------|
| **Paper Survey** 📡 | `survey [topic]` | 给定研究方向，自动搜索 arXiv 论文，生成结构化 survey 报告 |
| **Deep Note** 📝 | `deep note [link]` | 给定一篇论文，生成 7-section 深度阅读笔记 |
| **Preference Evolving** 🧬 | 自动 | 从交互中持续学习你的研究偏好，越用越准 |

## 一句话安装 + 配置

把这句话发给你的 OpenClaw agent：

```
安装这个 repo：https://github.com/syr-cn/USTC-Claw-Research-Skills ，并且配置我的偏好：memory agent 的 RL 训练
```

Agent 会自动：clone 仓库 → 解析你的方向 → 生成 `config.yaml` → 开箱即用 ✨

随着使用，agent 会从你的反馈中持续学习偏好（"这篇不错" / "不太相关"），自动调整推荐权重。

## Usage

```
# 调研一个方向
survey agentic memory systems

# 精读一篇论文
deep note https://arxiv.org/abs/2401.12345
```

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) with web search (Tavily or Brave)
- No additional API keys needed

## License

MIT

## Author

[AlphaLab @ USTC](https://github.com/AlphaLab-USTC)
