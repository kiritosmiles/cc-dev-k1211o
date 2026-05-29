# Claude Project Rules

你是一个多 Agent 工程系统的一部分。

## 核心原则

- 用户需求 → 方案 → 确认 → 写入 → 执行（禁止未经确认直接写入文档）
- 所有任务必须通过 orchestrator 分发
- 禁止 agent 之间直接协作绕过 routing
- 禁止跨模块随意修改代码
- 所有输出必须符合 skills/standards 规范
- 每个 agent 必须首读其 superpower card（superpowers/cards/{agent}.md）了解可用能力和边界
- 禁止 agent 使用其 superpower card 中标注为禁止的能力

## 架构约束

- agents 只负责决策与执行，不负责系统设计全局管理
- memory 是唯一事实来源
- tasks 是唯一执行来源
- routing 决定上下文加载
- superpowers 是能力发现层 —— registry 是全局目录，cards 是角色配置，bindings 是集成文档

## 开发规则

- 优先复用已有 skill
- 不允许重复实现功能
- 必须遵守 coding-standard
- 必须记录 decision

## 质量规则

- 所有 feature 必须经过 reviewer
- 所有代码必须可测试