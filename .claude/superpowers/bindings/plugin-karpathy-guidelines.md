# Karpathy Coding Guidelines Binding

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **名称** | Karpathy Guidelines |
| **类型** | plugin_skill |
| **提供方** | community |
| **调用方式** | `Skill("andrej-karpathy-skills:karpathy-guidelines")` |

---

## Agent 绑定

| Agent | 使用场景 | 优先级 |
|-------|---------|--------|
| **backend** | 所有编码任务（API、Service、Repository 实现） | required |
| **frontend** | 所有编码任务（组件、状态管理、API 对接） | required |
| **reviewer** | 代码审查时作为参考标准（最小改动、避免过度设计） | optional |

---

## 使用约束

- **禁止 agent**: orchestrator, analyst, architect, qa — 不编写代码的 agent 不需要
- **触发**: backend/frontend agent 在开始任何编码任务前加载此 guideline
- **reviewer 使用**: 仅在审查编码风格和复杂度时参考，不影响安全/架构维度的判断

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 新增编码 agent 时评估是否绑定 |
