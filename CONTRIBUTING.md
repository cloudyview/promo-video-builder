# Contributing to Promo Video Builder

Thanks for your interest in contributing! This project is a [WorkBuddy](https://www.workbuddy.cn) skill — its primary interface is an AI agent, but human contributions are welcome.

## How to Contribute

### Reporting Issues

- Use GitHub Issues
- Describe what happened and what you expected
- Include steps to reproduce if applicable

### Proposing Changes

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a Pull Request

### What to Contribute

- **New shot card types** — Add a new card definition to `references/shot-card-catalog.md`, with purpose, key animations, recommended duration, and anti-pit notes
- **SFX mappings** — Add or refine scene-to-SFX mappings in `references/sfx-mapping.md`
- **Anti-pit rules** — If you encounter a reproducible failure pattern, document it in `references/anti-pit-rules.md` with P0/P1 classification
- **Pipeline refinements** — Improve the 8-stage pipeline guide in `references/pipeline-guide.md`
- **Script improvements** — Enhance `scripts/init_project.sh`
- **Documentation** — Fix typos, add translations, improve clarity

### Code Style

- Keep changes focused and minimal
- Write clear commit messages
- Test your changes before submitting

### Anti-Pit Rule Classification

When adding anti-pit rules, classify them as:

- **P0** (Must fix before delivery): Causes unusable output
- **P1** (Should fix): Causes quality degradation

Include a real-world failure scenario description.

## 贡献指南（中文）

欢迎贡献！本项目是一个 WorkBuddy skill，欢迎社区参与。

### 如何贡献

- 使用 GitHub Issues 报告问题
- Fork 仓库 → 创建功能分支 → 提交 PR

### 可以贡献的内容

- **新镜头卡片类型**：在 `references/shot-card-catalog.md` 中添加
- **SFX 映射优化**：在 `references/sfx-mapping.md` 中完善
- **防坑规则补充**：在 `references/anti-pit-rules.md` 中记录
- **流水线改进**：在 `references/pipeline-guide.md` 中优化
- **脚本增强**：改进 `scripts/init_project.sh`
- **文档改进**：修复笔误、添加翻译、提高清晰度

谢谢你的贡献！
