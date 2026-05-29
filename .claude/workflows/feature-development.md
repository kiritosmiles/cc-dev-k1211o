# Feature Development Workflow

新功能开发的完整流程。

---

## 流程

```
用户输入需求
    │
    ▼
① Orchestrator 分类 + 路由到 Analyst
    │
    ▼
② Analyst 读取上下文 → 生成方案 → 呈现给用户
    │
    ▼
③ 用户确认方案
    │
    ├── 确认 → 继续
    ├── 修改 → 回到②
    └── 驳回 → 结束
    │
    ▼
④ Orchestrator 写入 task 文件到 tasks/backlog/
    │
    ▼
⑤ Architect 设计模块边界（如需要）
    │
    ▼
⑥ Routing 加载上下文 → 分配 Agent
    │
    ▼
⑦ Backend/Frontend 执行开发
    │
    ▼
⑧ Agent 完成后 → 写入 Result 到 task 文件 + 更新 memory/progress.md
    │
    ▼
⑨ Reviewer 审查代码
    │
    ├── PASS → task → in-qa
    └── FAIL → task 退回 tasks/backlog/，附审查意见
    │
    ▼
⑩ QA 验证
    │
    ├── PASS → task → tasks/done/
    └── FAIL → task 退回 tasks/backlog/
    │
    ▼
⑪ Orchestrator 更新：
    - memory/progress.md（任务移到 Done）
    - memory/decisions.md（如有架构决策）
    - memory/known-issues.md（如有新问题）
```

---

## 关键规则

1. **方案必须先确认再写入** — 用户确认前不创建任何文件
2. **方案由 analyst 生成** — 模板见 skills/design/solution-design.md
3. **执行过程中发现需要变更方案** — 暂停执行，向用户报告变更内容，等待确认

---

## 方案模板（Analyst 使用）

详见 skills/design/solution-design.md。

核心结构：
- 需求分析（用户目标、背景、需求拆解）
- 技术方案（整体思路、模块设计、数据模型、API 草案、前端组件）
- 任务拆分（owner、优先级、依赖图）
- 边界条件 + 风险清单 + 验收条件 + 待确认项
