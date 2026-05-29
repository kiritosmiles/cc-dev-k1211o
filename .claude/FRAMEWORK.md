# .claude 多智能体开发框架

## 一、框架概述

`.claude` 是一个面向企业级软件开发的**多 Agent 协作框架**。它通过 7 个专业 Agent + 路由系统 + 记忆系统 + 任务系统，将软件开发流程从"用户 → AI 写代码"升级为：

```
用户需求 → 分析员出方案 → 用户确认 → 架构师设计 → 开发实现 → 审查 → 测试 → 归档
```

### 核心理念

- **方案先行**：写代码前必须先出方案，经用户确认才执行
- **职责分离**：7 个 Agent 各司其职，禁止越界（analyst 不写代码，reviewer 不改代码）
- **Memory 是唯一事实来源**：项目状态、架构决策、已知问题全部落盘
- **Superpowers 能力体系**：每个 Agent 有明确定义的插件/工具/MCP 能力清单和禁止边界，已集成 superpowers 社区插件（14 个 behavioral skills）
- **Convention-over-enforcement**：Agent 自约束遵守规则（Claude Code 不支持 per-agent 权限控制）

### 目录结构

```
.claude/
├── CLAUDE.md                  # 项目宪法 —— 核心原则 + 架构约束 + 质量规则
├── settings.json              # 权限配置（全局 allow/deny + hooks）
│
├── agents/                    # 7 个 Agent 角色定义
│   ├── orchestrator.md        # 总调度
│   ├── analyst.md             # 需求分析
│   ├── architecture.md        # 架构设计
│   ├── backend.md             # 后端开发
│   ├── frontend.md            # 前端开发
│   ├── reviewer.md            # 代码审查
│   └── qa.md                  # 质量验证
│
├── routing/                   # 路由与调度
│   ├── intent-router.md       # 需求 → Agent 分类规则
│   ├── context-loader.md      # 每个 Agent 启动时加载的上下文清单
│   └── task-dispatcher.md     # 任务状态机 + 分发规则 + 并发控制
│
├── skills/                    # 技能库
│   ├── design/                # 方案设计模板
│   ├── coding/                # 编码方法论（api-design/testing/debugging/code-review/refactor）
│   └── standards/             # 规范标准（api/coding/security）
│
├── workflows/                 # 工作流定义
│   ├── feature-development.md # 新功能开发全流程
│   ├── bug-fix.md             # Bug 修复全流程
│   └── code-review.md         # 独立审查流程
│
├── memory/                    # 记忆系统（持久化知识库）
│   ├── project-context.md     # 项目背景 + 核心模块
│   ├── architecture.md        # 系统架构 + 模块边界 + 数据流
│   ├── tech-stack.md          # 技术栈选型记录
│   ├── decisions.md           # 架构决策记录 (ADR)
│   ├── design-system.md       # 前端设计系统
│   ├── known-issues.md        # 已知问题和 Bug 记录
│   └── progress.md            # 项目进度快照
│
├── superpowers/               # 插件能力体系
│   ├── README.md              # 框架使用指南
│   ├── registry.md            # 全局能力目录（50+ 条目 + Agent 分配矩阵）
│   ├── cards/                 # 每个 Agent 的能力配置卡
│   └── bindings/              # MCP/插件到 Agent 的映射文档
│       ├── _TEMPLATE.md       # 新 MCP/插件接入模板
│       ├── mcp-pencil.md      # Pencil MCP（12 工具）→ architect/frontend
│       ├── plugin-frontend-design.md  # Frontend Design 插件
│       ├── plugin-karpathy-guidelines.md  # Karpathy 编码准则
│       └── plugin-superpowers.md  # Superpowers 社区插件（14 skills）
│
├── tasks/                     # 任务看板
│   ├── backlog/               # 待执行任务
│   ├── in-progress/           # 执行中
│   ├── in-review/             # 审查中 + QA 中
│   ├── blocked/               # 被阻塞
│   └── done/                  # 已完成
│
└── hooks/                     # 生命周期钩子
    └── session-end.sh         # 会话结束时自动清理
```

---

## 二、工作流程

### 2.1 新功能开发（feature development）

```
用户描述需求
    │
    ▼
① Orchestrator 分类识别 → type: feature
    │
    ▼
② 路由到 Analyst
    ├── 读取 memory（project-context / architecture / tech-stack / decisions / progress）
    ├── 调用 brainstorming skill 进行 9 步结构化探索（主流程）
    ├── 调用 solution-design skill 生成轻量方案补充
    ├── 调用 WebSearch/WebFetch 调研技术方案
    └── 返回方案给 Orchestrator
    │
    ▼
③ Orchestrator 呈现方案，等待用户确认
    ├── 确认 → 继续
    ├── 修改 → 回到 ②
    └── 驳回 → 结束
    │
    ▼
④ 用户确认后，Orchestrator 写入归档：
    ├── 创建 task 文件到 tasks/backlog/
    ├── 更新 memory/progress.md (Next 区)
    └── 标注依赖关系
    │
    ▼
⑤ Architect 设计模块边界（如需要新模块）
    ├── 调用 brainstorming skill 探索架构方案
    ├── 调用 writing-plans skill 分解为模块实现任务
    ├── 使用 Pencil MCP 绘制架构图
    └── 更新 memory/architecture.md, decisions.md, tech-stack.md
    │
    ▼
⑥ Dispatcher 分配任务：
    ├── 检查依赖 → 依赖未满足 → blocked
    └── 依赖满足 → 分配 Backend/Frontend Agent
    │
    ▼
⑦ Backend/Frontend 执行开发
    ├── backend: 读取 architecture + tech-stack + coding/api/security standards
    │   ├── 调用 tdd skill（可选）执行 RED-GREEN-REFACTOR 流程
    │   └── 调用 systematic-debugging skill 排查报错
    ├── frontend: 读取 design-system + Pencil 设计稿 + frontend-design plugin
    │   ├── 调用 tdd skill（可选）执行 RED-GREEN-REFACTOR 流程
    │   └── 调用 systematic-debugging skill 排查渲染异常
    ├── 每个 Agent 完成后：
    │   ├── 调用 verification-before-completion 验证测试/构建通过
    │   ├── 填写 task 文件 ## Result 区
    │   ├── 更新 memory/progress.md
    │   └── 如有新问题 → 追加 memory/known-issues.md
    │
    ▼
⑧ Reviewer 审查代码
    ├── 调用 requesting-code-review skill 发起审查流程
    ├── 读取 task 文件 + changed_files
    ├── 调用 code-review skill（6 阶段检查清单，定义"查什么"）
    ├── PASS → 填写 ## Review → task 进入 in-qa
    └── FAIL → 退回 tasks/backlog/，附审查意见
    │
    ▼
⑨ QA 验证
    ├── 执行 fullstack-verify 流程（运行测试 + API 检查 + 一致性验证）
    ├── PASS → task → tasks/done/ → 更新 progress.md (Done 区)
    └── FAIL → 退回 tasks/backlog/
    │
    ▼
⑩ Orchestrator 会话结束汇总
    ├── 调用 finishing-a-development-branch skill 标准化合并/PR
    ├── 移动 done 任务到 tasks/done/
    ├── 更新 memory/progress.md
    ├── 追加 decisions/known-issues（如有）
    └── 触发 session-end.sh 自动清理
```

### 2.2 Bug 修复（bug fix）

```
用户报 bug
    │
    ▼
Orchestrator 分类 → type: bug-fix (code-change)
    │
    ├── 简单 bug（≤1 文件，不改 API/schema/架构）
    │   → 直接创建 task → QA 复现 → 修复 → 审查 → QA 回归 → done
    │
    └── 复杂 bug（多模块）
        → Analyst 出修复方案 → 用户确认 → QA 复现 → 修复 → 审查 → QA 回归 → done
```

### 2.3 独立代码审查（code review）

```
用户请求 review
    │
    ▼
Orchestrator → 创建 review task (type: review-only) → tasks/backlog/
    │
    ▼
Dispatcher 分配 → Reviewer ↓
    │
    ├── PASS（无问题或仅 Minor）→ task → done
    │
    └── 发现 Critical/Major
        → 原 review task → done
        → 创建子 task (type: code-change) → tasks/backlog/ → 走完整开发管线
```

### 2.4 任务状态转换

```
code-change 类型 (feature / bug-fix / refactor):
  pending → in-progress → in-review → in-qa → done
      ↓         ↓            ↓           ↓
   blocked   开发中       审查        QA 验证
                          ↓FAIL→pending
                                      ↓FAIL→pending

review-only 类型 (review / qa):
  pending → in-review → done
      ↓         ↓
   blocked   审查
              ↓ 发现 Critical/Major → 创建子 code-change task，原 task → done
```

---

## 三、Agent 体系

### 3.1 Orchestrator（总调度）

| 属性 | 内容 |
|------|------|
| **角色** | 项目总调度中心 |
| **职责** | 需求分类、Agent 路由、任务生命周期管理、会话结束归档 |
| **核心能力** | using-superpowers, verification-before-completion, finishing-dev-branch, agent-spawn, task-manage, file-ops-read/write, git-ops |
| **可选能力** | brainstorming, writing-plans, writing-skills, subagent-driven-dev, executing-plans, dispatching-parallel, requesting-code-review, using-git-worktrees, code-search |
| **禁止项** | 不写业务代码、不出详细方案、不操作设计文件、不使用 MCP 工具 |
| **何时介入** | 每次需求摄入、每次任务状态变更、每次会话结束 |

### 3.2 Analyst（需求分析）

| 属性 | 内容 |
|------|------|
| **角色** | 需求分析与方案设计 |
| **职责** | 将模糊需求转化为结构化可执行方案 |
| **核心能力** | using-superpowers, brainstorming（9 步探索，主流程）, verification-before-completion, web-search, web-fetch, solution-design（轻量补充）, api-design, code-search |
| **可选能力** | refactor, coding-standard, api-standard, security-standard |
| **禁止项** | 不写代码、不操作文件（只读调研）、不触发执行 agent |
| **何时介入** | feature / complex-bug / refactor / architecture 需求 |

### 3.3 Architect（架构师）

| 属性 | 内容 |
|------|------|
| **角色** | 系统架构设计 |
| **职责** | 模块边界划分、技术选型、数据流设计、架构图绘制 |
| **核心能力** | using-superpowers, brainstorming, writing-plans, verification-before-completion, Pencil MCP（canvas/read/layout/export）, file-ops-write（写 memory）, coding-standard |
| **可选能力** | Pencil（screenshot/space/state）, web-search, web-fetch, writing-skills, receiving-code-review |
| **禁止项** | 不写业务代码、不参与任务分发 |
| **何时介入** | 新模块设计、技术选型、架构变更 |

### 3.4 Backend（后端开发）

| 属性 | 内容 |
|------|------|
| **角色** | 后端开发工程师 |
| **职责** | API 实现、数据库操作、Service 层业务逻辑 |
| **核心能力** | using-superpowers, systematic-debugging（优先）, verification-before-completion, shell-test, git-ops, file-ops-read/write, karpathy-guidelines, api-standard, coding-standard, security-standard |
| **可选能力** | tdd, executing-plans, requesting-code-review, receiving-code-review, api-design, testing, debugging（轻量替代）, web-fetch |
| **禁止项** | 不修改 frontend、不操作设计文件（Pencil）、不绕过 orchestrator |
| **何时介入** | 所有后端开发任务 |

### 3.5 Frontend（前端开发）

| 属性 | 内容 |
|------|------|
| **角色** | 前端开发工程师 |
| **职责** | 页面实现、组件开发、状态管理、API 对接 |
| **核心能力** | using-superpowers, systematic-debugging（优先）, verification-before-completion, frontend-design plugin, 全部 Pencil 工具（read/export/variables/guidelines/screenshot）, design-to-code (composite), shell-test, git-ops, karpathy-guidelines |
| **可选能力** | tdd, executing-plans, requesting-code-review, receiving-code-review, Pencil canvas/layout/space/properties/replace, web-fetch, testing, debugging（轻量替代） |
| **禁止项** | 不修改 backend、不操作设计文件中的架构图层 |
| **何时介入** | 所有前端开发任务 |

### 3.6 Reviewer（代码审查）

| 属性 | 内容 |
|------|------|
| **角色** | 代码质量守门人 |
| **职责** | 代码级静态分析：架构一致性、安全性、性能模式、编码规范、技术债务 |
| **核心能力** | using-superpowers, verification-before-completion, requesting-code-review, code-review（6 阶段检查清单），code-search, git-ops, file-ops-read, api/coding/security standards |
| **可选能力** | karpathy-guidelines, shell-test |
| **允许写入** | 仅限 task 文件 `## Review` 区 + memory（known-issues, progress）追加 |
| **禁止项** | 不修改业务代码、不操作设计文件、不参与任务分发 |
| **何时介入** | 所有 code-change 任务开发完成后；独立审查任务 |

### 3.7 QA（质量验证）

| 属性 | 内容 |
|------|------|
| **角色** | 质量验证工程师 |
| **职责** | 行为级动态验证：功能正确性、前后端一致性、回归风险、边界条件 |
| **核心能力** | using-superpowers, systematic-debugging（优先）, verification-before-completion, fullstack-verify (composite), shell-test, web-fetch, code-search, git-ops, api/coding/security standards |
| **可选能力** | tdd, dispatching-parallel, api-design, testing, debugging（轻量替代）, web-search |
| **允许写入** | 仅限 task 文件 `## QA Result` 区 + memory（known-issues, progress）追加 |
| **禁止项** | 不修改业务代码、不操作设计文件、不绕过 reviewer 流程 |
| **何时介入** | reviewer PASS 后的 in-qa 阶段；bug-fix 的复现和回归验证 |

### Reviewer 与 QA 的边界

| 维度 | Reviewer 查（代码级静态） | QA 查（行为级动态） |
|------|--------------------------|-------------------|
| 安全性 | 代码中有无 SQL 拼接、硬编码密钥 | 实际请求中鉴权是否生效 |
| 性能 | 代码中有无 N+1 模式、缺少分页 | 实际运行中的慢查询、内存泄漏 |
| 规范 | 命名、类型、错误处理是否符合标准 | 实际 API 响应格式是否与规范一致 |
| 功能 | 不检查 | 功能是否符合需求、边界条件 |

冲突裁决：**QA 的行为验证结果优先**（行为优先于代码模式）。

---

## 四、Superpowers 能力体系

每个 Agent 的能力通过三层结构管理：

```
superpowers/
├── registry.md          ← 全局能力目录（50+ 条目 + Agent 分配矩阵）
├── cards/{agent}.md     ← 每个 Agent 的能力配置（能用什么 + 禁止用什么）
└── bindings/            ← MCP/插件到 Agent 的映射文档和工具指南
    ├── mcp-pencil.md    ← Pencil MCP（12 工具）
    ├── plugin-frontend-design.md
    ├── plugin-karpathy-guidelines.md
    └── plugin-superpowers.md  ← Superpowers 社区插件（14 skills）
```

### 能力类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `mcp_tool` | MCP 服务器提供的工具 | Pencil (12 design tools) |
| `plugin_skill` | 插件提供的 Skill | frontend-design, karpathy-guidelines, brainstorming, tdd, systematic-debugging 等 16 个 |
| `builtin_tool` | Claude Code 内置工具 | WebSearch, Bash, Grep, Agent |
| `local_skill` | 项目本地 Skill | solution-design, code-review, testing 等 9 个 |
| `composite` | 组合能力 | design-to-code, fullstack-verify |

### 新增插件/工具的接入流程

1. 在 `bindings/` 创建映射文档（参考 `_TEMPLATE.md`）
2. 在 `registry.md` 注册新工具 + 更新 Agent 分配矩阵
3. 更新相关 Agent 的 card（添加/移除能力）
4. 更新 `context-loader.md` 的加载清单

### Superpowers 社区插件集成

框架已集成 `superpowers` 社区插件（v5.1.0, Jesse Vincent, claude-plugins-official），14 个 behavioral skills 映射到 7 个 Agent：

| Skill | 类型 | orch | analyst | architect | backend | frontend | reviewer | qa |
|-------|------|------|---------|-----------|---------|----------|----------|-----|
| using-superpowers | 元技能 | R | R | R | R | R | R | R |
| verification-before-completion | 质量 | R | R | R | R | R | R | R |
| brainstorming | 规划 | O | R | R | - | - | - | - |
| writing-plans | 规划 | O | - | R | - | - | - | - |
| systematic-debugging | 质量 | - | - | - | R | R | - | R |
| tdd | 质量 | - | - | - | O | O | - | O |
| requesting-code-review | 审查 | O | - | - | O | O | R | - |
| receiving-code-review | 审查 | - | - | O | O | O | - | - |
| finishing-dev-branch | 基础设施 | R | - | - | - | - | - | - |
| subagent-driven-dev | 执行 | O | - | - | - | - | - | - |
| executing-plans | 执行 | O | - | - | O | O | - | - |
| dispatching-parallel | 执行 | O | - | - | - | - | - | O |
| using-git-worktrees | 基础设施 | O | - | - | - | - | - | - |
| writing-skills | 元技能 | O | - | O | - | - | - | - |

> R = Required, O = Optional, - = 不适用

**与项目 Skills 的关系**：
- `brainstorming` + `writing-plans` 为主流程，项目 `solution-design` 为轻量补充
- `systematic-debugging`（4 阶段）优先于项目 `debugging`（轻量快速排查保留）
- `tdd` 定义 RED-GREEN-REFACTOR 铁律，项目 `testing` 定义测试分层和覆盖率标准
- `requesting-code-review` 定义"如何发起审查"，项目 `code-review` 定义"审查什么"（6 阶段检查清单）

---

## 五、开发留痕 —— 如何检查

### 5.1 查看当前进度

**文件**: `memory/progress.md`

包含 5 个分区：
- **Done** — 已完成的任务
- **In Progress** — 正在进行的任务
- **In Review** — 等待审查的任务
- **Blocked** — 被阻塞的任务及原因
- **Next** — 下一个待分配的 backlog 最高优先级任务

每个任务条目包含 task ID、标题、owner、状态。

### 5.2 查看单个任务全生命周期

**目录**: `tasks/`

任务按状态分布在 5 个目录中：
- `tasks/backlog/` — 待执行
- `tasks/in-progress/` — 执行中
- `tasks/in-review/` — 审查中 / QA 中
- `tasks/blocked/` — 被阻塞
- `tasks/done/` — 已完成

**任务文件结构**（每个 task 文件包含完整生命周期记录）：

```markdown
# TASK-{日期}-{序号}: {标题}

## Meta
type / owner / priority / status / depends_on / created

## Scope      ← 要做什么
## Target Files ← 涉及的文件
## Acceptance  ← 验收条件

## Result      ← 执行 Agent 填写（outcome / summary / changed_files）
## Review      ← Reviewer 填写（PASS/FAIL + 问题清单 + 严重级别）
## QA Result   ← QA 填写（PASS/FAIL + 问题清单 + 风险分析）
```

**查看方式**：
- 追踪完整执行链：`Meta.owner` → `## Result` → `## Review` → `## QA Result`
- 查看修改范围：`## Result.changed_files`
- 了解为何驳回：`## Review` 或 `## QA Result` 中的 FAIL 问题清单

### 5.3 查看已知问题和 Bug

**文件**: `memory/known-issues.md`

```markdown
### ISSUE-{序号}: {问题简述}
- 发现日期 / 发现者 / 严重级别 / 影响范围
- 描述 / 根因 / 关联任务 / 状态（Open / In Progress / Resolved）
```

### 5.4 查看会话清理记录

每次会话结束时 `hooks/session-end.sh` 自动执行：
- 将 `status: done` 的 task 移动到 `tasks/done/`
- 解除依赖满足的 blocked 任务
- 打印各目录任务分布

---

## 六、设计记录 —— 如何查看

### 6.1 查看架构设计

**文件**: `memory/architecture.md`

| 章节 | 内容 |
|------|------|
| 架构模式 | 模块化单体 / 微服务 / 分层架构 |
| 模块清单 | 每个模块的职责和依赖关系 |
| 模块边界 | frontend / backend / shared 边界定义 |
| 数据流 | Client → Controller → Service → Repository → DB |
| 通信方式 | 同步（REST）/ 异步（消息队列） |

### 6.2 查看架构决策记录 (ADR)

**文件**: `memory/decisions.md`

每条决策按 ADR 格式记录：
```markdown
### ADR-{序号}: {决策标题}
- 日期 / 决策 / 原因 / 替代方案 / 影响 / 状态（proposed / accepted / superseded）
```

### 6.3 查看技术栈选型

**文件**: `memory/tech-stack.md`

| 层级 | 内容 |
|------|------|
| Frontend | 框架、状态管理、UI 库、构建工具、类型系统 |
| Backend | 语言/运行时、框架、ORM、数据库、缓存、消息队列 |
| Infrastructure | 部署、CI/CD、容器化 |

已定项标注状态，待定项标注"待定"。

### 6.4 查看前端设计系统

**文件**: `memory/design-system.md`

| 章节 | 内容 |
|------|------|
| 设计原则 | 组件优先、状态最小化、API 驱动 UI |
| 组件清单 | 组件名、路径、类型、状态 |
| 主题 Token | 颜色、字体、间距定义 |

### 6.5 查看架构图（如有）

通过 Architect Agent 使用 Pencil MCP 绘制的架构图保存在 `.pen` 设计文件中，可通过 Pencil 工具打开、截图或导出。

### 6.6 查看 Agent 能力配置

- **全局能力目录**: `superpowers/registry.md`（50+ 条目的分配矩阵）
- **单个 Agent 能力**: `superpowers/cards/{agent}.md`（核心能力 + 辅助能力 + 禁止边界）
- **MCP/插件工具指南**: `superpowers/bindings/{name}.md`

---

## 七、关键文件速查

| 我想了解... | 查看... |
|------------|--------|
| 项目当前进度 | `memory/progress.md` |
| 系统架构设计 | `memory/architecture.md` |
| 为什么选某个技术 | `memory/decisions.md` |
| 技术栈详情 | `memory/tech-stack.md` |
| 有哪些已知 Bug | `memory/known-issues.md` |
| 某个任务谁做的、改了什么 | `tasks/done/TASK-*.md` 的 `## Result` 区 |
| 审查发现了什么问题 | 对应 task 文件的 `## Review` 区 |
| QA 验证了什么、结果如何 | 对应 task 文件的 `## QA Result` 区 |
| 任务为什么被阻塞 | `tasks/blocked/` 中 task 的 `depends_on` 和 status |
| 需求到方案的上下文 | Analyst 调用 brainstorming skill 产出的方案 |
| Backend Agent 能做什么 | `superpowers/cards/backend.md` |
| Frontend 怎么用 Pencil | `superpowers/bindings/mcp-pencil.md` (Frontend 区) |
| 社区插件有哪些 skills | `superpowers/bindings/plugin-superpowers.md` |
| 所有 Agent 的能力分配 | `superpowers/registry.md`（Agent 分配矩阵） |
| 新增一个 MCP Server | `superpowers/bindings/_TEMPLATE.md` → `superpowers/registry.md` → `cards/` → `context-loader.md` |
| 新增一个社区 Plugin | 同上流程，参考 `plugin-superpowers.md` 作为完整示例 |
