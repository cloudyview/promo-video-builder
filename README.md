# Promo Video Builder

<p align="center">
  <strong>🎬 企业/产品宣传片端到端自动化制作能力</strong><br>
  <em>End-to-end Promotional Video Production Skill for WorkBuddy</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-WorkBuddy-blue" alt="platform">
  <img src="https://img.shields.io/badge/node-%3E%3D18-brightgreen" alt="node">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="license">
  <img src="https://img.shields.io/badge/Remotion-4.x-8B5CF6" alt="Remotion">
</p>

---

[English](#english) | [中文](#chinese)

---

<a id="english"></a>
## English

### Overview

Promo Video Builder is a [WorkBuddy](https://www.workbuddy.cn) skill that enables AI-powered end-to-end promotional video production. From product understanding, visual direction, storyboard design, shot-by-shot rendering, sound design to final quality assurance — it autonomously produces professional-grade promo videos with dual audio versions (with/without BGM).

Built on [Remotion](https://remotion.dev) (React video framework), it renders natively at **1920x1080 @ 30fps**, delivering 30-40 second cinematic promotional videos.

### Features

- 🎯 **Fully Autonomous Pipeline**: 8-stage workflow from product brief to final rendering — no manual intervention needed
- 🎨 **Component-Based Architecture**: 7 shot card types (brand intro, spotlight hero, AI stream response, card fly-in, spotlight sweep, integration hub, group photo outro)
- 🔊 **Rich Sound Design**: 150+ SFX files across 14 categories with precise frame-level sync
- 🎵 **Dual Audio Output**: Renders both BGM and no-BGM versions from a single codebase
- 🔒 **Privacy-First**: Built-in triple-layered privacy masking for screenshots containing real user data
- ✅ **Independent QA**: Clean-context subagent quality assurance using 18 aesthetic rules + 8 delivery checklists
- 🔄 **Deterministic Rendering**: Seed-based randomization ensures identical output on every render

### Project Structure

```
promo-video-builder/
├── SKILL.md                          # Skill definition & execution workflow
├── scripts/
│   └── init_project.sh               # Project initialization (env check + template setup)
└── references/
    ├── pipeline-guide.md             # 8-stage pipeline execution guide
    ├── shot-card-catalog.md          # Shot card types catalog + selection decision tree
    ├── sfx-mapping.md                # SFX category to scene mapping table
    ├── anti-pit-rules.md             # Anti-failure rules (P0/P1) from real project postmortems
    └── delivery-checklist.md         # Final delivery acceptance checklist
```

### Prerequisites

- [WorkBuddy](https://www.workbuddy.cn) (latest version)
- [video-shotcraft skill](https://github.com/workbuddy/video-shotcraft) — provides Remotion templates, component library (PageCam, FlashCut, PaperTitleCard, etc.), and SFX library
- Node.js >= 18
- FFmpeg

### Quick Start

1. Install the skill in WorkBuddy's skill marketplace
2. Install [video-shotcraft](https://github.com/workbuddy/video-shotcraft) as a dependency
3. In WorkBuddy, say: **"Make a promo video"** or provide product information
4. WorkBuddy will automatically run the 8-stage pipeline:
   - **Stage 0**: Product Understanding — product brief + data constraints
   - **Stage 1**: Visual Direction — color palette + typography + styleframe
   - **Stage 2**: Feature Mapping — shot list based on card catalog
   - **Stage 3**: Storyboard — precise frame numbers + theme.ts
   - **Stage 4**: Asset Collection — screenshots + SFX selection
   - **Stage 5**: Shot Implementation — component coding + per-shot QA
   - **Stage 6**: Sound Design — SFX frame table + dual props
   - **Stage 7**: Independent QA — subagent inspection → fixes → dual render

### Shot Card Types

| Card | Purpose | Duration | Energy Position |
|------|---------|----------|-----------------|
| `brand-ink-open` | Brand opening | 100f (3.3s) | ① Brand intro |
| `spotlight-hero-card` | Hero feature showcase | 130f (4.3s) | ② Hero feature |
| `ai-stream-response` | AI streaming reply | 130f (4.3s) | ③ Feature climb |
| `deck-deal-flyin` | Multi-card fly-in | 130f (4.3s) | ③ Feature climb |
| `spotlight-sweep-moves` | Spotlight panel sweep | 130f (4.3s) | ③ Feature climb |
| `integration-hub-map` | Integration ecosystem | 150f (5.0s) | ③ Feature climb |
| `paper-title-card` | Rhythm breathing cards | 50f (1.7s) | Breathing interlude |
| `outro-group-photo-launch` | Grand finale | 150f (5.0s) | ④ Outro |

### Anti-Failure Rules (P0)

These rules come from real production failures and **must** be followed:

1. **P0-1**: Component import names must match export names
2. **P0-2**: SFX filenames must use real paths (never placeholder names)
3. **P0-3**: Long SFX samples (>5s) must include `durationInFrames`
4. **P0-4**: Screenshots with real user data require triple-layered masking
5. **P0-5**: Independent QA must use a clean-context subagent

### Capabilities & Limits

**Can do:**
- 30-40 second professional product/corporate promo videos
- 1920x1080 landscape
- Dark neon, bright clean, corporate dark, warm education styles
- Dual version delivery (with/without BGM)
- Deterministic rendering

**Cannot do:**
- Live footage compositing (requires real camera footage)
- 3D character animation (Remotion is 2D/CSS 2.5D)
- Videos longer than 60 seconds
- Real-time interactive video

### License

MIT © 2026

---

<a id="chinese"></a>
## 中文

### 概述

Promo Video Builder 是一个 [WorkBuddy](https://www.workbuddy.cn) skill，提供 AI 驱动的企业/产品宣传片端到端自动化制作能力。从产品理解、视觉方向、分镜设计、逐镜头渲染、声音设计到独立终检——全流程自主完成，输出双版本 MP4（带 BGM / 无 BGM）。

基于 [Remotion](https://remotion.dev)（React 视频框架）从零渲染，原生 **1920×1080 @ 30fps**，产出 30-40 秒电影级宣传片。

### 核心特性

- 🎯 **全自主流水线**：从产品简报到最后渲染，8 阶段全流程无需人工干预
- 🎨 **组件化架构**：7 种镜头卡片类型（品牌开场、聚光推入、AI 流式回复、卡片发牌、聚光灯扫过、集成中枢、收场合影）
- 🔊 **丰富音效设计**：150+ 音效文件，覆盖 14 个类别，精准到帧级同步
- 🎵 **双版本输出**：同一套代码渲染带 BGM 和无 BGM 两个版本
- 🔒 **隐私优先**：内置三重暗化方案处理包含真实用户数据的截图
- ✅ **独立质检**：干净上下文 subagent 独立终检，18 条审美准则 + 8 项交付清单
- 🔄 **确定性渲染**：基于固定种子的随机数，保证每次渲染结果一致

### 项目结构

```
promo-video-builder/
├── SKILL.md                          # Skill 定义与执行流程
├── scripts/
│   └── init_project.sh               # 项目初始化脚本（环境检查 + 模板搭建）
└── references/
    ├── pipeline-guide.md             # 八阶段流水线执行指南
    ├── shot-card-catalog.md          # 镜头卡片类型目录 + 选择决策树
    ├── sfx-mapping.md                # SFX 类别到场景的映射表
    ├── anti-pit-rules.md             # 防坑规则（P0/P1），来自真实项目翻车复盘
    └── delivery-checklist.md         # 最终交付验收清单
```

### 环境要求

- [WorkBuddy](https://www.workbuddy.cn)（最新版本）
- [video-shotcraft skill](https://github.com/workbuddy/video-shotcraft) —— 提供 Remotion 项目模板、组件库（PageCam/FlashCut/PaperTitleCard 等）和 SFX 音效库
- Node.js >= 18
- FFmpeg

### 快速开始

1. 在 WorkBuddy 技能市场安装本 skill
2. 安装依赖 skill —— [video-shotcraft](https://github.com/workbuddy/video-shotcraft)
3. 在 WorkBuddy 中说：**「制作宣传片」**或提供产品信息
4. WorkBuddy 将自动执行八阶段流水线：
   - **阶段 0**：产品理解 → 产品简报 + 数据约束
   - **阶段 1**：视觉方向 → 色板 + 字体 + styleframe
   - **阶段 2**：功能映射 → 基于卡片目录设计镜头列表
   - **阶段 3**：分镜设计 → 精确帧号 + theme.ts
   - **阶段 4**：素材采集 → 截图 + SFX 选择
   - **阶段 5**：逐镜头实现 → 组件编码 + 逐帧 QA
   - **阶段 6**：声音设计 → SFX 钉帧表 + 双版本 props
   - **阶段 7**：独立终检 → subagent 检查 → 修复 → 双版本渲染

### 镜头卡片类型

| 卡片 | 用途 | 时长 | 能量骨架位置 |
|------|------|------|-------------|
| `brand-ink-open` | 品牌开场 | 100帧（3.3秒） | ① 品牌开场 |
| `spotlight-hero-card` | 核心功能聚光展示 | 130帧（4.3秒） | ② 单主角立传 |
| `ai-stream-response` | AI 流式回复展示 | 130帧（4.3秒） | ③ 功能爬升 |
| `deck-deal-flyin` | 多卡片发牌飞入 | 130帧（4.3秒） | ③ 功能爬升 |
| `spotlight-sweep-moves` | 聚光灯面板扫过 | 130帧（4.3秒） | ③ 功能爬升 |
| `integration-hub-map` | 集成生态图谱 | 150帧（5秒） | ③ 功能爬升 |
| `paper-title-card` | 节奏呼吸字卡 | 50帧（1.7秒） | 功能呼吸 |
| `outro-group-photo-launch` | 发布会式收束 | 150帧（5秒） | ④ 收场 |

### P0 防坑规则

以下规则源自真实项目翻车复盘，**必须**遵守：

1. **P0-1**：组件导入名必须匹配导出名
2. **P0-2**：SFX 文件名必须用真实路径（禁止占位名）
3. **P0-3**：长样本 SFX（>5秒）必须给 `durationInFrames`
4. **P0-4**：包含真实用户数据的截图必须三重暗化
5. **P0-5**：独立终检必须用干净上下文 subagent

### 能力边界

**能做：**
- 30-40 秒专业级产品/企业宣传片
- 1920×1080 横屏
- 暗场霓虹、明亮干净、深色专业、温暖明亮等多种视觉风格
- 双版本交付（带 BGM / 无 BGM）
- 确定性渲染

**不能做：**
- 实拍素材混剪（需要真实摄像机拍摄）
- 3D 角色动画（Remotion 是 2D/CSS 2.5D 框架）
- 超过 60 秒的长片
- 实时交互式视频

### 许可证

MIT © 2026
