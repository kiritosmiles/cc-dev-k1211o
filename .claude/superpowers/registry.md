# Superpower Registry

中央能力注册表。所有可用 superpower 的唯一定义来源。Agent card 和 binding 文档均引用此处。

---

## 注册条目格式

| 字段 | 说明 |
|------|------|
| **id** | 唯一标识符，kebab-case |
| **name** | 人类可读名称 |
| **type** | `mcp_tool` / `plugin_skill` / `builtin_tool` / `local_skill` / `composite` |
| **source** | 来源路径或工具名 |
| **description** | 一句话描述能力 |
| **provided_by** | 提供方 |

---

## MCP Tools

| id | name | type | source | description | provided_by |
|----|------|------|--------|-------------|-------------|
| `pencil-open` | Open Document | mcp_tool | mcp__pencil__open_document | 打开 .pen 设计文件 | pencil-mcp |
| `pencil-state` | Editor State | mcp_tool | mcp__pencil__get_editor_state | 获取当前编辑器状态和选中节点 | pencil-mcp |
| `pencil-read` | Design Reading | mcp_tool | mcp__pencil__batch_get | 批量读取设计节点结构和属性 | pencil-mcp |
| `pencil-canvas` | Canvas Editing | mcp_tool | mcp__pencil__batch_design | 创建和编辑设计节点（插入/更新/替换/移动/删除） | pencil-mcp |
| `pencil-layout` | Layout Analysis | mcp_tool | mcp__pencil__snapshot_layout | 分析设计文件布局结构、重叠和裁剪问题 | pencil-mcp |
| `pencil-screenshot` | Screenshot | mcp_tool | mcp__pencil__get_screenshot | 截取设计节点渲染预览（开销大，限 1-2 次/阶段） | pencil-mcp |
| `pencil-export` | Export | mcp_tool | mcp__pencil__export_nodes | 导出设计节点为 PNG/JPEG/WEBP/PDF | pencil-mcp |
| `pencil-variables` | Variables | mcp_tool | mcp__pencil__get_variables / set_variables | 读取/设置设计文件的主题变量和设计 token | pencil-mcp |
| `pencil-guidelines` | Guidelines | mcp_tool | mcp__pencil__get_guidelines | 加载设计任务指南和风格预设 | pencil-mcp |
| `pencil-space` | Space Finder | mcp_tool | mcp__pencil__find_empty_space_on_canvas | 在画布上按方向查找空白区域 | pencil-mcp |
| `pencil-properties` | Property Search | mcp_tool | mcp__pencil__search_all_unique_properties | 搜索节点树中所有唯一属性值 | pencil-mcp |
| `pencil-replace` | Property Replace | mcp_tool | mcp__pencil__replace_all_matching_properties | 批量替换节点树中的属性值 | pencil-mcp |

---

## Plugin Skills

| id | name | type | source | description | provided_by |
|----|------|------|--------|-------------|-------------|
| `frontend-design` | Frontend Design | plugin_skill | Skill("frontend-design") | 生成高质量、非 AI 模版化的前端 UI 代码 | anthropic-official |
| `karpathy-guidelines` | Karpathy Guidelines | plugin_skill | Skill("andrej-karpathy-skills:karpathy-guidelines") | 减少 LLM 编码常见错误的编程准则 | community |
| `using-superpowers` | Using Superpowers | plugin_skill | Skill("superpowers:using-superpowers") | 技能系统引导，会话开始时强制执行技能发现 | superpowers-plugin |
| `writing-skills` | Writing Skills | plugin_skill | Skill("superpowers:writing-skills") | TDD 方法创建和编辑技能文件 | superpowers-plugin |
| `brainstorming` | Brainstorming | plugin_skill | Skill("superpowers:brainstorming") | 9 步结构化需求探索和方案设计 | superpowers-plugin |
| `writing-plans` | Writing Plans | plugin_skill | Skill("superpowers:writing-plans") | 将方案分解为 2-5 分钟可执行任务（禁止占位符） | superpowers-plugin |
| `subagent-driven-dev` | Subagent-Driven Dev | plugin_skill | Skill("superpowers:subagent-driven-development") | 大规模并行子代理执行开发计划 + 双审查 | superpowers-plugin |
| `executing-plans` | Executing Plans | plugin_skill | Skill("superpowers:executing-plans") | 无子代理环境下的顺序执行计划 | superpowers-plugin |
| `dispatching-parallel` | Dispatching Parallel | plugin_skill | Skill("superpowers:dispatching-parallel-agents") | 并行调度独立子任务及结果归并 | superpowers-plugin |
| `tdd` | Test-Driven Development | plugin_skill | Skill("superpowers:test-driven-development") | RED-GREEN-REFACTOR 铁律，禁止无测试写代码 | superpowers-plugin |
| `verification-before-completion` | Verification Gate | plugin_skill | Skill("superpowers:verification-before-completion") | 完成门禁：禁止未验证就声称完成 | superpowers-plugin |
| `systematic-debugging` | Systematic Debugging | plugin_skill | Skill("superpowers:systematic-debugging") | 4 阶段系统化调试（根因→模式→假设→修复） | superpowers-plugin |
| `requesting-code-review` | Requesting Code Review | plugin_skill | Skill("superpowers:requesting-code-review") | 通过子代理发起代码审查（含审查提示模板） | superpowers-plugin |
| `receiving-code-review` | Receiving Code Review | plugin_skill | Skill("superpowers:receiving-code-review") | 规范审查反馈处理流程（禁止敷衍同意） | superpowers-plugin |
| `using-git-worktrees` | Using Git Worktrees | plugin_skill | Skill("superpowers:using-git-worktrees") | 创建隔离工作区执行开发任务 | superpowers-plugin |
| `finishing-dev-branch` | Finishing Dev Branch | plugin_skill | Skill("superpowers:finishing-a-development-branch") | 开发完成后的合并/PR/清理标准化流程 | superpowers-plugin |

---

## Built-in Tools

| id | name | type | source | description | provided_by |
|----|------|------|--------|-------------|-------------|
| `web-search` | Web Search | builtin_tool | WebSearch | 搜索互联网获取最新信息 | claude-builtin |
| `web-fetch` | Web Fetch | builtin_tool | WebFetch | 获取并解析指定 URL 的内容 | claude-builtin |
| `agent-spawn` | Agent Spawning | builtin_tool | Agent / TaskCreate | 创建和管理子 agent 任务 | claude-builtin |
| `task-manage` | Task Management | builtin_tool | TaskCreate / TaskUpdate / TaskGet / TaskList | 创建、更新、查询任务状态和依赖 | claude-builtin |
| `code-search` | Code Search | builtin_tool | Grep / Glob | 在代码库中搜索文件和内容 | claude-builtin |
| `git-ops` | Git Operations | builtin_tool | Bash(git:*) | 版本控制操作（status/diff/log/add/commit/branch/checkout） | claude-builtin |
| `shell-test` | Shell Test Execution | builtin_tool | Bash(npm:*), Bash(pnpm:*), Bash(yarn:*) | 运行测试、构建、开发服务器 | claude-builtin |
| `file-ops-read` | File Read | builtin_tool | Read / Glob / Grep | 读取项目文件内容 | claude-builtin |
| `file-ops-write` | File Write | builtin_tool | Write / Edit | 创建和编辑项目文件 | claude-builtin |

---

## Local Skills

| id | name | type | source | description | provided_by |
|----|------|------|--------|-------------|-------------|
| `solution-design` | Solution Design | local_skill | skills/design/solution-design.md | 从需求生成结构化开发方案（分析维度+模板+质量检查） | project-local |
| `api-design` | API Design | local_skill | skills/coding/api-design.md | 设计符合规范的 RESTful API（路由/请求/响应/错误码） | project-local |
| `api-standard` | API Standard | local_skill | skills/standards/api-standard.md | RESTful API 规范（规则，始终遵守） | project-local |
| `coding-standard` | Coding Standard | local_skill | skills/standards/coding-standard.md | 编码规范（命名/函数长度/嵌套/类型安全，规则） | project-local |
| `security-standard` | Security Standard | local_skill | skills/standards/security-standard.md | 安全开发规范（注入防护/认证/数据保护，规则） | project-local |
| `testing` | Testing | local_skill | skills/coding/testing.md | 分层测试设计与执行（用例/覆盖率/边界） | project-local |
| `debugging` | Debugging | local_skill | skills/coding/debugging.md | 系统化调试流程（定位根因→修复→验证） | project-local |
| `code-review` | Code Review | local_skill | skills/coding/code-review.md | 代码审查方法论（6 阶段检查清单+严重级别） | project-local |
| `refactor` | Refactor | local_skill | skills/coding/refactor.md | 安全重构流程（不改行为的代码优化） | project-local |

---

## Composite Superpowers

| id | name | type | source | description | provided_by |
|----|------|------|--------|-------------|-------------|
| `design-to-code` | Design-to-Code Pipeline | composite | pencil-read + pencil-variables + frontend-design | 从设计稿到前端代码的完整流水线 | project-local |
| `fullstack-verify` | Fullstack Verification | composite | shell-test + web-fetch + api-standard | 端到端验证前后端一致性 | project-local |

---

## Agent 分配矩阵

| Superpower ID | orch | analyst | architect | backend | frontend | reviewer | qa |
|---|---|---|---|---|---|---|---|
| **MCP Tools** | | | | | | | |
| pencil-open | - | - | R | - | R | - | - |
| pencil-state | - | - | O | - | O | - | - |
| pencil-read | - | - | R | - | R | - | - |
| pencil-canvas | - | - | R | - | O | - | - |
| pencil-layout | - | - | R | - | O | - | - |
| pencil-screenshot | - | - | O | - | R | - | - |
| pencil-export | - | - | R | - | R | - | - |
| pencil-variables | - | - | - | - | R | - | - |
| pencil-guidelines | - | - | - | - | R | - | - |
| pencil-space | - | - | O | - | O | - | - |
| pencil-properties | - | - | - | - | O | - | - |
| pencil-replace | - | - | - | - | O | - | - |
| **Plugin Skills** | | | | | | | |
| frontend-design | - | - | - | - | R | - | - |
| karpathy-guidelines | - | - | - | R | R | O | - |
| using-superpowers | R | R | R | R | R | R | R |
| writing-skills | O | - | O | - | - | - | - |
| brainstorming | O | R | R | - | - | - | - |
| writing-plans | O | - | R | - | - | - | - |
| subagent-driven-dev | O | - | - | - | - | - | - |
| executing-plans | O | - | - | O | O | - | - |
| dispatching-parallel | O | - | - | - | - | - | O |
| tdd | - | - | - | O | O | - | O |
| verification-before-completion | R | R | R | R | R | R | R |
| systematic-debugging | - | - | - | R | R | - | R |
| requesting-code-review | O | - | - | O | O | R | - |
| receiving-code-review | - | - | O | O | O | - | - |
| using-git-worktrees | O | - | - | - | - | - | - |
| finishing-dev-branch | R | - | - | - | - | - | - |
| **Built-in Tools** | | | | | | | |
| web-search | - | R | O | - | - | - | O |
| web-fetch | - | R | O | O | O | - | R |
| agent-spawn | R | - | - | - | - | - | - |
| task-manage | R | - | - | - | - | - | - |
| code-search | O | R | R | R | R | R | R |
| git-ops | R | - | - | R | R | R | R |
| shell-test | - | - | - | R | R | O | R |
| file-ops-read | R | R | R | R | R | R | R |
| file-ops-write | R | - | R | R | R | S | S |
| **Local Skills** | | | | | | | |
| solution-design | - | R | - | - | - | - | - |
| api-design | - | R | - | O | - | - | O |
| api-standard | - | O | - | R | R | R | R |
| coding-standard | - | O | R | R | R | R | R |
| security-standard | - | O | - | R | - | R | R |
| testing | - | - | - | O | O | - | O |
| debugging | - | - | - | O | O | - | O |
| code-review | - | - | - | - | - | R | - |
| refactor | - | O | - | - | - | - | - |
| **Composite** | | | | | | | |
| design-to-code | - | - | - | - | R | - | - |
| fullstack-verify | - | - | - | - | - | - | R |

> R = required（必需）, O = optional（按需）, S = scoped（限定写入：仅 task 审查/QA 区 + memory 追加）, - = forbidden（禁止）

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 新增 MCP server 或 plugin 时注册新 superpower |
| orchestrator | 发现 agent 能力缺口时提议新增 |
