# Backend Superpower Card

## 角色定位
后端开发：API 实现、数据库操作、Service 层业务逻辑。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Systematic Debugging | `systematic-debugging` | 4 阶段系统化调试（优先于项目 debugging skill） | 遇到 bug 或异常时 |
| Verification Gate | `verification-before-completion` | 代码提交前验证测试通过 | 所有任务完成前 |
| Shell Test | `shell-test` | 运行后端测试套件、构建、启动开发服务器 | 每次代码修改后 |
| Git Operations | `git-ops` | 提交后端代码变更 | 任务完成时 |
| Code Search | `code-search` | 查找现有实现、避免重复 | 开发前调研 |
| File Read | `file-ops-read` | 读取 memory、standards、现有代码 | 所有开发任务 |
| File Write | `file-ops-write` | 编写后端代码文件 | 所有开发任务 |
| Karpathy Guidelines | `karpathy-guidelines` | 遵循最小改动、避免过度设计的编码原则 | 所有编码任务开始时 |
| API Standard | `api-standard` | API 实现必须符合规范 | 始终遵守 |
| Coding Standard | `coding-standard` | 代码必须符合编码规范 | 始终遵守 |
| Security Standard | `security-standard` | 代码必须符合安全规范 | 始终遵守 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| API Design | `api-design` | 设计新 API 接口时调用设计流程 | 需要新增 API 时 |
| Testing | `testing` | 编写测试用例和覆盖率（补充 tdd 方法论） | 实现完成后 |
| Debugging | `debugging` | 轻量快速排查（systematic-debugging 的简化替代） | 简单报错快速定位 |
| Web Fetch | `web-fetch` | 查阅框架/库文档 | 遇到不熟悉的 API 时 |
| TDD | `tdd` | RED-GREEN-REFACTOR 铁律 | 新功能/修复开始时 |
| Executing Plans | `executing-plans` | 无子代理环境下的顺序执行 | 独立执行分解后任务时 |
| Requesting Code Review | `requesting-code-review` | 主动发起代码审查 | 实现完成后 |
| Receiving Code Review | `receiving-code-review` | 规范处理审查反馈 | 收到审查意见时 |

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| 所有 Pencil MCP 工具 (pencil-*) | backend 不操作设计文件 |
| frontend-design plugin | backend 不生成前端 UI |
| Agent Spawning | 不参与任务分发 |
| Task Management | 不操作任务状态 |
| Web Search | 技术调研由 analyst 完成（仅在执行中遇到具体问题时使用 WebFetch） |

## MCP 工具绑定

Backend 不绑定任何 MCP 工具。能力由 builtin_tool + local_skill + plugin_skill 组成。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| backend | 自身能力变更时 |
| architect | 新增数据库/基础设施工具时评估是否授予 backend |
