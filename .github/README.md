# .claude — 多智能体开发框架

将 Claude Code 从"AI 写代码"升级为 **7 角色协作的软件工程管线**——需求分析 → 方案设计 → 架构规划 → 编码实现 → 代码审查 → 质量验证 → 归档。

---

## 解决的痛点

| 痛点 | 裸 Claude Code | 使用 .claude 框架后 |
|------|---------------|-------------------|
| **需求直接变代码** | 用户说"做个登录"，AI 直接写，缺边界条件、缺错误处理 | Analyst 先出结构化方案，用户确认后才执行 |
| **架构随写随崩** | 没有模块边界约束，Agent 跨模块随意修改 | Architect 定义边界，Reviewer 检查一致性，越界即驳回 |
| **Bug 反复横跳** | 改了 A 坏了 B，没有回归验证 | QA 执行 fullstack-verify，逐项打勾 Acceptance checklist |
| **代码质量全靠自觉** | 安全漏洞、N+1 查询、硬编码密钥没人管 | Reviewer 6 阶段检查 + QA 行为验证，双重门禁 |
| **项目状态是个黑盒** | 不知道做到哪了、谁在做什么、为什么这样设计 | Memory 系统 + Task 看板 + ADR 决策记录，全生命周期可追溯 |
| **Agent 能力边界模糊** | Agent 能做什么、不能做什么全靠猜 | Superpowers 框架：每 Agent 一张能力卡，R/O/S/- 明确标注 |
| **新环境配置繁琐** | 每次换项目要重新告诉 AI 规则和偏好 | 一个 `.claude` 目录即插即用，clone 即生效 |

---

## 亮点总结

### 流程亮点
- **方案先行**：写代码前必须出方案，经用户确认才执行——杜绝"猜你要什么直接写"
- **7 角色管线**：Orchestrator → Analyst → Architect → Backend/Frontend → Reviewer → QA → Done
- **任务全生命周期追踪**：每个 task 文件包含 Scope → Result → Review → QA Result 完整链路
- **Bug 修复也走管线**：复现 → 修复 → 审查 → 回归验证，不跳步

### 技术亮点
- **Superpowers 能力体系**：Registry（全局目录）+ Cards（角色配置）+ Bindings（集成文档）三层架构
- **50+ 能力条目**：覆盖 MCP 工具、社区插件、内置工具、本地 Skill、组合能力
- **集成 superpowers 社区插件**：14 个 behavioral skills（brainstorming、TDD、systematic-debugging 等）
- **Convention-over-enforcement**：Agent 自约束，无需平台级权限控制
- **Memory 是唯一事实来源**：架构、决策、进度、已知问题全部落盘，永不丢失上下文

### 质量亮点
- **Reviewer + QA 双重门禁**：Reviewer 查代码级静态问题，QA 查行为级动态问题，冲突时 QA 优先
- **完成门禁强制验证**：`verification-before-completion` 禁止任何 Agent 未验证就声称完成
- **systematic-debugging 优先**：4 阶段调试流程（根因→模式→假设→修复），禁止无根因就写修复

---

## 快速开始

### 1. 前置条件

- 安装 [Claude Code](https://claude.ai/code) CLI
- Git（用于任务版本管理）
- Bash（Windows 下推荐 Git Bash）

### 2. 在新项目中使用

```bash
# 将 .claude 目录复制到你的项目根目录
cp -r /path/to/.claude /your-project/

# 或在项目中创建 submodule（推荐，可跟随框架更新）
cd /your-project
git submodule add <repo-url> .claude
```

> `.claude` 目录放在项目根目录，Claude Code 启动时自动加载其中的 `CLAUDE.md` 和 `settings.json`。

### 3. 插件安装（可选，推荐）

框架的 Superpowers 体系依赖两个社区插件：

```bash
# 在 Claude Code 中执行
/plugin install anthropic-official/frontend-design
/plugin install anthropic-official/karpathy-guidelines
/plugin install claude-plugins-official/superpowers
```

> 不安装插件也能使用框架的核心流程，但 Agent 的能力集会受限。详见 `superpowers/registry.md` 中标记 `provided_by: superpowers-plugin` 的条目。

### 4. 验证安装

在项目目录启动 Claude Code，输入：

```text
这是一个新项目，我想了解当前的状态。
```

Orchestrator Agent 应自动加载 `memory/progress.md` 并汇报当前状态。如果看到类似以下输出说明框架正常工作：

```text
当前项目状态：
- 无进行中任务
- 无阻塞任务
- 待办任务：0
- memory/ 文件已就绪
```

---

## 配置说明

### 必须配置

| 文件 | 作用 | 配置内容 |
|------|------|---------|
| `CLAUDE.md` | 项目宪法 | 核心原则、架构约束、开发规则、质量规则 |
| `settings.json` | 权限控制 | Agent 可用的 Bash 命令、允许/禁止的工具 |

### 需要初始化的 Memory 文件

首次使用时，需要根据你的项目填充以下文件：

| 文件 | 内容 |
|------|------|
| `memory/project-context.md` | 项目背景、业务领域、核心模块清单 |
| `memory/architecture.md` | 系统架构（模块化单体/微服务）、模块边界、数据流 |
| `memory/tech-stack.md` | 前端框架、后端语言/框架、数据库、缓存、部署方式 |
| `memory/design-system.md` | 前端设计 token（颜色、字体、间距）、组件清单 |
| `memory/decisions.md` | 架构决策记录（ADR），初始为空 |
| `memory/known-issues.md` | 已知 Bug 列表，初始为空 |
| `memory/progress.md` | 项目进度快照，初始为空 |

> 建议先让 Analyst Agent 帮你分析项目并填充这些文件：
> ```text
> 分析当前项目的技术栈和架构，写入 memory/ 目录
> ```

### settings.json 关键配置

```json
{
  "permissions": {
    "allow": [
      "Read", "Glob", "Grep", "Edit", "Write",
      "Bash(git:*)", "Bash(npm:*)", "Bash(pnpm:*)",
      "WebSearch", "WebFetch", "Agent(*)"
    ],
    "defaultMode": "default"
  },
  "hooks": {
    "Stop": [{
      "matcher": "*",
      "hooks": [{
        "type": "command",
        "command": "bash /absolute/path/to/.claude/hooks/session-end.sh"
      }]
    }]
  }
}
```

> **注意**：hook 路径必须使用绝对路径，否则 Stop hook 触发时可能找不到脚本。

---

## 工作流程

### 新功能开发（完整管线）

```
用户描述需求
    │
    ▼
① Orchestrator 分类 → type: feature
    │
    ▼
② Analyst 出方案
    ├── brainstorming (9 步结构化探索)
    ├── solution-design (轻量方案补充)
    ├── WebSearch/WebFetch (技术调研)
    └── 返回结构化方案
    │
    ▼
③ 用户确认方案（可修改/驳回）
    │
    ▼
④ Architect 设计架构
    ├── writing-plans (任务分解)
    └── Pencil MCP (架构图)
    │
    ▼
⑤ Backend / Frontend 并行开发
    ├── systematic-debugging (调试)
    ├── tdd (可选，测试先行)
    └── verification-before-completion (验证门禁)
    │
    ▼
⑥ Reviewer 代码审查
    ├── code-review (6 阶段检查清单)
    └── PASS → in-qa / FAIL → 退回
    │
    ▼
⑦ QA 质量验证
    ├── fullstack-verify (端到端)
    └── PASS → done / FAIL → 退回
    │
    ▼
⑧ Orchestrator 归档
    └── finishing-a-development-branch
```

### Bug 修复（简化管线）

```
简单 bug (≤1 文件)    → QA 复现 → 修复 → 审查 → QA 回归 → done
复杂 bug (多模块)      → Analyst 方案 → 同上
```

### 独立代码审查

```
请求 review → Reviewer 审查 → PASS → done
                            └── 发现问题 → 创建子 task → 走完整管线
```

---

## 使用示例

### 示例 1：开发一个新功能

```text
# 用户输入
我需要一个用户登录功能，支持邮箱+密码登录，以及 Google OAuth 登录。

# Orchestrator 分类后路由到 Analyst，Analyst 输出方案：
---
## 登录功能方案
### 功能范围
- 邮箱+密码登录（含注册、密码重置）
- Google OAuth 登录（含账号绑定）
- Session 管理（JWT + refresh token）

### API 设计
POST /api/auth/register     # 邮箱注册
POST /api/auth/login         # 邮箱登录
POST /api/auth/oauth/google  # Google OAuth
POST /api/auth/refresh       # 刷新 token
POST /api/auth/logout        # 登出

### 安全考虑
- 密码 bcrypt 哈希，强度 12
- JWT 有效期 15min，refresh token 7d
- OAuth state 参数防 CSRF
- 登录限流 5次/分钟/IP

### 前端页面
- /login — 登录页（邮箱 + OAuth 按钮）
- /register — 注册页
- /forgot-password — 密码重置

请确认方案，或提出修改意见。
---

# 用户确认后，Orchestrator 创建 task，Architect 设计模块，Backend/Frontend 并行开发
```

### 示例 2：修复一个 Bug

```text
# 用户输入
用户反馈：上传头像后刷新页面，头像又变回默认头像。

# Orchestrator 判断为简单 bug，直接创建 task → QA 复现
# QA 返回：
---
## QA Result: FAIL (reproduced)
- 上传头像 API 返回 200，文件保存成功
- 但 GET /api/user/profile 返回的 avatar_url 仍是旧值
- 根因假设：上传后未更新 users 表的 avatar_url 字段
---

# Backend 接手，systematic-debugging 定位：
# 发现 UserService.updateAvatar() 中 SQL UPDATE 遗漏了 avatar_url 列
# → 修复 → Reviewer 审查 → QA 回归 → PASS → done
```

### 示例 3：请求代码审查

```text
# 用户输入
审查最近的提交。

# Reviewer 输出：
---
## Review Result: FAIL

### Critical
- 硬编码 JWT secret 在 config.ts:23 — 必须移入环境变量 @ src/config.ts:23

### Major
- GET /api/users 缺少分页，10000 用户会 OOM @ src/controllers/user.ts:45
- 密码比较未使用 timing-safe 比较 @ src/services/auth.ts:67

### Minor
- 变量命名 userId 与 userID 混用，建议统一 @ src/services/user.ts:12-34

### Summary
3 个问题需要修复后重新审查。Critical 问题为安全风险，必须立即修复。
---

# 用户修复后，重新审查 → PASS
```

---

## 目录结构

```
.claude/
├── README.md                  # 本文件 — 新用户入门指南
├── CLAUDE.md                  # 项目宪法 — 核心原则 + 架构约束 + 质量规则
├── FRAMEWORK.md               # 完整框架文档 — 流程、Agent、Superpowers、留痕
├── settings.json              # 权限配置 + hooks
│
├── agents/                    # 7 个 Agent 角色定义
│   ├── orchestrator.md        # 总调度：分类、路由、归档
│   ├── analyst.md             # 需求分析：方案设计（只读调研，不写代码）
│   ├── architecture.md        # 架构设计：模块边界、技术选型、架构图
│   ├── backend.md             # 后端开发：API、Service、Repository
│   ├── frontend.md            # 前端开发：页面、组件、状态管理
│   ├── reviewer.md            # 代码审查：静态分析、安全检查
│   └── qa.md                  # 质量验证：动态验证、回归测试
│
├── routing/                   # 路由与调度
│   ├── intent-router.md       # 需求 → Agent 分类
│   ├── context-loader.md      # 每个 Agent 启动时加载的上下文
│   └── task-dispatcher.md     # 任务状态机 + 分发规则
│
├── superpowers/               # 能力体系
│   ├── registry.md            # 全局能力目录（50+ 条目 + 分配矩阵）
│   ├── cards/{agent}.md       # 每个 Agent 的能力卡（能用什么 + 禁止什么）
│   └── bindings/              # MCP/插件绑定文档
│       ├── mcp-pencil.md
│       ├── plugin-frontend-design.md
│       ├── plugin-karpathy-guidelines.md
│       └── plugin-superpowers.md
│
├── skills/                    # 技能库
│   ├── design/                # 方案设计模板
│   ├── coding/                # 编码方法论（api-design, testing, debugging, code-review, refactor）
│   └── standards/             # 规范标准（api, coding, security）
│
├── workflows/                 # 工作流定义
│   ├── feature-development.md
│   ├── bug-fix.md
│   └── code-review.md
│
├── memory/                    # 记忆系统（持久化知识库）
│   ├── project-context.md     # 项目背景 + 核心模块
│   ├── architecture.md        # 系统架构 + 模块边界
│   ├── tech-stack.md          # 技术栈选型
│   ├── decisions.md           # 架构决策记录 (ADR)
│   ├── design-system.md       # 前端设计系统
│   ├── known-issues.md        # 已知 Bug 记录
│   └── progress.md            # 项目进度快照
│
├── tasks/                     # 任务看板
│   ├── backlog/               # 待执行
│   ├── in-progress/           # 执行中
│   ├── in-review/             # 审查/QA 中
│   ├── blocked/               # 被阻塞
│   └── done/                  # 已完成
│
└── hooks/                     # 生命周期钩子
    └── session-end.sh         # 会话结束自动清理
```

---

## 7 个 Agent 速查

| Agent | 一句话职责 | 典型输入 | 典型输出 |
|-------|----------|---------|---------|
| **Orchestrator** | 总调度中心 | 用户需求 | 分类 + 路由 + 归档 |
| **Analyst** | 需求分析 | 模糊需求 | 结构化方案（不写代码） |
| **Architect** | 架构设计 | 方案 | 模块边界 + 技术选型 + 架构图 |
| **Backend** | 后端开发 | API 设计 | 可运行的 API 代码 |
| **Frontend** | 前端开发 | 设计稿 + API | 可交互的页面 |
| **Reviewer** | 代码审查 | 代码 diff | PASS/FAIL + 问题清单 |
| **QA** | 质量验证 | 已完成的功能 | PASS/FAIL + 风险分析 |

---

## 常见问题

### Q: 必须在 Claude Code 中使用吗？

A: 框架设计目标是 Claude Code，但核心思路（方案先行、职责分离、Memory 做事实来源）适用于任何 AI 编码助手。其他平台需要适配 agent 分发机制（Claude Code 的 Agent 工具目前是独有功能）。

### Q: 小项目需要完整的 7 Agent 流程吗？

A: 不需要。框架支持按复杂度调整：
- **简单改动**（改一个配置、修一个 typo）→ 直接改，不走管线
- **单文件 bug** → 直接 QA 复现 → 修复 → 审查 → 回归（跳过 Analyst）
- **新功能** → 完整 7 Agent 管线

### Q: 如何添加新的 MCP 工具或插件？

A: 参考 `superpowers/bindings/_TEMPLATE.md` 模板：
1. 创建 binding 文档
2. 在 `registry.md` 注册
3. 更新相关 Agent card
4. 更新 `context-loader.md`

### Q: Memory 文件需要手动维护吗？

A: 大部分由 Agent 自动更新。你只需要首次初始化 `project-context.md`、`architecture.md`、`tech-stack.md`。之后的 `progress.md`、`decisions.md`、`known-issues.md` 由 Orchestrator 在会话中自动维护。

### Q: Reviewer 和 QA 有什么区别？

A: Reviewer 检查**代码写成什么样**（SQL 注入、N+1、命名规范），QA 检查**系统跑起来对不对**（API 返回正确吗、前端渲染正常吗、回归了吗）。两者检查维度互补，冲突时 QA 的行为验证结果优先。
