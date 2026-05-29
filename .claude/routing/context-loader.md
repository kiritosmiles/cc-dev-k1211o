# Context Loader

上下文加载规则。每个 agent 启动时需加载的最小上下文集合。

---

## 加载优先级

1. **Superpower Card**（必须首读）—— 定义 agent 可用的全部能力和边界
2. **Memory Files** —— 项目现状和约束
3. **Standards** —— 编码/API/安全规范
4. **Method Skills** —— 流程方法论（按需调用）

---

## Orchestrator

- superpowers/cards/orchestrator.md（必须 —— 了解可用能力和边界）
- superpowers/bindings/plugin-superpowers.md（必须 —— Orchestrator 区：using-superpowers, verification-before-completion, finishing-dev-branch）
- superpowers/registry.md（必须 —— 了解全局能力分布）
- routing/intent-router.md（必须）
- routing/task-dispatcher.md（必须）
- memory/progress.md（必须）
- memory/decisions.md（必须）

---

## Analyst

- superpowers/cards/analyst.md（必须 —— 了解可用能力和边界）
- superpowers/bindings/plugin-superpowers.md（必须 —— Analyst 区：using-superpowers, brainstorming, verification-before-completion）
- memory/project-context.md
- memory/architecture.md
- memory/tech-stack.md
- memory/decisions.md
- memory/progress.md
- memory/design-system.md（UI 需求时）
- memory/known-issues.md（bug/重构时）
- skills/design/solution-design.md（必须 —— 轻量方案模板，brainstorming 的补充）

---

## Architect

- superpowers/cards/architecture.md（必须 —— 了解可用能力和边界，包括 Pencil MCP 工具）
- superpowers/bindings/mcp-pencil.md（必须 —— Pencil 工具使用指南）
- superpowers/bindings/plugin-superpowers.md（必须 —— Architect 区：using-superpowers, brainstorming, writing-plans, verification-before-completion）
- memory/project-context.md
- memory/architecture.md
- memory/decisions.md
- memory/tech-stack.md
- skills/standards/coding-standard.md

---

## Backend

- superpowers/cards/backend.md（必须 —— 了解可用能力和边界）
- superpowers/bindings/plugin-karpathy-guidelines.md（必须 —— 编码原则）
- superpowers/bindings/plugin-superpowers.md（必须 —— Backend 区：using-superpowers, systematic-debugging, verification-before-completion）
- memory/architecture.md
- memory/tech-stack.md
- skills/standards/coding-standard.md
- skills/standards/api-standard.md
- skills/standards/security-standard.md

---

## Frontend

- superpowers/cards/frontend.md（必须 —— 了解可用能力、Pencil 工具和前端设计插件）
- superpowers/bindings/mcp-pencil.md（必须 —— Frontend 区）
- superpowers/bindings/plugin-frontend-design.md（必须）
- superpowers/bindings/plugin-karpathy-guidelines.md（必须）
- superpowers/bindings/plugin-superpowers.md（必须 —— Frontend 区：using-superpowers, systematic-debugging, verification-before-completion）
- memory/project-context.md
- memory/architecture.md
- memory/design-system.md
- skills/standards/coding-standard.md
- skills/standards/api-standard.md

---

## Reviewer

- superpowers/cards/reviewer.md（必须 —— 了解审查能力和边界）
- superpowers/bindings/plugin-superpowers.md（必须 —— Reviewer 区：using-superpowers, verification-before-completion, requesting-code-review）
- tasks/in-review/ 中的 task 文件
- task 文件中 changed_files 列出的所有文件
- memory/architecture.md
- skills/standards/coding-standard.md
- skills/standards/security-standard.md
- skills/standards/api-standard.md

---

## QA

- superpowers/cards/qa.md（必须 —— 了解验证能力和边界）
- superpowers/bindings/plugin-superpowers.md（必须 —— QA 区：using-superpowers, systematic-debugging, verification-before-completion）
- memory/project-context.md
- memory/architecture.md
- memory/decisions.md
- skills/standards/coding-standard.md
- skills/standards/api-standard.md
- skills/standards/security-standard.md
- tasks/in-review/* 或 tasks/backlog/*（bug-fix 场景）

---

## 加载规则

1. **Superpower 首读**: 每个 agent 启动时首先读取其 superpower card，了解可用能力全集和边界
2. **必加载**: 列出的 memory 和 standard 文件必须全部读取
3. **按需加载**: agent 执行过程中发现需要更多上下文时，自行扩展读取；method skill 按场景调用
4. **最小原则**: 不加载与当前任务无关的 memory 文件
5. **最新优先**: 先读 memory（事实来源），再读具体代码
6. **能力边界**: agent 必须遵守其 superpower card 中定义的"禁止使用的能力"，不越界操作
