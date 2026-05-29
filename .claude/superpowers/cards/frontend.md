# Frontend Superpower Card

## 角色定位
前端开发：页面实现、组件开发、状态管理、API 对接。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Systematic Debugging | `systematic-debugging` | 4 阶段系统化调试（优先于项目 debugging skill） | 遇到渲染异常或 bug 时 |
| Verification Gate | `verification-before-completion` | 组件完成前验证构建/测试 | 所有任务完成前 |
| Frontend Design | `frontend-design` | 生成高质量、非 AI 模版化的 UI 代码 | 所有新页面/组件开发 |
| Pencil Open | `pencil-open` | 打开设计稿 .pen 文件 | 有设计稿时 |
| Pencil Read | `pencil-read` | 读取设计稿，提取组件结构和样式规范 | 有设计稿的页面开发 |
| Pencil Export | `pencil-export` | 导出设计稿截图作为开发参考 | 设计稿到代码的转换阶段 |
| Pencil Screenshot | `pencil-screenshot` | 验证前端实现与设计稿的一致性 | 开发完成后（限 1-2 次） |
| Pencil Variables | `pencil-variables` | 提取设计 token（颜色、间距、字体）映射到代码 | 项目初始化或主题变更时 |
| Pencil Guidelines | `pencil-guidelines` | 加载前端设计任务指南 | 设计到代码任务开始时 |
| Design-to-Code | `design-to-code` | 组合 pencil-read + pencil-variables + frontend-design 完成端到端设计到代码转换 | 有完整设计稿的新页面开发 |
| Shell Test | `shell-test` | 运行前端测试、构建、启动开发服务器 | 开发过程中的验证 |
| Git Operations | `git-ops` | 提交前端代码变更 | 任务完成时 |
| Code Search | `code-search` | 查找现有组件、避免重复实现 | 开发前调研 |
| File Read | `file-ops-read` | 读取 memory、standards、现有代码 | 所有开发任务 |
| File Write | `file-ops-write` | 编写前端代码文件 | 所有开发任务 |
| Karpathy Guidelines | `karpathy-guidelines` | 遵循最小改动的编码原则 | 所有编码任务开始时 |
| API Standard | `api-standard` | API 对接必须符合规范 | 始终遵守 |
| Coding Standard | `coding-standard` | 代码必须符合编码规范 | 始终遵守 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Pencil Canvas | `pencil-canvas` | 在设计稿中标注组件边界、补充交互说明 | 设计稿需要补充技术标注时 |
| Pencil Layout | `pencil-layout` | 检查设计稿布局的响应式断点 | 响应式开发时 |
| Pencil Space | `pencil-space` | 在现有设计稿中查找空白区域新增组件 | 增量开发时 |
| Pencil Properties | `pencil-properties` | 搜索设计稿中所有颜色/字体/间距值，统一提取为设计 token | 设计系统建设时 |
| Pencil Replace | `pencil-replace` | 批量替换设计稿中的属性值 | 主题迁移时 |
| Pencil State | `pencil-state` | 获取编辑器当前状态和选中节点 | 需要了解当前编辑上下文时 |
| Web Fetch | `web-fetch` | 查阅框架/组件库文档 | 遇到不熟悉的 API 时 |
| Testing | `testing` | 编写测试用例和覆盖率（补充 tdd 方法论） | 组件开发完成后 |
| Debugging | `debugging` | 轻量快速排查（systematic-debugging 的简化替代） | 简单报错快速定位 |
| TDD | `tdd` | RED-GREEN-REFACTOR 铁律 | 新组件/修复开始时 |
| Executing Plans | `executing-plans` | 无子代理环境下的顺序执行 | 独立执行分解后任务时 |
| Requesting Code Review | `requesting-code-review` | 主动发起代码审查 | 组件完成后 |
| Receiving Code Review | `receiving-code-review` | 规范处理审查反馈 | 收到审查意见时 |

## 已加载 Standards

| Standard | 加载方式 |
|----------|---------|
| Coding Standard | 始终遵守 |
| API Standard | 始终遵守 |

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| Agent Spawning | 不参与任务分发 |
| Task Management | 不操作任务状态 |
| Web Search | 技术调研由 analyst 完成 |

## MCP 工具绑定

参见 `superpowers/bindings/mcp-pencil.md` — Frontend 区。
参见 `superpowers/bindings/plugin-frontend-design.md`。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| frontend | 自身能力变更时 |
| architect | 新增 UI 相关 MCP server 或 plugin 时评估是否授予 frontend |
