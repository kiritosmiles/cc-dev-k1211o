# {MCP Server / Plugin Name} Binding

将 {server_name} 的工具/能力映射到 agent 角色。

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **名称** | {human-readable name} |
| **类型** | mcp_server / plugin_skill |
| **提供方** | anthropic-official / community / custom |
| **版本** | {version or date} |
| **工具数量** | N |

---

## 工具列表

| 工具名 | 功能 | 注册表 ID |
|--------|------|-----------|
| {tool_1} | {description} | `{registry-id}` |
| {tool_2} | {description} | `{registry-id}` |

---

## Agent 绑定

| Agent | 绑定工具 | 使用场景 | 优先级 |
|-------|---------|---------|--------|
| {agent} | {tools} | {when to use} | required / optional |

---

## 使用约束

- **禁止 agent**: {agents that must NOT use this}
- **调用频率**: {rate limits or guidance}
- **前提条件**: {preconditions before use}

---

## 典型工作流

```text
{agent} 收到任务 → 调用 {tool} → {expected outcome}
```

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 新增 MCP server 时创建此文档 |
