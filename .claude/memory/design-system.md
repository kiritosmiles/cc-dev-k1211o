# Design System

前端设计系统。由 frontend agent 自动维护。

---

## 设计原则

- 组件优先（UI 拆分为可复用组件）
- 最小全局状态（状态局部优先）
- API 驱动 UI（数据结构以后端为准）
- UI 与业务逻辑分离

## 组件清单

<!-- frontend agent 每次新增组件时追加 -->

| 组件名 | 路径 | 类型 | 状态 |
|--------|------|------|------|
| {暂无} | — | — | — |

## 主题

<!-- frontend agent 在项目初始化时填写 -->

| Token | 值 | 说明 |
|-------|-----|------|
| color-primary | 待定 | 主色 |
| color-secondary | 待定 | 辅色 |
| color-background | 待定 | 背景色 |
| font-family | 待定 | 字体 |
| spacing-unit | 待定 | 基础间距 |

## 组件规范

- 组件命名: PascalCase
- 文件命名: kebab-case
- 一个组件一个文件
- 组件必须支持 loading / error / empty 状态

## 目录结构

```
frontend/
├── pages/        # 页面级组件
├── components/   # 通用组件
├── modules/      # 业务模块组件
├── services/     # API 调用层
├── hooks/        # 自定义 hooks
├── store/        # 全局状态
├── utils/        # 工具函数
```

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| frontend | 每次新增/修改组件时更新 |
