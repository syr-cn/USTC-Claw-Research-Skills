---
name: preference-evolving
description: >
  持续从交互信号中学习用户的研究偏好。
  在每次 survey/deep-note 会话结束后自动更新 config.yaml 中的权重。
  触发条件：每次 paper-survey 或 deep-note 交互完成后自动执行。
---

# Preference Evolving — 自适应研究偏好学习

## 目标
在 paper-survey / deep-note 交互过程中及结束后，观察用户反馈，
检测隐含的偏好信号，自动更新 config.yaml，使推荐始终贴合用户不断演变的研究兴趣。

## 触发时机
在完成任意 paper-survey 或 deep-note 任务后，作为**后置步骤**执行。
也可在用户主动要求更新偏好时触发。

## 信号检测

在用户回复中捕捉以下线索：

| 信号类型 | 示例 | 执行动作 |
|----------|------|----------|
| 正面反馈 | "很有意思"、"标记这篇" | 提升关键词权重 +0.1 |
| 负面反馈 | "不太相关"、"跳过" | 降低关键词权重 -0.1 |
| 新主题请求 | "survey [新方向]" | 添加关键词，初始权重 0.5 |
| 反复忽略 | 用户连续 3 次跳过同一类别 | 标记为低优先级（权重 0.2） |
| 主动更新 | "更新我的研究方向" | 按用户输入重写兴趣列表 |

## 配置文件格式（config.yaml）

```yaml
# 研究兴趣列表
research_interests:
  - keyword: "agentic memory"        # 关键词
    weight: 0.9                       # 权重（0.1-1.0）
    added: "2026-04-07"               # 添加日期
    source: "初始配置"                 # 来源说明
  - keyword: "RL for LLM reasoning"
    weight: 0.7
    added: "2026-04-07"
    source: "用户曾调研该方向"
# 语言偏好
language: auto
# survey 默认论文数量
survey_paper_count: 20
# deep note 笔记语言
note_language: zh
# 偏好变更历史
preference_history:
  - date: "2026-04-07"
    action: "添加关键词: agentic memory（权重 0.9）"
    reason: "来自用户初始配置"
```

## 更新流程

### 第 1 步 — 检测信号
在 survey/deep-note 交互结束后，回顾对话内容，识别上述信号。

### 第 2 步 — 读取当前配置
从 skill 安装目录读取 `config.yaml`。
如果文件不存在，根据用户初始消息创建默认配置。

### 第 3 步 — 应用变更
- 权重调整：限制在 [0.1, 1.0] 范围内，保留 1 位小数
- 新增关键词：初始权重 0.5，来源填写上下文描述
- 删除关键词：仅当权重降至 0.1 以下时移除

### 第 4 步 — 记录历史
在 `preference_history` 中追加条目，包含日期、动作和原因。
仅保留最近 20 条历史记录，避免文件膨胀。

### 第 5 步 — 写入配置
将更新后的 config.yaml 写回。简要通知用户：
"已更新你的偏好：提升了 [X]，新增了 [Y]"

## 与其他 Skill 的集成

- **paper-survey 第 6 步**：生成报告后，检查用户反馈并调用本 skill
- **deep-note 第 5 步**：生成笔记后，检查用户反馈并调用本 skill
- 两个 skill 在开始时都应读取 config.yaml，按关键词权重对结果进行排序/筛选
