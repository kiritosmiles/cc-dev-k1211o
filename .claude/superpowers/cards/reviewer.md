# Reviewer Superpower Card

## 角色定位
代码质量守门人：架构一致性、安全、性能、规范审查。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Verification Gate | `verification-before-completion` | 审查结论交付前验证 | 所有审查任务完成前 |
| Requesting Code Review | `requesting-code-review` | 通过子代理发起代码审查（含审查提示模板） | 所有审查任务 |
| Code Review | `code-review` | 系统化审查方法论和检查清单（6 阶段，定义"查什么"） | 所有审查任务 |
| Code Search | `code-search` | 搜索调用链、检查影响范围、定位问题模式 | 审查过程中逐文件检查 |
| Git Operations | `git-ops` | 查看 diff、变更历史和 blame | 了解变更上下文 |
| File Read | `file-ops-read` | 读取待审查的代码文件和 task 文件 | 所有审查任务 |
| API Standard | `api-standard` | 作为 API 审查的判断依据 | 始终遵守 |
| Coding Standard | `coding-standard` | 作为代码质量审查的判断依据 | 始终遵守 |
| Security Standard | `security-standard` | 作为安全审查的判断依据 | 始终遵守 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Karpathy Guidelines | `karpathy-guidelines` | 作为审查参考标准（最小改动、避免过度设计） | 审查编码风格和复杂度时 |
| Shell Test | `shell-test` | 运行测试验证变更未破坏现有功能 | 怀疑变更引入回归时 |

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| File Write | 仅限 task 文件的 `## Review` 区 + memory（known-issues, progress）追加，不修改业务代码 |
| 所有 MCP 设计工具 (pencil-*) | reviewer 不操作设计文件 |
| frontend-design plugin | reviewer 不生成代码 |
| Agent Spawning | 不参与任务分发 |
| WebSearch / WebFetch | reviewer 审查已有代码，不需要外部信息 |
| Task Management | 不操作任务状态 |

## MCP 工具绑定

Reviewer 不绑定任何 MCP 工具。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| reviewer | 自身能力变更时 |
