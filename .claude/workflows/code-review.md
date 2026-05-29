# Code Review Workflow

独立代码审查流程（不与 feature development 绑定的审查场景）。

---

## 触发条件

- 用户主动请求："review 一下 XX 模块"
- PR 合并前审查
- 定期代码质量检查
- 架构合规检查

---

## 流程

```
用户请求 review
    │
    ▼
orchestrator 创建 review task（type: review）→ tasks/backlog/ → dispatcher 分配 → tasks/in-review/
    │
    ▼
reviewer agent 执行审查
    │
    ├── 读取目标文件
    ├── 读取 architecture.md / coding-standard.md / security-standard.md
    ├── 调用 skills/coding/code-review.md
    └── 输出审查报告
    │
    ▼
审查报告写入 task 文件
    │
    ▼
    有 Critical/Major → 原 review task → tasks/done/
                       → 创建子 task（type: code-change）到 tasks/backlog/，标记为修复任务，走 code-change 状态机
    无问题 → task → tasks/done/
```

---

## 审查维度

| 维度 | 检查内容 |
|------|---------|
| 架构 | 模块边界是否被破坏、依赖方向是否正确 |
| 安全 | SQL注入、XSS、敏感信息暴露、权限校验 |
| 性能 | N+1、重复请求、内存泄漏、不必要渲染 |
| 质量 | 重复代码、超长函数、深层嵌套、魔法值 |
| 规范 | 命名、错误处理、日志、类型安全 |
| 测试 | 测试覆盖是否充分、边界条件是否覆盖 |

---

## 审查报告格式

```markdown
## Review Report

### Scope
- 审查文件: {文件列表}
- 审查类型: {PR review / 定期检查 / 架构合规}

### Findings

#### Critical (必须修复)
- {问题} @ {文件:行号} — {修复建议}

#### Major (应该修复)
- {问题} @ {文件:行号} — {修复建议}

#### Minor (建议优化)
- {建议} @ {文件:行号}

### Tech Debt Identified
- {技术债务描述}

### Summary
- 审查文件数: N
- Critical: N / Major: N / Minor: N
- 总体评级: A/B/C/D/F
```

---

## 自动回写

| 写入目标 | 写入内容 |
|---------|---------|
| task 文件 | 完整审查报告 |
| `memory/known-issues.md` | 发现的技术债务 |
| `memory/progress.md` | 审查完成 |
