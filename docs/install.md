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

## 首次使用自动引导

如果安装时没有指定研究方向，或者 `config.yaml` 被删除了也不用担心——首次使用任意 skill 时，系统会自动检测到配置缺失，并引导你完成偏好配置：

1. 系统提示你输入感兴趣的研究方向
2. 你输入关键词（支持多个，逗号分隔）
3. 自动生成 `config.yaml` 并确认

整个过程无需手动编辑文件，对话中即可完成。

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
