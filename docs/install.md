# Install USTC Claw Research Skills

## One-Line Install

Run this in your terminal:

```bash
cd ~/.openclaw/workspace/skills && git clone https://github.com/syr-cn/USTC-Claw-Research-Skills.git
```

Or tell your OpenClaw agent:

```
帮我安装 USTC Claw Research Skills：
git clone https://github.com/syr-cn/USTC-Claw-Research-Skills.git 到 ~/.openclaw/workspace/skills/
```

## What Gets Installed

```
~/.openclaw/workspace/skills/USTC-Claw-Research-Skills/
├── SKILL.md              # Root skill (auto-detected by OpenClaw)
├── skills/
│   ├── paper-survey/     # 论文综述 skill
│   │   └── SKILL.md
│   └── deep-note/        # 深度阅读笔记 skill
│       └── SKILL.md
├── docs/
│   └── install.md        # This file
└── README.md
```

## Optional: Set Your Research Direction

After install, tell your agent your research interests for personalized results:

```
我的研究方向是：[你的方向，例如：强化学习 + LLM推理 + Agent记忆系统]
```

## Usage

- **Survey a topic:** `survey [研究方向]` or `帮我调研 [方向]`
- **Read a paper:** `deep note [arXiv link]` or `帮我读 [论文链接]`

## Requirements

- OpenClaw with web search enabled (Tavily or Brave)
- `web_fetch` tool for accessing arXiv
- No additional API keys needed
