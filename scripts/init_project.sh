#!/bin/bash
# promo-video-builder — 项目初始化脚本
# 用法: bash init_project.sh <项目目录路径>
# 功能: 检查环境 → 查找 video-shotcraft skill → 复制模板 + SFX → npm install

set -e

PROJECT_DIR="${1:-./remotion}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

echo "=========================================="
echo "  Promo Video Builder — 项目初始化"
echo "=========================================="
echo ""

# === 1. 环境检查 ===
echo "[1/5] 检查运行环境..."

check_cmd() {
    if command -v "$1" &>/dev/null; then
        echo "  ✅ $1: $(command -v "$1")"
        return 0
    else
        echo "  ❌ $1: 未找到"
        return 1
    fi
}

ENV_OK=true
check_cmd node || ENV_OK=false
check_cmd npx || ENV_OK=false
check_cmd ffmpeg || ENV_OK=false
check_cmd ffprobe || ENV_OK=false

if [ "$ENV_OK" = false ]; then
    echo ""
    echo "❌ 环境检查失败。请安装缺失的工具："
    echo "   Node.js:  https://nodejs.org/ (>= 18)"
    echo "   FFmpeg:   https://ffmpeg.org/download.html"
    echo ""
    exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "  ⚠️  Node.js 版本过低 (当前: $(node -v))，建议 >= 18"
fi

echo ""

# === 2. 查找 video-shotcraft skill ===
echo "[2/5] 查找 video-shotcraft skill..."

VSC_PATHS=(
    "$HOME/.workbuddy/skills/video-shotcraft"
    ".workbuddy/skills/video-shotcraft"
)

# 也检查传入路径的父目录下
PARENT_DIR="$(dirname "$PROJECT_DIR")"
VSC_PATHS+=("$PARENT_DIR/video-shotcraft")

VSC_FOUND=""
for path in "${VSC_PATHS[@]}"; do
    if [ -d "$path/template/src" ] && [ -d "$path/assets/audio" ]; then
        VSC_FOUND="$path"
        echo "  ✅ 找到: $path"
        break
    fi
done

if [ -z "$VSC_FOUND" ]; then
    echo "  ⚠️  未找到 video-shotcraft skill"
    echo ""
    echo "  video-shotcraft 提供模板源码和 SFX 音效库，是本 skill 的依赖。"
    echo "  请先安装 video-shotcraft skill，或手动指定路径："
    echo "    bash init_project.sh <项目目录> <video-shotcraft路径>"
    echo ""

    # 检查第二个参数
    VSC_MANUAL="${2:-}"
    if [ -n "$VSC_MANUAL" ] && [ -d "$VSC_MANUAL/template/src" ]; then
        VSC_FOUND="$VSC_MANUAL"
        echo "  ✅ 使用手动指定路径: $VSC_FOUND"
    else
        echo "  ❌ 无法继续，请安装 video-shotcraft skill 后重试"
        exit 1
    fi
fi

echo ""

# === 3. 创建项目目录 ===
echo "[3/5] 创建项目目录: $PROJECT_DIR"

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# 复制模板源码
echo "  复制模板源码..."
cp -r "$VSC_FOUND/template/src" ./src
cp "$VSC_FOUND/template/package.json" ./package.json
cp "$VSC_FOUND/template/tsconfig.json" ./tsconfig.json 2>/dev/null || true
cp "$VSC_FOUND/template/remotion.config.ts" ./remotion.config.ts 2>/dev/null || true

# 创建 public 目录
mkdir -p public/audio/sfx public/audio/bgm public/textures

# 复制 SFX 音效库
echo "  复制 SFX 音效库..."
if [ -d "$VSC_FOUND/assets/audio" ]; then
    cp -r "$VSC_FOUND/assets/audio/"* public/audio/ 2>/dev/null || true
    SFX_COUNT=$(find public/audio/sfx -name "*.mp3" 2>/dev/null | wc -l | tr -d ' ')
    echo "  ✅ 复制 $SFX_COUNT 个 SFX 文件"
elif [ -d "$VSC_FOUND/template/public/audio" ]; then
    cp -r "$VSC_FOUND/template/public/audio/"* public/audio/ 2>/dev/null || true
    SFX_COUNT=$(find public/audio/sfx -name "*.mp3" 2>/dev/null | wc -l | tr -d ' ')
    echo "  ✅ 复制 $SFX_COUNT 个 SFX 文件 (精简版)"
fi

# 复制示例纹理
if [ -d "$VSC_FOUND/template/public/textures" ]; then
    cp -r "$VSC_FOUND/template/public/textures/"* public/textures/ 2>/dev/null || true
    echo "  ✅ 复制示例纹理"
fi

echo ""

# === 4. npm install ===
echo "[4/5] 安装 npm 依赖..."
npm install --silent 2>&1 | tail -3
echo "  ✅ 依赖安装完成"

echo ""

# === 5. 创建辅助文件 ===
echo "[5/5] 创建辅助文件..."

# props-nobgm.json
cat > props-nobgm.json << 'PROPS'
{ "bgm": false }
PROPS

# 创建 out 目录
mkdir -p out/qa

# 创建 .gitignore
cat > .gitignore << 'GIT'
node_modules/
out/
public/textures/*.png
GIT

echo "  ✅ 创建 props-nobgm.json"
echo "  ✅ 创建 out/qa/ 目录"

echo ""
echo "=========================================="
echo "  ✅ 项目初始化完成！"
echo "=========================================="
echo ""
echo "项目路径: $(pwd)"
echo ""
echo "下一步："
echo "  1. 将目标产品的截图放入 public/textures/"
echo "  2. 在 WorkBuddy 中说「制作企业宣传片」"
echo "  3. WorkBuddy 将加载 promo-video-builder skill 并执行八阶段流水线"
echo ""
