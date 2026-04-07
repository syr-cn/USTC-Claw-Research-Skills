# Install USTC Claw Research Skills

## 一句话安装 + 配置

把这句话发给你的 OpenClaw agent：

```
安装这个 repo：https://github.com/syr-cn/USTC-Claw-Research-Skills ，并且配置我的偏好：memory agent 的 RL 训练
```

Agent 会自动完成：
1. `git clone` 到 skills 目录
2. 根据你的偏好生成 `config.yaml`
3. 后续 survey / deep note 自动按你的方向排序和推荐

## 手动安装（如果你想自己来）

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/syr-cn/USTC-Claw-Research-Skills.git
```

然后告诉 agent：`我的研究方向是：[你的方向]`

## Usage

- **Survey:** `survey [方向]` or `帮我调研 [方向]`
- **Deep Note:** `deep note [arXiv link]` or `帮我读 [链接]`

## Requirements

- OpenClaw with web search (Tavily or Brave)
- No additional API keys needed
