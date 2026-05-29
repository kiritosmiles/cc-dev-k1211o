# Orchestrator Superpower Card

## 角色定位
项目总调度中心：分类需求、路由任务、管理 agent 生命周期、维护项目状态。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导，强制执行技能发现 | 会话启动时（SessionStart hook 自动注入） |
| Verification Gate | `verification-before-completion` | 完成门禁：禁止未验证就声称完成 | 所有任务完成/状态变更前 |
| Finishing Dev Branch | `finishing-dev-branch` | 开发完成后的合并/PR/清理标准化流程 | 所有开发任务完成后 |
| Agent Spawning | `agent-spawn` | 创建子 agent 执行具体任务 | 每次任务分发 |
| Task Management | `task-manage` | 创建/更新/查询任务状态和依赖 | 每次任务生命周期变更 |
| File Read | `file-ops-read` | 读取 memory、routing、task 文件掌握项目状态 | 每次需求摄入和状态查询 |
| File Write | `file-ops-write` | 创建 task 文件、更新 memory/*.md | 用户确认方案后、会话结束时 |
| Git Operations | `git-ops` | 提交任务产出的代码变更 | 任务完成汇总时 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Brainstorming | `brainstorming` | 9 步结构化需求探索 | 复杂需求的方案探索阶段 |
| Writing Plans | `writing-plans` | 将确认方案分解为可执行任务 | 方案确认后 |
| Writing Skills | `writing-skills` | 扩展和自定义框架 skill | 需要定制流程时 |
| Subagent-Driven Dev | `subagent-driven-dev` | 大规模并行子代理执行 | 多独立任务并行时 |
| Executing Plans | `executing-plans` | 无子代理环境下的顺序执行 | 不适用 subagent 的环境 |
| Dispatching Parallel | `dispatching-parallel` | 并行调度独立子任务 | 多个无依赖任务同时执行 |
| Requesting Code Review | `requesting-code-review` | 发起代码审查 | 任务完成后 |
| Using Git Worktrees | `using-git-worktrees` | 创建隔离工作区 | 需要隔离执行环境时 |
| Code Search | `code-search` | 理解项目结构、验证 agent 产出的文件路径 | 方案评审时 |

## 已加载上下文

Orchestrator 不调用 skills，但必须读取以下路由和元信息文件：
- `routing/intent-router.md`
- `routing/task-dispatcher.md`
- `routing/context-loader.md`
- `superpowers/registry.md` — 了解全局能力分布

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| 所有 MCP 设计工具 (pencil-*) | orchestrator 不操作设计文件 |
| WebSearch / WebFetch | 信息收集由 analyst 完成 |
| 所有 local_skill（solution-design, api-design 等） | 方案生成由 analyst 完成 |
| frontend-design plugin | 代码生成由执行 agent 完成 |
| karpathy-guidelines plugin | 编码风格由开发 agent 掌控 |
| Shell Test Execution | 测试由 qa agent 执行 |
| tdd plugin | TDD 方法由开发 agent 执行 |
| systematic-debugging plugin | 调试由开发/qa agent 执行 |

## 维护者

| 角色 | 触发条件 |
|------|---------|
| orchestrator | 自身能力变更时 |
| architect | 新增 MCP server 或 plugin 时评估对 orchestrator 的影响 |
