# Task Dispatcher

任务自动分发规则。orchestrator 创建任务后，由 dispatcher 决定何时分配、如何分配。

---

## 一、任务类型

每个任务在创建时必须指定类型，类型决定状态机流转路径：

| 类型 | 说明 | 示例 | 状态机 |
|------|------|------|--------|
| `feature` | 新功能开发 | 新增登录、添加搜索 | code-change |
| `bug-fix` | Bug 修复 | 修复报错、修正逻辑 | code-change |
| `refactor` | 重构 | 优化代码结构 | code-change |
| `review` | 独立审查 | PR review、架构审查 | review-only |
| `qa` | 独立验证 | 手动回归测试 | review-only |

---

## 二、状态机

### 2.1 code-change 类型（feature / bug-fix / refactor）

```
pending (tasks/backlog/)
    │
    ▼ (dispatcher 分配 agent)
in-progress (tasks/in-progress/)
    │
    ▼ (agent 完成开发)
in-review (tasks/in-review/)
    │
    ├── reviewer PASS ──► in-qa (保持在 tasks/in-review/)
    │
    └── reviewer FAIL ──► 退回 tasks/backlog/，重置 status: pending，附审查意见
    │
    ▼ (reviewer PASS 后触发)
in-qa (保持在 tasks/in-review/)
    │
    ├── qa PASS ──► done (tasks/done/)
    │
    └── qa FAIL ──► 退回 tasks/backlog/，重置 status: pending，附 QA 意见
```

### 2.2 review-only 类型（review / qa）

```
pending (tasks/backlog/)
    │
    ▼ (dispatcher 分配 reviewer/qa agent)
in-review (tasks/in-review/)
    │
    ├── PASS / 无问题 ──► done (tasks/done/)
    │
    ├── 发现 Critical/Major ──► 原 task 移入 done/
    │                           同时创建子 task (type: code-change) 到 tasks/backlog/
    │                           子 task 走 code-change 状态机
    │
    └── 需要更多信息 ──► blocked (tasks/blocked/)
```

### 2.3 blocked 状态（所有类型通用）

```
blocked (tasks/blocked/)
    │
    ▼ (阻塞解除)
pending (tasks/backlog/)
```

---

## 三、状态迁移规则

### code-change 类型

| 当前状态 | 触发事件 | 新状态 | 目录迁移 |
|---------|---------|--------|---------|
| pending | dispatcher 分配开发 agent | in-progress | tasks/backlog/ → tasks/in-progress/ |
| in-progress | 开发 agent 完成 | in-review | tasks/in-progress/ → tasks/in-review/ |
| in-review | reviewer 通过 | in-qa | 保持在 tasks/in-review/（更新 status） |
| in-review | reviewer 驳回 | pending | tasks/in-review/ → tasks/backlog/ |
| in-qa | qa 通过 | done | tasks/in-review/ → tasks/done/ |
| in-qa | qa 驳回 | pending | tasks/in-review/ → tasks/backlog/ |
| pending | 依赖未满足 | blocked | tasks/backlog/ → tasks/blocked/ |
| blocked | 依赖完成 | pending | tasks/blocked/ → tasks/backlog/ |

### review-only 类型

| 当前状态 | 触发事件 | 新状态 | 目录迁移 |
|---------|---------|--------|---------|
| pending | dispatcher 分配 reviewer/qa | in-review | tasks/backlog/ → tasks/in-review/ |
| in-review | PASS（无问题或仅 minor） | done | tasks/in-review/ → tasks/done/ |
| in-review | 发现 Critical/Major → 创建子 task | done | tasks/in-review/ → tasks/done/ |
| in-review | 需要更多信息 | blocked | tasks/in-review/ → tasks/blocked/ |
| blocked | 信息补全 / 依赖完成 | pending | tasks/blocked/ → tasks/backlog/ |

---

## 四、任务优先级排序

收到多个 pending 任务时，按以下优先级排序：

1. **critical** — 阻塞性 bug，立即分配
2. **high** — 核心 feature，优先于 medium/low
3. **medium** — 常规任务
4. **low** — 优化类任务

同级优先级按创建时间排序（FIFO）。

---

## 五、依赖检测

分配前检查 `depends_on` 字段：

- `depends_on: []` → 可直接分配
- `depends_on: [TASK-xxx]` → 检查依赖任务状态
  - 依赖任务 `status: done` → 可分配
  - 依赖任务非 done → 标记当前任务为 `blocked`，等待依赖完成

blocked 任务移动到 `tasks/blocked/`，依赖完成后 orchestrator 自动移回 `tasks/backlog/`。

---

## 六、并发控制

### 可并行条件

- 两个任务的 `target_files` 无交集
- 两个任务的 `owner` 不同（不同 agent）
- 均无未满足的依赖

### 不可并行条件

- 两个任务修改同一文件 → 串行执行，先到先得
- 两个任务 owner 相同 → 排队
- 存在依赖关系 → 依赖者先执行

### 并发上限

- 同一 agent 同时最多执行 1 个任务
- 全局并行任务数不受限（不同 agent 之间可完全并行）

---

## 七、文件操作规则

任务状态变更 = 文件物理移动 + 更新 status 字段：

- `tasks/backlog/task-xxx.md` → `tasks/in-progress/task-xxx.md` 同时更新 status 字段
- 禁止一个任务同时存在于两个目录
- orchestrator 负责执行所有移动操作

### 子任务

- 子任务 ID 格式：`TASK-{YYYYMMDD}-{序号}`（独立编号，非父任务子编号）
- 子任务 `depends_on` 不自动继承父任务（独立依赖）
- 子任务在 task 文件的 Scope 区标注 `parent: {父任务ID}`

---

## 八、progress.md 写入协调

多个 agent 均需更新 `memory/progress.md`，按以下规则避免冲突：

| 写入者 | 写入时机 | 写入内容 |
|--------|---------|---------|
| **orchestrator** | 任务创建、状态变更、会话结束时 | 移动任务条目到对应区（Done/In Progress/In Review/Blocked/Next），管理进度追踪区的整体结构 |
| **执行 agent** (backend/frontend) | 开发完成时 | 更新 In Progress 区对应任务条目的状态标记 |
| **reviewer** | 审查完成时 | 更新 In Review 区对应任务条目的状态标记 |
| **qa** | 验证完成时 | 更新对应任务条目的状态标记 |

规则：
- orchestrator 是 progress.md 的结构管理者（增删分区、移动条目）
- 执行/reviewer/qa agent 只在已有条目后追加状态标记，不修改其他条目
- 禁止两个 agent 同时写入（依赖 task 状态机串行保证）
