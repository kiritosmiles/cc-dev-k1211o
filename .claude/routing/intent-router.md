# Intent Router

用户需求自动路由规则。

---

## 路由表

| 需求类型 | 路由路径 |
|---------|---------|
| Feature（新增功能） | orchestrator → **analyst**（生成方案）→ 用户确认 → architect → backend/frontend |
| Bug-fix（复杂） | orchestrator → **analyst**（生成修复方案）→ 用户确认 → qa → backend/frontend |
| Bug-fix（简单） | orchestrator → qa → backend/frontend |
| Refactor | orchestrator → **analyst**（生成重构方案）→ 用户确认 → reviewer → backend/frontend |
| Architecture | orchestrator → **analyst**（生成技术方案）→ 用户确认 → architect |
| Review | orchestrator → reviewer |
| QA | orchestrator → qa |

---

## 简单 Bug 判断标准

满足以下所有条件可跳过 analyst：
- 影响范围限定在 1 个文件
- 不需要修改 API 接口
- 不涉及数据库 schema 变更
- 不涉及架构变更

---

## Agent 能力速查

| Agent | 能力 | 核心 Superpower | 不可做的事 |
|-------|------|----------------|-----------|
| orchestrator | 分类、路由、归档、会话汇总 | agent-spawn, task-manage | 不写业务代码、不出详细方案 |
| analyst | 需求分析、上下文调研、方案生成 | web-search, solution-design | 不写代码、不操作文件 |
| architect | 架构设计、模块边界、技术选型 | pencil-canvas, pencil-export | 不写业务代码 |
| backend | API、数据库、Service、业务逻辑 | shell-test, karpathy-guidelines | 不改 frontend |
| frontend | 页面、组件、状态管理、API 对接 | frontend-design, design-to-code | 不改 backend |
| reviewer | 代码审查、架构一致性检查 | code-review, code-search | 不修改代码 |
| qa | 功能验证、回归测试、问题定位 | fullstack-verify, shell-test | 不修改代码 |
