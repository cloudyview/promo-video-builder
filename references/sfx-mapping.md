# SFX 音效映射表

本文档提供 SFX 类别到场景的映射关系，帮助在阶段 4（素材采集）和阶段 6（声音设计）中快速选择正确的音效文件。

所有文件位于 `public/audio/sfx/` 目录下。

---

## 类别总览

| 类别 | 路径 | 用途 |
|------|------|------|
| impact | `audio/sfx/impact/` | 重击、砸落、品牌落定 |
| light | `audio/sfx/light/` | 闪烁、魔法、高光出现 |
| transition | `audio/sfx/transition/` | 转场、飞过、whoosh |
| text | `audio/sfx/text/` | 打字机、键盘、标记 |
| paper | `audio/sfx/paper/` | 纸张翻动、卡片落定 |
| riser | `audio/sfx/riser/` | 上升、蓄力、高潮前奏 |
| camera | `audio/sfx/camera/` | 快门、对焦、缩放 |
| data | `audio/sfx/data/` | 数字 glitch、扫描、加载 |
| crowd | `audio/sfx/crowd/` | 掌声、心跳 |
| glass | `audio/sfx/glass/` | 玻璃破碎、撞击 |
| mech | `audio/sfx/mech/` | 机械、锁扣、齿轮 |
| film | `audio/sfx/film/` | 胶片、磁带、复古 |
| fluid | `audio/sfx/fluid/` | 水滴、气泡、流沙 |
| scifi | `audio/sfx/scifi/` | 科幻、电子、空间 |

---

## 场景到 SFX 映射

### 品牌开场（brand-ink-open）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 字标砸落 | `impact/impact-cine-big.mp3` | 0.55 | ⚠️ 时长7.93s，必须给 `dur: 60` |
| 高光闪烁 | `light/sparkle.mp3` | 0.35 | 品牌色出现时 |

### 聚光推入（spotlight-hero-card）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 推入转场 | `transition/whoosh-big.mp3` | 0.40 | PageCam 开始移动 |
| 卡片弹出 | `light/sparkle-touch.mp3` | 0.30 | hero card pop |

### AI 流式回复（ai-stream-response）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 打字开始 | `text/keyboard.mp3` | 0.30 | ⚠️ 给 `dur: 24` |
| 每句出现 | `text/typewriter-hit-single.mp3` | 0.14-0.25 | 递减音量 |
| 回复完成 | `impact/hit-fast-exciting.mp3` | 0.45 | 最终结果落地 |

### 卡片发牌（deck-deal-flyin）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 每张卡飞入 | `paper/paper-move-quick.mp3` | 0.20-0.30 | 递减音量 |
| 全部落定 | `impact/impact-cine-big.mp3` | 0.40 | ⚠️ 给 `dur: 60` |

### 聚光灯扫过（spotlight-sweep-moves）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 开始扫描 | `light/sparkle.mp3` | 0.30 | |
| 扫过中段 | `transition/whoosh-fast.mp3` | 0.35 | |
| 命中面板 | `light/sparkle-touch.mp3` | 0.25 | |

### 集成中枢（integration-hub-map）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 卡片翻转 | `transition/whoosh-big.mp3` | 0.40 | |
| 图标命中 | `impact/hit-fast-exciting.mp3` | 0.50 | |
| 光管连接 | `light/sparkle.mp3` | 0.30 | |
| 连接完成 | `light/sparkle-touch.mp3` | 0.25 | |

### 收场合影（outro-group-photo-launch）

| 时机 | 文件 | 音量 | 说明 |
|------|------|------|------|
| 上升蓄力 | `riser/riser-cine.mp3` | 0.35 | ⚠️ 时长较长，给 `dur: 90` |
| 字标砸落 | `impact/impact-cine-big.mp3` | 0.60 | ⚠️ 给 `dur: 60` |
| 金粉散落 | `light/sparkle.mp3` | 0.40 | |
| 最终闪烁 | `light/sparkle-touch.mp3` | 0.30 | |

---

## 长样本清单（>5s，必须给 dur）

以下文件时长超过 5 秒，使用时**必须**在 SFX 声明中添加 `dur` 字段：

| 文件 | 时长 | 建议 dur |
|------|------|----------|
| `impact/impact-cine-big.mp3` | ~7.93s | 60 (2s) |
| `riser/riser-cine.mp3` | ~5.5s | 90 (3s) |
| `text/keyboard.mp3` | ~6s | 24 (0.8s) |

**判断方法**：`ffprobe -i <file> -show_entries format=duration -v quiet -of csv="p=0"`

---

## BGM 选择参考

| 产品类型 | 推荐 BGM | BPM | 风格 |
|----------|---------|-----|------|
| 科技/SaaS | `house-vibez.mp3` | 122 | tech-house |
| 消费品 | `tonight-hiphop.mp3` | ~100 | 轻快 hip-hop |
| 时尚/品牌 | `cat-walk.mp3` | ~110 | 走秀电子 |
| 企业级 | `bgm-tech-house.mp3` | ~120 | 稳重电子 |
| 活力/年轻 | `g-eazy-nba-type.mp3` | ~95 | hip-hop |

BGM 音量建议 0.30-0.35，不能盖过 SFX。
