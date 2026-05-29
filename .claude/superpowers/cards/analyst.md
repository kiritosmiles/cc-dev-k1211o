# Analyst Superpower Card

## 角色定位
需求分析与方案设计：将模糊需求转化为结构化的可执行方案。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Brainstorming | `brainstorming` | 9 步结构化需求探索和方案设计 | 所有 feature/refactor/architecture 需求 |
| Verification Gate | `verification-before-completion` | 方案交付前验证完整性 | 方案输出前 |
| Web Search | `web-search` | 调研技术方案、查最新文档、对比竞品实现 | 需求涉及新技术或不确定方案时 |
| Web Fetch | `web-fetch` | 读取在线文档、API 参考、技术文章 | 需要查阅外部资源时 |
| Solution Design | `solution-design` | 按模板生成结构化开发方案（轻量补充 brainstorming） | 简单需求或快速方案 |
| API Design | `api-design` | 设计符合规范的 API 接口草案 | 需求涉及新 API 时 |
| Code Search | `code-search` | 调研现有代码库结构和实现 | 理解现有模块边界时 |
| File Read | `file-ops-read` | 读取 memory 和代码文件进行上下文调研 | 所有任务（只读） |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Refactor | `refactor` | 生成重构方案 | 重构类需求 |
| Coding Standard | `coding-standard` | 方案中引用编码规范约束 | 涉及代码生成的方案 |
| API Standard | `api-standard` | 方案中引用 API 规范约束 | 涉及 API 设计的方案 |
| Security Standard | `security-standard` | 方案中标注安全注意事项 | 涉及鉴权/数据处理的方案 |

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| 所有 MCP 设计工具 (pencil-*) | analyst 不出设计稿 |
| Agent Spawning | 任务分发由 orchestrator 控制 |
| Task Management | 不操作任务状态 |
| Shell Test Execution | 不执行代码或测试 |
| frontend-design plugin | 不生成前端代码 |
| karpathy-guidelines plugin | 不编写代码 |
| File Write | 只读调研，不创建或修改任何文件 |
| Git Operations | 不提交代码 |

## MCP 工具绑定

Analyst 不绑定任何 MCP 工具。能力完全由 builtin_tool + local_skill 组成。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| analyst | 自身能力变更时 |
| architect | 新增外部数据源或 API 时评估是否授予 analyst |
