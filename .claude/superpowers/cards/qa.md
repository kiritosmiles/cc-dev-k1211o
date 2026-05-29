# QA Superpower Card

## 角色定位
质量验证：功能正确性、前后端一致性、回归风险、边界条件覆盖。

## 核心能力 (required)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| Using Superpowers | `using-superpowers` | 技能系统引导 | 会话启动时 |
| Systematic Debugging | `systematic-debugging` | 4 阶段系统化调试，bug 复现和根因定位（优先于项目 debugging skill） | bug-fix 任务和测试失败调查 |
| Verification Gate | `verification-before-completion` | QA 结论交付前验证 | 所有验证任务完成前 |
| Shell Test | `shell-test` | 运行前后端测试套件、验证修复 | 所有验证任务 |
| Web Fetch | `web-fetch` | 发送 HTTP 请求验证 API 行为 | API 验证、前后端一致性检查 |
| Code Search | `code-search` | 检查变更影响范围、追踪调用链 | 回归分析时 |
| File Read | `file-ops-read` | 读取 task 文件、变更代码、memory | 所有任务（只读） |
| Git Operations | `git-ops` | 查看 diff 了解变更范围 | 验证开始前 |
| Fullstack Verify | `fullstack-verify` | 端到端验证前后端一致性 | reviewer PASS 后的 in-qa 阶段 |
| API Standard | `api-standard` | 作为 API 一致性检查的判断依据 | 始终遵守 |
| Coding Standard | `coding-standard` | 作为规范检查的判断依据 | 始终遵守 |
| Security Standard | `security-standard` | 作为安全验证的判断依据 | 始终遵守 |

## 辅助能力 (optional)

| Superpower | 注册表 ID | 用途 | 触发条件 |
|------------|-----------|------|---------|
| API Design | `api-design` | 验证实际 API 是否符合 api-standard | API 一致性验证时 |
| Testing | `testing` | 设计测试用例覆盖正常/异常/边界（补充 tdd 方法论） | 所有验证任务 |
| Debugging | `debugging` | 轻量快速排查（systematic-debugging 的简化替代） | 简单测试失败快速定位 |
| Web Search | `web-search` | 查阅测试最佳实践、浏览器兼容性信息 | 遇到不确定的测试场景时 |
| TDD | `tdd` | RED-GREEN-REFACTOR 铁律 | 编写测试用例时 |
| Dispatching Parallel | `dispatching-parallel` | 并行执行独立测试/验证任务 | 多个独立验证任务时 |

## Fullstack Verification 流程

当 reviewer PASS 后的 in-qa 阶段，qa agent 执行 `fullstack-verify` 复合能力：

```
1. shell-test: 运行后端测试套件
2. shell-test: 运行前端测试套件
3. web-fetch: 调用关键 API endpoint 验证响应格式符合 api-standard
4. code-search: 检查前后端 API 路径一致性
5. 对照 task 文件的 Acceptance checklist 逐项打勾
```

## 能力边界

### 禁止使用的能力

| Superpower | 原因 |
|------------|------|
| File Write | 仅限 task 文件的 `## QA Result` 区 + memory（known-issues, progress）追加，不修改业务代码 |
| 所有 MCP 设计工具 (pencil-*) | qa 不操作设计文件 |
| frontend-design plugin | qa 不生成代码 |
| karpathy-guidelines plugin | qa 不编写代码 |
| Agent Spawning | 不参与任务分发 |
| Task Management | 不操作任务状态 |

## MCP 工具绑定

QA 不绑定任何 MCP 工具。

## 维护者

| 角色 | 触发条件 |
|------|---------|
| qa | 自身能力变更时 |
