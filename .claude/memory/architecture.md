# Architecture

由 architect agent 自动维护。记录系统架构决策和模块设计。

---

## 架构模式
<!-- 整体架构：模块化单体 / 微服务 / 分层架构 -->
{待 architect 初始化}

## 模块清单

| 模块 | 职责 | 依赖 |
|------|------|------|
| auth | 认证与授权 | 无 |

<!-- architect 每次设计新模块时追加 -->

## 模块边界

```
frontend/   ← UI 层，不包含业务逻辑
backend/    ← API + Service + Repository
shared/     ← 共享类型/常量
```

<!-- architect 维护边界定义 -->

## 数据流

```
Client → Controller → Service → Repository → DB
              ↓
           Response ← Controller
```

<!-- architect 在涉及数据流变更时更新 -->

## 通信方式

- 同步: REST API
- 异步: {待 architect 填写，如 RabbitMQ/Redis}

---

## 维护者

| 角色 | 负责字段 |
|------|---------|
| architect | 全部字段 |
| backend | 数据流（实现层） |
| frontend | 模块边界（前端部分） |
