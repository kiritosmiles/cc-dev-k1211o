# Superpowers Plugin Binding

将 `superpowers` 插件（v5.1.0, Jesse Vincent, claude-plugins-official）的 14 个 behavioral skills 映射到 agent 角色。

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **名称** | Superpowers Plugin |
| **类型** | plugin_skill |
| **提供方** | claude-plugins-official (Jesse Vincent) |
| **版本** | 5.1.0 |
| **技能数量** | 14 |
| **安装路径** | `C:\Users\Windows\.claude\plugins\cache\claude-plugins-official\superpowers\5.1.0\` |

---

## 技能列表

| 技能名 | 功能 | 注册表 ID | 类型 |
|--------|------|-----------|------|
| using-superpowers | 技能系统引导，会话开始时强制执行技能发现 | `using-superpowers` | 元技能 |
| writing-skills | TDD 方法创建和编辑技能文件 | `writing-skills` | 元技能 |
| brainstorming | 9 步结构化需求探索和方案设计 | `brainstorming` | 规划 |
| writing-plans | 将方案分解为 2-5 分钟的可执行任务 | `writing-plans` | 规划 |
| subagent-driven-development | 大规模并行子代理执行开发计划（每 task 独立子代理 + 双审查） | `subagent-driven-dev` | 执行 |
| executing-plans | 无子代理环境下的顺序执行计划 | `executing-plans` | 执行 |
| dispatching-parallel-agents | 并行调度独立子任务及结果归并 | `dispatching-parallel` | 执行 |
| test-driven-development | RED-GREEN-REFACTOR 铁律，禁止无测试写代码 | `tdd` | 质量 |
| verification-before-completion | 完成门禁，禁止未验证就声称完成 | `verification-before-completion` | 质量 |
| systematic-debugging | 4 阶段系统化调试（根因调查→模式分析→假设验证→实现修复） | `systematic-debugging` | 质量 |
| requesting-code-review | 通过子代理发起代码审查（含审查提示模板） | `requesting-code-review` | 审查 |
| receiving-code-review | 规范审查反馈处理流程（禁止敷衍同意） | `receiving-code-review` | 审查 |
| using-git-worktrees | 创建隔离工作区执行开发任务 | `using-git-worktrees` | 基础设施 |
| finishing-a-development-branch | 开发完成后的合并/PR/清理标准化流程 | `finishing-dev-branch` | 基础设施 |

---

## Agent 绑定

### Orchestrator

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| verification-before-completion | 任务完成前的验证门禁 | required |
| finishing-a-development-branch | 所有开发任务完成后的合并/清理 | required |
| brainstorming | 复杂需求的方案探索（替代直接分发） | optional |
| writing-plans | 将确认后的方案分解为执行计划 | optional |
| writing-skills | 自定义或扩展框架 skill | optional |
| subagent-driven-development | 大规模并行任务执行 | optional |
| executing-plans | 无子代理环境下的顺序执行 | optional |
| dispatching-parallel-agents | 多个独立任务并行调度 | optional |
| requesting-code-review | 发起代码审查 | optional |
| using-git-worktrees | 创建隔离工作区 | optional |

### Analyst

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| brainstorming | 9 步结构化需求探索，替代/增强 solution-design | required |
| verification-before-completion | 方案交付前验证完整性 | required |

### Architect

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| brainstorming | 架构方案探索和设计讨论 | required |
| writing-plans | 将架构方案分解为模块实现任务 | required |
| verification-before-completion | 架构设计交付前验证 | required |
| writing-skills | 扩展框架设计能力 | optional |
| receiving-code-review | 接收架构设计审查反馈 | optional |

### Backend

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| systematic-debugging | 系统化排查后端报错（优先于项目 debugging skill） | required |
| verification-before-completion | 代码提交前验证测试通过 | required |
| test-driven-development | TDD 方法论，编写测试先于实现 | optional |
| executing-plans | 顺序执行已分解的后端任务 | optional |
| requesting-code-review | 实现完成后主动发起审查 | optional |
| receiving-code-review | 规范处理审查反馈 | optional |

### Frontend

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| systematic-debugging | 系统化排查 UI 渲染异常（优先于项目 debugging skill） | required |
| verification-before-completion | 组件完成前验证构建/测试 | required |
| test-driven-development | TDD 方法论，编写测试先于组件实现 | optional |
| executing-plans | 顺序执行已分解的前端任务 | optional |
| requesting-code-review | 组件完成后主动发起审查 | optional |
| receiving-code-review | 规范处理审查反馈 | optional |

### Reviewer

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| verification-before-completion | 审查结论交付前验证 | required |
| requesting-code-review | 作为审查者发起子代理审查流程 | required |
| receiving-code-review | 接收其他角色的设计/方案审查反馈 | optional |

### QA

| 绑定技能 | 使用场景 | 优先级 |
|---------|---------|--------|
| using-superpowers | 会话启动引导 | required |
| systematic-debugging | bug 复现和根因定位（优先于项目 debugging skill） | required |
| verification-before-completion | QA 结论交付前验证 | required |
| test-driven-development | 编写测试用例覆盖边界条件 | optional |
| dispatching-parallel-agents | 并行执行独立测试/验证任务 | optional |

---

## 与项目 Skills 的关系

| 插件 Skill | 对应项目 Skill | 关系 |
|-----------|---------------|------|
| brainstorming + writing-plans | solution-design | 插件提供更严格的 9 步探索 + 任务分解流程，项目 skill 保留作为轻量模板 |
| systematic-debugging | debugging | 插件优先（4 阶段流程更完整），项目 skill 保留作为快速排查的轻量替代 |
| test-driven-development | testing | 互补：插件定义 TDD 方法论（RED-GREEN-REFACTOR 铁律），项目 skill 定义测试分层和覆盖率标准 |
| requesting-code-review | code-review | 互补：插件定义"如何发起审查"，项目 skill 定义"审查什么"（6 阶段检查清单） |

---

## 使用约束

- **不适用 subagent 的场景**: `executing-plans` 替代 `subagent-driven-development`（Codex、Copilot、Gemini 等环境）
- **禁止 agent**: 无——所有 agent 均至少绑定 `using-superpowers` + `verification-before-completion`
- **调用时机**: `using-superpowers` 在会话开始时由 SessionStart hook 自动注入，agent 无需手动调用
- **模型选择**: `subagent-driven-development` 中机械性任务用 cheap model，集成任务用 standard model，架构决策用 most capable

---

## 典型工作流

```text
需求摄入 → orchestrator 调用 brainstorming（探索）→ analyst 产出方案
  → 用户确认 → orchestrator 调用 writing-plans（分解任务）
  → orchestrator 调用 using-git-worktrees（隔离工作区）
  → orchestrator 调用 subagent-driven-development（并行执行）
    → backend/frontend 每 task 调用 tdd → requesting-code-review
  → orchestrator 调用 finishing-a-development-branch（合并/PR）
```

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| orchestrator | 新增/升级社区 plugin 时评估集成 |
| architect | 评估 plugin skill 与现有 local_skill 的重叠和取舍 |
