# 交付清单

本文件是阶段 7 的最终交付检查清单。所有项目必须通过才能交付。

---

## 一、成片文件

- [ ] `out/promo.mp4` — 带 BGM 版
- [ ] `out/promo-nobgm.mp4` — 无 BGM 版（仅 SFX）
- [ ] 两版出自同一时间线（仅 `bgm` prop 不同）
- [ ] 规格：1920×1080，30fps，H.264 + AAC

验证命令：
```bash
ffprobe -v error -show_entries stream=codec_name,codec_type,width,height,duration,r_frame_rate -of compact out/promo.mp4
ffprobe -v error -show_entries stream=codec_name,codec_type,width,height,duration,r_frame_rate -of compact out/promo-nobgm.mp4
```

## 二、音频验证

- [ ] BGM 版 mean volume 在 -18 ~ -22 dB 范围
- [ ] 无 BGM 版 mean volume 比 BGM 版低 5-8 dB
- [ ] 无 BGM 版仍有 SFX 音效（不是完全静音）

验证命令：
```bash
ffmpeg -i out/promo.mp4 -af volumedetect -f null /dev/null 2>&1 | grep mean_volume
ffmpeg -i out/promo-nobgm.mp4 -af volumedetect -f null /dev/null 2>&1 | grep mean_volume
```

## 三、独立终检

- [ ] 派了干净上下文 subagent（不是主 Agent 自检）
- [ ] subagent 对照 `final-review.md` 8 大类检查完毕
- [ ] subagent 对照 `aesthetic-rules.md` 18 条准则检查完毕
- [ ] 所有 P0 问题已修复
- [ ] P1 问题已修复或有明确理由保留

## 四、数据安全

- [ ] 截图素材中无真实用户姓名、头像、邮箱、手机号
- [ ] 包含敏感信息的截图已做三重暗化（filter + scrim + 聚光灯半径）
- [ ] 无客户数据、内部数据、密钥暴露

## 五、视觉质量

- [ ] 全片视觉方向一致（暗场/明亮不混用）
- [ ] 所有可见文字 ≥ 56px（字幕）或 ≥ 32px（标签）
- [ ] 主体内容聚焦，背景不抢镜
- [ ] 转场流畅，无突兀跳变

## 六、确定性渲染

- [ ] 无 `Math.random()` 调用
- [ ] 无 `Date.now()` 调用
- [ ] 使用 mulberry32 或类似固定种子
- [ ] 重复渲染结果一致

## 七、SFX 完整性

- [ ] 所有 SFX 文件名是真实路径（非占位名）
- [ ] 长样本（>5s）已给 `dur` 字段
- [ ] SFX 与画面动作时间对齐
- [ ] 每个镜头至少有 1-2 条 SFX

## 八、QA 产物

- [ ] 每个镜头至少 1 张代表帧已渲染到 `out/qa/`
- [ ] QA 帧已肉眼检查通过
- [ ] 修复后的版本帧已归档
