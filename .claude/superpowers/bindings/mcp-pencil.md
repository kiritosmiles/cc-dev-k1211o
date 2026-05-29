# Pencil MCP Binding

将 Pencil 设计工具的 12 个 MCP 工具映射到 agent 角色。

---

## 基本信息

| 字段 | 值 |
|------|-----|
| **名称** | Pencil Design Tools |
| **类型** | mcp_server |
| **提供方** | pencil-mcp |
| **工具数量** | 12 |

---

## 工具列表

| 工具名 | 功能 | 注册表 ID |
|--------|------|-----------|
| `mcp__pencil__open_document` | 打开 .pen 设计文件 | `pencil-open` |
| `mcp__pencil__get_editor_state` | 获取当前编辑器状态 | `pencil-state` |
| `mcp__pencil__batch_get` | 批量读取设计节点 | `pencil-read` |
| `mcp__pencil__batch_design` | 批量创建/编辑设计节点 | `pencil-canvas` |
| `mcp__pencil__snapshot_layout` | 分析布局结构 | `pencil-layout` |
| `mcp__pencil__get_screenshot` | 截取设计预览（开销大） | `pencil-screenshot` |
| `mcp__pencil__export_nodes` | 导出图片/PDF | `pencil-export` |
| `mcp__pencil__get_variables` | 读取设计变量和主题 | `pencil-variables` |
| `mcp__pencil__set_variables` | 设置设计变量和主题 | `pencil-variables` |
| `mcp__pencil__get_guidelines` | 加载设计指南和风格 | `pencil-guidelines` |
| `mcp__pencil__find_empty_space_on_canvas` | 查找画布空白区域 | `pencil-space` |
| `mcp__pencil__search_all_unique_properties` | 搜索唯一属性值 | `pencil-properties` |
| `mcp__pencil__replace_all_matching_properties` | 批量替换属性 | `pencil-replace` |

---

## Agent 绑定

| Agent | 绑定工具 | 使用场景 | 优先级 |
|-------|---------|---------|--------|
| **architect** | pencil-open, pencil-read, pencil-canvas, pencil-layout, pencil-export | 绘制系统架构图、模块关系图、数据流图；导出架构图供方案文档使用 | required |
| **architect** | pencil-state, pencil-screenshot, pencil-space | 获取编辑器上下文；生成架构图预览；查找空白区域新增模块 | optional |
| **frontend** | pencil-open, pencil-read, pencil-export, pencil-screenshot, pencil-variables, pencil-guidelines | 从设计稿读取组件规范；提取设计 token；导出设计稿截图作为开发参考；验证前端实现与设计稿一致性 | required |
| **frontend** | pencil-canvas, pencil-layout, pencil-state, pencil-space, pencil-properties, pencil-replace | 在设计稿中标注组件边界和交互说明；检查响应式断点；增量开发查找空白区域；提取设计 token；批量替换属性 | optional |

---

## 使用约束

- **禁止 agent**: orchestrator, analyst, backend, reviewer, qa — 这些 agent 不操作设计文件
- **前提条件**: 需要 .pen 文件存在于项目中
- **调用频率**: `pencil-screenshot` 开销大，每个设计阶段仅截取 1-2 次用于验证

---

## 典型工作流

### Architect: 架构设计可视化

```
architect 收到架构设计任务
  → open_document("designs/architecture.pen")
  → batch_design(创建系统架构图节点)
  → snapshot_layout(验证布局无重叠)
  → get_screenshot(输出架构图预览)
  → export_nodes(导出为 PNG 供方案文档引用)
```

### Frontend: 设计稿转代码

```
frontend 收到页面开发任务
  → open_document("designs/app.pen")
  → batch_get(读取目标页面组件树)
  → get_variables(提取设计 token: 颜色、间距、字体)
  → export_nodes(导出组件截图作为开发参考)
  → 结合 frontend-design plugin 生成代码
  → get_screenshot(验证实现效果)
```

---

## 维护者

| 角色 | 触发条件 |
|------|---------|
| architect | Pencil 版本升级或新增工具时更新 |
| frontend | 发现新的设计到代码工作流时补充 |
