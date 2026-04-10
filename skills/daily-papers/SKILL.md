---
name: daily-papers
description: >
  每日论文推送。根据用户 config.yaml 中的研究偏好，自动搜索 arXiv 和 HuggingFace 当日热门论文，
  生成结构化推送报告。
  触发词：每日论文、daily papers、今日推送、论文推荐、paper digest。也可由 cron 自动触发。
---

# Daily Papers — 每日论文推送

## 目标
根据用户研究偏好（config.yaml），每日自动从 arXiv 和 HuggingFace 搜集最新论文，
筛选出 10-15 篇高相关度论文，生成结构化推送报告。

## 触发词
`每日论文` · `daily papers` · `今日推送` · `论文推荐` · `paper digest` · cron 自动触发

---

## 第 1 步 — 读取偏好配置

从 skill 安装目录读取 `config.yaml`（路径：`skills/preference-evolving/config.yaml`）。

提取以下信息：
- `research_interests`：关键词列表及权重
- `language`：输出语言偏好
- `note_language`：报告语言

**如果 config.yaml 不存在**，执行首次使用引导流程（见主 SKILL.md）。

## 第 2 步 — 搜索 arXiv 论文

使用 `tavily_search` 搜索最近 24 小时的 arXiv 论文。

按 config.yaml 中的研究兴趣关键词构造查询：

```
对每个关键词（按权重从高到低）：
  Query: "arxiv {keyword} 2026" OR "{keyword} site:arxiv.org"
  搜索类别: cs.CL, cs.AI, cs.LG
  时间范围: time_range="day"
```

对每篇结果提取：标题、作者、机构、arXiv ID、日期、摘要。
去重（按 arXiv ID）。

## 第 3 步 — 搜索 HuggingFace 热门

使用 `tavily_search` 搜索 HuggingFace 当日热门：

```
Query 1: "huggingface trending models today"
Query 2: "huggingface daily papers"
```

也可尝试：`web_fetch("https://huggingface.co/papers")` 提取当日论文列表。

## 第 4 步 — 筛选与排序

将所有搜集到的论文合并后：

1. **关键词匹配**：计算每篇论文与 config.yaml 中各关键词的匹配度
2. **权重排序**：按关键词权重加权排序
3. **去重合并**：同时出现在 arXiv 和 HuggingFace 的论文标记为双来源热门
4. **Top 3 选取**：选出综合得分最高的 3 篇作为重点推荐
5. **总量控制**：保留 10-15 篇进入最终报告

## 第 5 步 — 生成报告

按以下格式生成 markdown 报告（参考 `references/output-example.md`）：

```markdown
# 📡 每日论文推送 — {日期}
> 研究方向: {从config读取的关键词} | 来源: arXiv + HuggingFace | 论文数: {N}

## 🔥 今日重点推荐（Top 3）

### 1. {论文标题}
**作者:** {作者列表} ({机构})
**arXiv:** [{arXiv ID}](https://arxiv.org/abs/{id}) | {类别} | {日期}

**核心贡献:** {3-4 行描述论文的核心方法和主要结果}
- {关键发现/数据点 1}
- {关键发现/数据点 2}
- 与 config.yaml 偏好匹配度: ⭐⭐⭐

---
（Top 2、Top 3 同上格式）

## 📋 今日论文列表

### {子方向名称}（{N}篇）

| # | 标题 | 机构 | 一句话摘要 |
|---|------|------|-----------|
| {i} | [{标题}](https://arxiv.org/abs/{id}) | {机构} | {一句话摘要} |

（按子方向分组，每组一个表格）

## 📊 今日统计

| 子方向 | 篇数 | 匹配度 |
|--------|------|--------|
| {方向} | {N} | ⭐⭐⭐ |
| **合计** | **{total}** | — |

## 💡 趋势观察
{1-2 句话总结今日论文的整体趋势和值得关注的方向}
```

### 格式要点
- arXiv 链接统一使用 `/abs/` 格式
- 匹配度用 ⭐ 星级表示（1-3 星）
- Top 3 需要详细描述核心贡献和关键数据
- 其余论文只需一句话摘要
- 按研究子方向分组展示

## 第 6 步 — 更新偏好

报告生成并交付后，观察用户反馈并触发 `preference-evolving` skill：

- 用户标记某篇论文为"有趣"/"值得精读" → 提升相关关键词权重
- 用户说"不太相关"/"跳过" → 降低相关关键词权重
- 用户请求某个新方向的论文 → 添加为新关键词

按照 `skills/preference-evolving/SKILL.md` 中的流程执行更新。

---

## 提示

- 优先推荐同时出现在 arXiv 和 HuggingFace 的论文（社区热度高）
- 每次推送控制在 10-15 篇，避免信息过载
- 如果某日某方向论文较少，可适当扩大时间范围至 48 小时
- 报告语言跟随 config.yaml 中的 `note_language` 设置
- 子方向分组应根据当日论文动态调整，不要硬编码固定分类
- 如果搜索结果不足（<5 篇），在报告中注明并建议扩大搜索范围
