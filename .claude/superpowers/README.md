# Superpowers Framework

多 Agent 插件能力体系。为每个 agent 提供清晰的插件能力（superpower）声明——包含 MCP 工具、Skill 插件、内置工具、本地 Skill。

---

## 核心理念

**Convention-over-enforcement**：Claude Code 不支持 per-agent 工具权限控制，superpowers 框架是约定层。Agent 自约束遵守其 card 中定义的能力边界，这与现有架构中 "analyst 不写代码" 的自约束模式一致。

---

## 三层结构

```
superpowers/
├── registry.md          ← 全局能力目录（唯一事实来源）
├── cards/               ← 每个 agent 的能力配置
│   └── {agent}.md       ← 能用什么 + 禁止用什么
├── bindings/            ← MCP/插件到 agent 的映射文档
│   └── {mcp-or-plugin}.md
└── README.md            ← 本文件
```

| 层 | 作用 | 受众 |
|----|------|------|
| **registry.md** | 所有可用 superpower 的唯一定义来源 | 所有 agent（了解全局能力） |
| **cards/{agent}.md** | 单个 agent 的能力配置和边界 | 对应 agent（启动时首读） |
| **bindings/{name}.md** | MCP server 或 plugin 的工具列表和使用指南 | 绑定到的 agent（使用前查阅） |

---

## 快速开始

### 查看某个 agent 的全部能力

```text
读取 superpowers/cards/{agent}.md
```

### 查看某个 MCP server 提供哪些工具

```text
读取 superpowers/bindings/{mcp-name}.md
```

### 添加新的 MCP server 或 plugin

1. 在 `bindings/` 创建 binding 文档（参考 `_TEMPLATE.md`）
2. 在 `registry.md` 注册新工具
3. 更新相关 agent 的 card（添加/移除能力）
4. 更新 `context-loader.md`（如在新的 agent 区需要加载）

---

## 与现有系统的关系

| 系统 | 关系 |
|------|------|
| `agents/*.md` | Agent 定义文件中引用 superpower card |
| `skills/` | 本地 skill 在 registry 中注册为 local_skill |
| `routing/context-loader.md` | 加载链的首步——agent 启动时首读 superpower card |
| `CLAUDE.md` | 核心原则引用 superpower 约定 |
| `settings.json` | 无变更——权限模型不变，superpowers 是约定层 |

---

## Superpower 类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `mcp_tool` | MCP server 提供的工具 | pencil-read, pencil-canvas |
| `plugin_skill` | 插件提供的 Skill | frontend-design, karpathy-guidelines |
| `builtin_tool` | Claude Code 内置工具 | WebSearch, Bash, Grep |
| `local_skill` | 项目本地 Skill | solution-design, code-review |
| `composite` | 组合多个能力的复合流程 | design-to-code, fullstack-verify |

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 新增 MCP server 或 plugin 时注册、创建 binding、更新 card |
| orchestrator | 发现 agent 能力缺口时提议新增 superpower |
