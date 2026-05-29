# Testing Skill

目标：保证功能正确性和稳定性，通过分层测试覆盖正常/异常/边界场景。

---

## 一、测试分层

| 层级 | 范围 | 工具 | 速度 |
|------|------|------|------|
| Unit Test | 单个函数/方法 | Jest / Pytest | 快 |
| Integration Test | 多模块交互（含 DB） | Supertest / Pytest | 中 |
| E2E Test | 完整用户流程 | Playwright / Cypress | 慢 |

---

## 二、测试命名规范

```
describe('模块/类名', () => {
  describe('方法名', () => {
    it('should {预期行为} when {条件}', () => {
      // ...
    });
  });
});
```

示例:
- `it('should return 401 when token is expired')`
- `it('should throw ValidationError when email is empty')`
- `it('should update user status when admin approves')`

---

## 三、必须覆盖的场景

### 正常流程
- [ ] 有效输入返回预期输出
- [ ] 状态变更正确（创建/更新/删除）

### 异常流程
- [ ] 无效输入返回校验错误
- [ ] 无权限返回 403
- [ ] 未登录返回 401
- [ ] 资源不存在返回 404
- [ ] 数据库失败返回 500（模拟 DB 异常）

### 边界条件
- [ ] 空字符串 / null / undefined
- [ ] 超长字符串
- [ ] 零值 / 负值
- [ ] 并发冲突

### 数据校验
- [ ] 必填字段缺失
- [ ] 字段类型错误
- [ ] 枚举值非法

---

## 四、Mock 与 Stub 指南

| 场景 | 做法 |
|------|------|
| 外部 API 调用 | Mock HTTP 请求，不发起真实请求 |
| 数据库操作 | Integration test 用真实测试 DB；Unit test mock Repository |
| 时间依赖 | Mock `Date.now()` 或使用时间参数注入 |
| 文件系统 | 使用临时目录，测试后清理 |
| 环境变量 | 测试中显式设置，不依赖 `.env` 文件 |

Mock 原则：
- 只 mock 边界层（API client、DB adapter），不 mock 内部 service
- Mock 返回值必须与真实接口 schema 一致

---

## 五、测试文件组织

```
src/
├── modules/
│   └── auth/
│       ├── auth.service.ts
│       ├── auth.controller.ts
│       └── __tests__/
│           ├── auth.service.test.ts
│           ├── auth.controller.test.ts
│           └── auth.integration.test.ts
```

规则：
- 测试文件与源文件同目录或 `__tests__/` 子目录
- 文件名: `{name}.test.{ext}` 或 `{name}.spec.{ext}`
- Integration test 可单独标注: `{name}.integration.test.{ext}`

---

## 六、覆盖率要求

| 指标 | 最低阈值 |
|------|---------|
| 行覆盖率 | 80% |
| 分支覆盖率 | 75% |
| 函数覆盖率 | 80% |

以下场景可豁免覆盖率要求（需 reviewer 确认）：
- 纯配置/常量文件
- 第三方库的类型声明
- 框架生成的样板代码

---

## 七、输出格式

```markdown
## Test Cases
| # | 场景 | 类型 | 输入 | 预期输出 |
|---|------|------|------|---------|
| 1 | 正常创建用户 | normal | {name, email} | 201 + user |
| 2 | 邮箱重复 | error | 已存在 email | 409 + CONFLICT |
| 3 | 邮箱为空 | boundary | email="" | 400 + VALIDATION_ERROR |

## Coverage
- 行: 85% / 分支: 80% / 函数: 88%

## Edge Cases
- 并发创建同名用户 → 唯一约束处理
- 超长 name (1000+ chars) → 截断或拒绝
```
