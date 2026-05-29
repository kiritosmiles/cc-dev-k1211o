# Frontend Design Plugin Binding

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **名称** | Frontend Design |
| **类型** | plugin_skill |
| **提供方** | anthropic-official |
| **调用方式** | `Skill("frontend-design")` |

---

## Agent 绑定

| Agent | 使用场景 | 优先级 |
|-------|---------|--------|
| **frontend** | 所有前端页面和组件的初始开发；需要高质量、有独特风格、非 AI 模版化 UI 的场景 | required |

---

## 使用约束

- **禁止 agent**: orchestrator, analyst, architect, backend, reviewer, qa — 这些 agent 不生成前端 UI 代码
- **前提条件**: 已有设计稿（.pen 文件）或明确的设计规范（design-system.md）
- **与 Pencil 配合**: 先通过 `pencil-read` 读取设计稿，再调用 `frontend-design` 生成代码

---

## 触发条件（frontend agent 决策树）

```
组件开发任务
  ├── 全新页面/组件 → 必须调用 frontend-design
  ├── 修改现有组件 → 不调用（局部修改不触发完整设计流程）
  └── Bug 修复 → 不调用
```

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| frontend | 发现新的适用场景时补充 |
