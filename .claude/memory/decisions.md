# Architecture Decision Records

架构决策记录。由 architect agent 和 orchestrator 自动追加。

---

## 记录格式

每条决策按以下结构：

```markdown
### ADR-{序号}: {决策标题}
- **日期**: YYYY-MM-DD
- **决策**: 做了什么决定
- **原因**: 为什么这样决定
- **替代方案**: 考虑过的其他方案
- **影响**: 影响哪些模块
- **状态**: proposed / accepted / superseded
```

---

## 决策列表

### ADR-001: 使用 PostgreSQL
- **日期**: 2026-05-14
- **决策**: 使用 PostgreSQL 作为数据库
- **原因**: 支持复杂查询、事务完整、生态成熟
- **替代方案**: MySQL, MongoDB
- **影响**: 后续 ORM 使用 SQLAlchemy
- **状态**: accepted

<!-- 新决策追加在此行之上 -->

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | 技术选型、架构变更时 |
| orchestrator | 会话结束汇总时（如有新决策） |
