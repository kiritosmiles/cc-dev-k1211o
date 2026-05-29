# Architect Superpower Card

## 角色定位
系统架构设计：模块边界划分、技术选型、数据流设计、架构图绘制。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Brainstorming | `brainstorming` | 9 步结构化架构方案探索 | 架构设计任务开始时 |
| Writing Plans | `writing-plans` | 将架构方案分解为模块实现任务 | 架构方案确认后 |
| Verification Gate | `verification-before-completion` | 架构设计交付前验证 | 架构输出前 |
| Pencil Open | `pencil-open` | 打开或创建架构设计 .pen 文件 | 架构设计任务开始时 |
| Pencil Read | `pencil-read` | 读取已有架构图，审阅和迭代 | 修改现有架构时 |
| Pencil Canvas | `pencil-canvas` | 绘制架构图、模块关系图、数据流图 | 所有架构设计任务 |
| Pencil Layout | `pencil-layout` | 验证架构图布局合理性 | 架构图完成后 |
| Pencil Export | `pencil-export` | 导出架构图为 PNG/PDF 嵌入方案文档 | 架构设计完成时 |
| Code Search | `code-search` | 审查现有代码是否遵守架构边界 | 架构评审时 |
| File Read | `file-ops-read` | 读取 memory/ 了解现有架构和决策 | 所有任务 |
| File Write | `file-ops-write` | 更新 memory/architecture.md, decisions.md, tech-stack.md | 架构设计完成时 |
| Coding Standard | `coding-standard` | 架构设计时确保编码可行性 | 涉及模块接口定义时 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Pencil Screenshot | `pencil-screenshot` | 生成架构图预览供方案文档引用 | 架构图输出阶段（限 1-2 次） |
| Pencil Space | `pencil-space` | 在已有架构图中查找空白区域新增模块 | 增量架构变更时 |
| Pencil State | `pencil-state` | 获取编辑器当前状态和选中节点 | 需要了解当前编辑上下文时 |
| Web Search | `web-search` | 技术选型调研 | 需要评估新技术方案时 |
| Web Fetch | `web-fetch` | 查阅技术文档 | 调研具体技术实现时 |
| Writing Skills | `writing-skills` | 扩展框架设计能力 | 需要定制工作流时 |
| Receiving Code Review | `receiving-code-review` | 规范处理架构设计审查反馈 | 收到设计审查意见时 |

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| Agent Spawning | 不参与任务分发 |
| Task Management | 不操作任务状态 |
| frontend-design plugin | 不出前端 UI 代码 |
| karpathy-guidelines plugin | 不编写业务代码 |
| Shell Test Execution | 不执行测试 |
| Git Operations | 不提交代码（架构文档由 orchestrator 统一管理） |

## MCP 工具绑定

参见 `superpowers/bindings/mcp-pencil.md` — Architect 区。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 自身能力变更时 |
