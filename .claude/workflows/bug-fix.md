# Bug Fix Workflow

用户报 bug 后的完整修复流程。

---

## 流程

```
用户报 bug
    │
    ▼
orchestrator 分类 → type: bug-fix (code-change)
    │
    ├── 简单 bug（1 文件、不改 API、不改 schema、不改架构）
    │       │
    │       ▼
    │   直接创建 TASK → tasks/backlog/
    │       │
    │       ▼
    │   qa agent 复现问题 + 定位根因
    │       │
    │       ├── 可复现 → orchestrator 分配修复 agent（backend/frontend）
    │       │
    │       └── 不可复现 → 标记 blocked，请求更多信息
    │       │
    │       ▼
    │   agent 修复 + 自测
    │       │
    │       ▼
    │   reviewer 审查修复代码
    │       │
    │       ▼
    │   qa agent 回归验证
    │       │
    │       ├── PASS → task → tasks/done/
    │       │           → 更新 memory/known-issues.md 状态为 Resolved
    │       │
    │       └── FAIL → task 退回 tasks/backlog/，标注原因
    │
    └── 复杂 bug（多模块）
            │
            ▼
        analyst 生成修复方案 → 用户确认
            │
            ▼
        orchestrator 创建 TASK 到 tasks/backlog/
            │
            ▼
        qa agent 复现问题
            │
            ├── 可复现 → 定位根因，标注影响范围
            │
            └── 不可复现 → 标记 blocked，请求更多信息
            │
            ▼
        orchestrator 分配修复 agent（backend/frontend）
            │
            ▼
        agent 修复 + 自测
            │
            ▼
        reviewer 审查修复代码
            │
            ▼
        qa agent 回归验证
            │
            ├── PASS → task → tasks/done/
            │           → 更新 memory/known-issues.md 状态为 Resolved
            │
            └── FAIL → task 退回 tasks/backlog/，标注原因
```

---

## Bug Report 模板

用户报 bug 时，orchestrator 在 task 文件中自动填入：

```markdown
## Bug Report
- **现象**: {用户描述}
- **复现步骤**: {如有}
- **期望行为**: {用户期望}
- **实际行为**: {当前表现}
- **环境**: {版本/浏览器/系统}
```

## 修复规则

1. 先定位根因，再写修复（禁止猜测式修复）
2. 最小改动原则（只修复 bug，不顺手重构）
3. 必须补充测试（覆盖该 bug 场景）
4. 必须检查同类问题（是否有相同根因的其他 bug）

## 自动回写

| 阶段 | 写入目标 | 写入内容 |
|------|---------|---------|
| 方案（复杂） | 无（analyst 只输出不写文件） | — |
| 复现 | task 文件 | 复现结果、根因分析 |
| 修复 | task 文件 + memory/progress.md | 修复方案、changed_files |
| 审查 | task 文件 | review 结论 |
| 回归 | task 文件 + memory/known-issues.md | 回归结果、问题状态更新 |
| 完成 | memory/progress.md | 更新进度 |
