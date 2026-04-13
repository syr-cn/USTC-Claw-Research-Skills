#!/usr/bin/env bash
# USTC-Claw-Research-Skills 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/syr-cn/USTC-Claw-Research-Skills/main/install.sh | bash
# 或者: bash install.sh

set -e

SKILL_DIR="${HOME}/.openclaw/workspace/skills"
REPO_URL="https://github.com/syr-cn/USTC-Claw-Research-Skills.git"
TMP_DIR=$(mktemp -d)
INSTALL_DIR="${SKILL_DIR}/USTC-Claw-Research-Skills"

echo "🔬 USTC Claw Research Skills 安装脚本"
echo "========================================="

# 1. 确保目标目录存在
mkdir -p "${SKILL_DIR}"

# 2. 下载
echo "📥 正在从 GitHub 下载..."
git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo" 2>/dev/null

# 3. 安装（原子替换：先装到 temp，再 mv 到目标位置）
echo "📦 正在安装 skills..."

STAGE_DIR=$(mktemp -d)
mkdir -p "${STAGE_DIR}/skills/paper-survey"
mkdir -p "${STAGE_DIR}/skills/deep-note"
mkdir -p "${STAGE_DIR}/skills/daily-papers/references"
mkdir -p "${STAGE_DIR}/skills/preference-evolving"
mkdir -p "${STAGE_DIR}/docs"

cp "${TMP_DIR}/repo/SKILL.md"                              "${STAGE_DIR}/SKILL.md"
cp "${TMP_DIR}/repo/README.md"                             "${STAGE_DIR}/README.md"
cp "${TMP_DIR}/repo/docs/install.md"                       "${STAGE_DIR}/docs/install.md"
cp "${TMP_DIR}/repo/skills/paper-survey/SKILL.md"          "${STAGE_DIR}/skills/paper-survey/SKILL.md"
cp "${TMP_DIR}/repo/skills/deep-note/SKILL.md"             "${STAGE_DIR}/skills/deep-note/SKILL.md"
cp "${TMP_DIR}/repo/skills/daily-papers/SKILL.md"          "${STAGE_DIR}/skills/daily-papers/SKILL.md"
cp "${TMP_DIR}/repo/skills/daily-papers/references/output-example.md" "${STAGE_DIR}/skills/daily-papers/references/output-example.md"
cp "${TMP_DIR}/repo/skills/preference-evolving/SKILL.md"   "${STAGE_DIR}/skills/preference-evolving/SKILL.md"

# 原子替换：删旧目录，把 staging 目录移过去
rm -rf "${INSTALL_DIR}"
mv "${STAGE_DIR}" "${INSTALL_DIR}"

# 4. 清理临时文件
echo "🧹 清理临时文件..."
rm -rf "${TMP_DIR}"

# 5. 完成
echo ""
echo "✅ 安装完成！文件结构:"
echo ""
echo "  ${INSTALL_DIR}/"
echo "  ├── SKILL.md                          (入口 + onboarding 引导)"
echo "  ├── README.md"
echo "  ├── docs/install.md"
echo "  └── skills/"
echo "      ├── paper-survey/SKILL.md         (自动文献综述)"
echo "      ├── deep-note/SKILL.md            (深度阅读笔记)"
echo "      ├── daily-papers/SKILL.md         (每日论文推送)"
echo "      └── preference-evolving/SKILL.md  (偏好自进化)"
echo ""

# 6. 定时任务配置
CRON_JOBS_FILE="${HOME}/.openclaw/cron/jobs.json"

# 辅助函数：解析 HH:MM 为 cron 表达式，返回 "MIN HOUR * * *"
parse_time_to_cron() {
    local input="$1" default="$2"
    local t="${input:-$default}"
    if [[ ! "${t}" =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
        echo "⚠️  时间格式不正确，使用默认值 ${default}" >&2
        t="${default}"
    fi
    local h="${t%%:*}" m="${t##*:}"
    h="$((10#${h}))"; m="$((10#${m}))"
    echo "${m} ${h} * * *"
}

# 辅助函数：创建一个 cron job
#   $1 = job 名称, $2 = cron 表达式, $3 = system-event 文本, $4 = 显示用时间
add_cron_job() {
    local name="$1" expr="$2" event="$3" display_time="$4"
    if command -v openclaw &>/dev/null; then
        openclaw cron add \
            --name "${name}" \
            --cron "${expr}" \
            --tz "Asia/Shanghai" \
            --system-event "${event}" \
            --session main \
            --exact \
            --json 2>/dev/null && {
            echo "  ✅ 「${name}」已创建 — 每天 ${display_time}"
        } || {
            echo "  ⚠️  「${name}」创建失败（gateway 未运行？），手动添加："
            echo "     openclaw cron add --name '${name}' --cron '${expr}' --tz Asia/Shanghai --system-event '${event}' --session main --exact"
        }
    else
        echo "  ⚠️  未找到 openclaw 命令，手动添加："
        echo "     openclaw cron add --name '${name}' --cron '${expr}' --tz Asia/Shanghai --system-event '${event}' --session main --exact"
    fi
}

# 检查已有 cron job
cron_exists() {
    [ -f "${CRON_JOBS_FILE}" ] && grep -q "\"$1\"" "${CRON_JOBS_FILE}" 2>/dev/null
}

PAPER_EXISTS=false; DAILY_EXISTS=false
cron_exists "每日论文推送"   && PAPER_EXISTS=true
cron_exists "每日USTC日报推送" && DAILY_EXISTS=true

if [ "${PAPER_EXISTS}" = true ] && [ "${DAILY_EXISTS}" = true ]; then
    echo "📡 检测到已有「每日论文推送」和「每日USTC日报推送」定时任务，跳过 cron 配置。"
else
    echo "========================================="
    echo "📡 配置定时推送任务"
    echo "========================================="
    echo ""
    echo "可以为你配置以下定时任务（均为 Asia/Shanghai 时区）："
    [ "${PAPER_EXISTS}" = false ] && echo "  1) 每日论文推送 — 自动搜索 arXiv + HuggingFace 热门论文，按研究偏好筛选推送"
    [ "${DAILY_EXISTS}" = false ] && echo "  2) 每日USTC日报推送 — 自动推送 USTC 每日日报"
    echo ""

    if [ -t 0 ]; then
        read -r -p "是否配置定时推送任务？[Y/n] " SETUP_CRON
        SETUP_CRON="${SETUP_CRON:-Y}"
    else
        echo "⚠️  非交互模式，跳过 cron 配置。安装后可手动运行 openclaw cron add。"
        SETUP_CRON="n"
    fi

    if [[ "${SETUP_CRON}" =~ ^[Yy]$|^$ ]]; then
        echo ""

        # --- 每日论文推送 ---
        if [ "${PAPER_EXISTS}" = false ]; then
            echo "📄 每日论文推送时间（24小时制 HH:MM，默认 10:00）："
            read -r -p "> " PAPER_TIME
            PAPER_CRON=$(parse_time_to_cron "${PAPER_TIME}" "10:00")
            PAPER_DISPLAY="${PAPER_TIME:-10:00}"
        fi

        # --- 每日USTC日报推送 ---
        if [ "${DAILY_EXISTS}" = false ]; then
            echo "📰 每日USTC日报推送时间（24小时制 HH:MM，默认 12:00）："
            read -r -p "> " DAILY_TIME
            DAILY_CRON=$(parse_time_to_cron "${DAILY_TIME}" "12:00")
            DAILY_DISPLAY="${DAILY_TIME:-12:00}"
        fi

        echo ""
        echo "⏰ 即将创建："
        [ "${PAPER_EXISTS}" = false ] && echo "   • 每日论文推送      ${PAPER_DISPLAY} (cron: ${PAPER_CRON})"
        [ "${DAILY_EXISTS}" = false ] && echo "   • 每日USTC日报推送  ${DAILY_DISPLAY} (cron: ${DAILY_CRON})"
        echo ""

        if [ "${PAPER_EXISTS}" = false ]; then
            add_cron_job \
                "每日论文推送" \
                "${PAPER_CRON}" \
                "每日论文推送：搜索今天的 arXiv 和 HuggingFace trending 论文，按研究方向筛选，输出简报。" \
                "${PAPER_DISPLAY}"
        fi

        if [ "${DAILY_EXISTS}" = false ]; then
            add_cron_job \
                "每日USTC日报推送" \
                "${DAILY_CRON}" \
                "每日USTC日报推送：生成并推送今日 USTC 日报。" \
                "${DAILY_DISPLAY}"
        fi
    else
        echo "⏭️  跳过 cron 配置。你可以之后手动设置："
        [ "${PAPER_EXISTS}" = false ] && echo "    openclaw cron add --name '每日论文推送' --cron '0 10 * * *' --tz Asia/Shanghai --system-event '每日论文推送：搜索今天的 arXiv 和 HuggingFace trending 论文，按研究方向筛选，输出简报。' --session main --exact"
        [ "${DAILY_EXISTS}" = false ] && echo "    openclaw cron add --name '每日USTC日报推送' --cron '0 12 * * *' --tz Asia/Shanghai --system-event '每日USTC日报推送：生成并推送今日 USTC 日报。' --session main --exact"
    fi
fi

echo ""
echo "📌 首次使用时会自动引导你配置研究偏好"
echo "📌 试试: survey [你的研究方向] 或 帮我读 [arXiv链接]"
