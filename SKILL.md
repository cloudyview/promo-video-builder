---
name: promo-video-builder
description: 企业/产品宣传片端到端制作能力。当用户需要制作产品宣传片、企业宣传视频、产品展示视频、promo video 时触发。从产品理解、视觉方向、分镜设计、逐镜头渲染、声音设计到独立终检交付，全流程自主完成，输出双版本 MP4（带BGM / 无BGM）。依赖 video-shotcraft skill 的模板和音效库。
agent_created: true
---

# Promo Video Builder

## 概述

为任意产品/企业制作专业级宣传片（30-40秒，1920×1080，30fps），使用 Remotion（React 视频框架）从零渲染，输出双版本 MP4。

本 skill 在 video-shotcraft skill 基础上，提供宣传片场景的实操方法论和防坑规则。所有方法论来源于真实项目实战复盘。

## 依赖

- **video-shotcraft skill**：提供 Remotion 项目模板、组件库（PageCam/FlashCut/PaperTitleCard等）、SFX 音效库（150+文件）、参考文档（pipeline.md/aesthetic-rules.md/final-review.md）
- **Node.js >= 18**：运行 Remotion
- **FFmpeg**：音视频验证

## 触发条件

当用户表达以下意图时触发：
- "制作宣传片" / "做企业宣传片" / "做产品宣传片"
- "make a promo video" / "create a promotional video"
- "帮我做一个产品展示视频"
- 用户提供产品信息并要求制作视频

## 执行流程

### 第一步：项目初始化

运行初始化脚本，检查环境并创建 Remotion 项目：

```bash
bash {SKILL_ROOT}/scripts/init_project.sh <项目目录路径>
```

脚本会自动：
1. 检查 Node.js / FFmpeg 环境
2. 查找已安装的 video-shotcraft skill
3. 复制 Remotion 项目模板（源码 + 组件库 + FX）
4. 复制 SFX 音效库（150+ 文件）
5. 运行 npm install
6. 创建 props-nobgm.json 和 out/qa/ 目录

如果 video-shotcraft 未安装，脚本会提示用户先安装。

### 第二步：素材采集

将目标产品的截图放入 `public/textures/`：
- 产品官网首页完整长图
- 核心功能区域截图
- 其他分镜表需要的区域

**隐私检查**：如果截图中包含真实用户姓名、头像、邮箱、手机号，标记为"必须暗化处理"。

### 第三步：八阶段流水线

加载 `references/pipeline-guide.md`，按八阶段流水线执行：

1. **阶段 0**：产品理解 → 产品简报 + 数据约束
2. **阶段 1**：视觉方向 → 色板 + 字体 + styleframe
3. **阶段 2**：功能映射 → 镜头列表（参考 `references/shot-card-catalog.md`）
4. **阶段 3**：分镜表 → 精确帧号 + theme.ts
5. **阶段 4**：素材采集 → 截图 + SFX（参考 `references/sfx-mapping.md`）
6. **阶段 5**：逐镜头实现 → 每镜头 QA（参考 `references/anti-pit-rules.md`）
7. **阶段 6**：声音设计 → SFX 钉帧表 + 双版本 props
8. **阶段 7**：独立终检 → subagent 检查 → 修复 → 渲染双版本（参考 `references/delivery-checklist.md`）

**关键原则**：
- 阶段 0-3 自主完成，不暂停等用户确认
- 每个镜头实现后立即 `npx remotion still` QA
- 阶段 7 必须派干净上下文 subagent 做独立终检
- 全程不询问用户"要不要继续"，直到双版本交付

### 第四步：交付

渲染双版本并验证：

```bash
# 带 BGM 版
npx remotion render src/index.tsx <CompositionId> out/promo.mp4 --concurrency=2

# 无 BGM 版
npx remotion render src/index.tsx <CompositionId> out/promo-nobgm.mp4 --props=props-nobgm.json --concurrency=2
```

用 `references/delivery-checklist.md` 逐项验收。

## 防坑规则

**在阶段 5 开始前，必须加载 `references/anti-pit-rules.md`。**

该文件包含 5 条 P0 规则（必须遵守）和 8 条 P1 规则（强烈建议），每条都来源于真实翻车复盘：

- P0-1：组件导入名必须匹配导出名
- P0-2：SFX 文件名必须用真实路径（非占位名）
- P0-3：长样本 SFX 必须给 durationInFrames
- P0-4：截图隐私保护（三重暗化法）
- P0-5：独立终检必须用干净上下文 subagent
- P1-1 ~ P1-8：prop名、Easing参数、CSS属性、暗化方案、聚光灯速度、文字字号、确定性渲染、双版本一致性

## 参考文档

| 文件 | 用途 | 加载时机 |
|------|------|---------|
| `references/pipeline-guide.md` | 八阶段流水线实操指南 | 阶段 0 开始时 |
| `references/shot-card-catalog.md` | 镜头卡片类型目录 + 选择决策树 | 阶段 2 |
| `references/sfx-mapping.md` | SFX 类别到场景的映射表 | 阶段 4 和 6 |
| `references/anti-pit-rules.md` | 防坑规则（P0/P1） | 阶段 5 开始前 |
| `references/delivery-checklist.md` | 交付验收清单 | 阶段 7 |

同时引用 video-shotcraft skill 的参考文档：
- `pipeline.md` — 八阶段流水线权威定义
- `aesthetic-rules.md` — 18条审美准则
- `final-review.md` — 独立终检清单
- `music-beat-sync.md` — BGM节拍对齐方法

## 能力边界

**能做**：
- 30-40秒专业级产品/企业宣传片
- 1920×1080 横屏
- 暗场霓虹、明亮干净等多种视觉风格
- 双版本交付（带BGM / 无BGM）
- 确定性渲染（同样代码出同样画面）

**不能做**：
- 实拍素材混剪（需要真实摄像机拍摄）
- 3D角色动画（Remotion 是 2D/CSS 2.5D 框架）
- 超过 60 秒的长片（节奏控制会失控）
- 实时交互式视频
