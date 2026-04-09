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

# 3. 安装（整个目录结构）
echo "📦 正在安装 skills..."

# 如果已存在旧版本，先备份
if [ -d "${INSTALL_DIR}" ]; then
    echo "⚠️  检测到已有安装，备份到 ${INSTALL_DIR}.bak"
    rm -rf "${INSTALL_DIR}.bak"
    mv "${INSTALL_DIR}" "${INSTALL_DIR}.bak"
fi

mkdir -p "${INSTALL_DIR}/skills/paper-survey"
mkdir -p "${INSTALL_DIR}/skills/deep-note"
mkdir -p "${INSTALL_DIR}/skills/preference-evolving"
mkdir -p "${INSTALL_DIR}/docs"

# 复制核心文件（不复制 .git）
cp "${TMP_DIR}/repo/SKILL.md"                              "${INSTALL_DIR}/SKILL.md"
cp "${TMP_DIR}/repo/README.md"                             "${INSTALL_DIR}/README.md"
cp "${TMP_DIR}/repo/docs/install.md"                       "${INSTALL_DIR}/docs/install.md"
cp "${TMP_DIR}/repo/skills/paper-survey/SKILL.md"          "${INSTALL_DIR}/skills/paper-survey/SKILL.md"
cp "${TMP_DIR}/repo/skills/deep-note/SKILL.md"             "${INSTALL_DIR}/skills/deep-note/SKILL.md"
cp "${TMP_DIR}/repo/skills/preference-evolving/SKILL.md"   "${INSTALL_DIR}/skills/preference-evolving/SKILL.md"

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
echo "      └── preference-evolving/SKILL.md  (偏好自进化)"
echo ""
echo "📌 首次使用时会自动引导你配置研究偏好"
echo "📌 试试: survey [你的研究方向] 或 帮我读 [arXiv链接]"
