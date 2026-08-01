# 防坑规则 — 实战翻车复盘

以下每条规则来源于真实项目中的翻车经历，按严重程度分级。
P0 = 必须遵守，违反会导致成品不可用；P1 = 强烈建议，违反会导致质量下降。

---

## P0-1：组件导入名必须匹配导出名

`Main.tsx` 导出的组件名是 `Main`，`index.tsx` 里 import 必须写 `import { Main } from './Main'`。
Composition 的 `component` 属性必须是 `{Main}`。
Composition id（如 `"WorkBuddyPromo"`）是字符串标识符，与组件名无关。

**翻车场景**：import 写了 `WorkBuddyPromo`，但组件导出名是 `Main`，编译报错。

---

## P0-2：SFX 文件名必须用真实路径

SFX 声明中的 `src` 必须使用 `public/audio/sfx/` 下的**真实文件路径**。
禁止使用 `impact-1.mp3`、`whoosh-2.mp3` 等占位名——运行时不报错但不会有声音。

**正确示例**：
```
'audio/sfx/impact/impact-cine-big.mp3'
'audio/sfx/light/sparkle.mp3'
'audio/sfx/transition/whoosh-big.mp3'
'audio/sfx/text/keyboard.mp3'
```

**翻车场景**：28 条 SFX 全部用了占位名，渲染出的视频完全没有音效。

**验证方法**：采集 SFX 后执行 `find public/audio/sfx -name "*.mp3" | sort`，逐个核对。

---

## P0-3：长样本 SFX 必须给 durationInFrames

时长 >5 秒的 SFX 样本（如 `impact-cine-big.mp3` 时长 7.93s），**必须**在声明中显式给 `dur`（durationInFrames）字段。
否则音频会拖过动作结束仍在响，与下一个镜头的音效重叠。

**正确示例**：
```typescript
{ from: SHOTS.s1.from + 28, src: 'audio/sfx/impact/impact-cine-big.mp3', volume: 0.55, dur: 60 }
```

**判断方法**：用 `ffprobe -i <file> -show_entries format=duration` 检查每个 SFX 时长，>5s 的必须加 dur。

---

## P0-4：截图隐私保护

如果截图素材中包含真实用户姓名、头像、邮箱、手机号等个人信息，**必须**做暗化处理。

**三重暗化法**（必须同时做）：
1. 背景截图加 CSS filter：`filter: 'brightness(0.22) saturate(0.3) contrast(0.8)'`
2. 在敏感区域加 targeted scrim（linear-gradient 覆盖文字带）
3. 聚光灯/遮罩半径控制好，不要溢出到敏感区域
4. 额外加一层 radial-gradient 暗场 overlay

**翻车场景**：S8 镜头使用包含真实用户 testimonial 的截图，聚光灯半径过大（[160,1300]）暴露了真实姓名和头像。

---

## P0-5：独立终检必须用干净上下文

阶段 7 的终检**不能由主 Agent 自己检查自己**——存在确认偏差。
必须派一个干净上下文的 subagent，给它 `final-review.md` 和 `aesthetic-rules.md`，让它逐条检查。

**翻车场景**：主 Agent 自检通过，但独立终检发现了 4 个 P0 问题（隐私泄露、视觉方向漂移、SFX 长样本无 dur、文字字号不达标）。

---

## P1-1：VignetteGrain prop 名

VignetteGrain 组件接受的是 `vignetteOpacity`（不是 `opacity`）。
传 `opacity={0.4}` 不会报错（如果有 `?` 可选标记），但暗角效果不会生效。

---

## P1-2：Easing.out 只接受一个参数

`Easing.out(Easing.cubic)` 只接受一个参数（缓动函数）。
**不要**写成 `Easing.out(Easing.cubic, ...clamp)`——`extrapolateLeft/Right` 是 `interpolate` 的参数。

正确写法：
```typescript
interpolate(frame, [0, 30], [0, 1], {
  easing: Easing.out(Easing.cubic),
  extrapolateLeft: 'clamp',
  extrapolateRight: 'clamp',
})
```

---

## P1-3：禁止不存在的 CSS 属性

不要使用 `opacity2`、`brightness2` 等不存在的 CSS 属性。
**不要**用 `as React.CSSProperties` 绕过类型检查——TypeScript 报错说明写错了，应该去修而不是绕过。

---

## P1-4：暗化背景不要给 PageCam 加 filter

PageCam 的 `filter` 属性会同时作用于其 children（hero card 等）。
如果给 PageCam 加 `brightness(0.5)`，hero card 也会变暗。

**正确做法**：在 PageCam **外层**加独立的 overlay div 做暗化，PageCam 本身保持原色。
hero card 不需要额外提亮——vignette 的透明中心区会让它自然突出。

---

## P1-5：聚光灯移动必须用 Easing.linear

聚光灯/遮罩的移动必须用 `Easing.linear`（匀速），不能用 ease 缓动。
原因：ease 会导致聚光灯速度不均匀——开始慢中间快结尾慢，观众会感知到"穿帮"。

---

## P1-6：文字最小有效字高（Q11）

画面中所有可见文字必须满足：
- 字幕/标题文字：≥ 56px
- 辅助/标签文字：≥ 32px

如果文字放在 3D 空间里（PageCam children），实际渲染尺寸会因透视缩小——要么放大字号，要么移到 screen-space。

常见违规位置：镜头注解、专家标签、集成标签、结尾标语。

---

## P1-7：确定性渲染

禁止使用 `Math.random()` 和 `Date.now()`。
用 mulberry32 固定种子保证同一代码出同一画面：

```typescript
const mulberry32 = (seed: number) => {
  return () => {
    seed |= 0; seed = seed + 0x6D2B79F5 | 0;
    let t = Math.imul(seed ^ seed >>> 15, 1 | seed);
    t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t;
    return ((t ^ t >>> 14) >>> 0) / 4294967296;
  };
};
```

---

## P1-8：双版本必须出自同一时间线

带 BGM 版和无 BGM 版必须用同一个 `Main` 组件、同一个 `theme.ts`、同一个时间线。
唯一区别是 `bgm` inputProp 布尔值。**不要**创建两套代码。

渲染命令：
```bash
# 带 BGM
npx remotion render src/index.tsx <CompositionId> out/promo.mp4 --concurrency=2
# 无 BGM
npx remotion render src/index.tsx <CompositionId> out/promo-nobgm.mp4 --props=props-nobgm.json --concurrency=2
```
