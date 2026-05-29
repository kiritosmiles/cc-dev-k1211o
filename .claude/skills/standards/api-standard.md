# API Standard

RESTful API 规范。所有后端 API 必须遵守。

---

## 一、HTTP Method 语义

| Method | 语义 | 幂等 |
|--------|------|------|
| GET | 查询资源 | 是 |
| POST | 创建资源 | 否 |
| PUT | 整体替换资源 | 是 |
| PATCH | 部分更新资源 | 否 |
| DELETE | 删除资源 | 是 |

---

## 二、URL 规范

- **版本化**: 所有 API 路径以 `/api/v{major}/` 开头（v1, v2, ...）
- **资源名**: 复数名词，小写，多词用连字符: `/order-items`
- **层级关系**: `/users/:user_id/orders/:order_id`
- **避免动词**: 通过 HTTP Method 区分操作，不在路径中使用动词
- **Query 参数**: 用于筛选、排序、分页: `?status=active&sort=-created_at`

---

## 三、统一响应格式

### 成功

```json
{
  "success": true,
  "data": { ... },
  "error": null
}
```

### 分页列表

```json
{
  "success": true,
  "data": {
    "items": [ ... ],
    "pagination": {
      "page": 1,
      "page_size": 20,
      "total": 156,
      "total_pages": 8
    }
  },
  "error": null
}
```

分页参数规范:
- 请求参数: `page` (默认 1), `page_size` (默认 20, 最大 100)
- 响应 `pagination` 块必须包含: `page`, `page_size`, `total`, `total_pages`

### 错误

```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "human-readable description",
    "details": [
      { "field": "email", "reason": "must be a valid email address" }
    ]
  }
}
```

---

## 四、标准错误码

| 错误码 | HTTP Status | 使用场景 |
|--------|-------------|---------|
| `VALIDATION_ERROR` | 400 | 请求参数格式/值不合法 |
| `UNAUTHORIZED` | 401 | 缺少或无效的认证凭据 |
| `FORBIDDEN` | 403 | 已认证但无权限 |
| `NOT_FOUND` | 404 | 资源不存在 |
| `METHOD_NOT_ALLOWED` | 405 | HTTP Method 不支持 |
| `CONFLICT` | 409 | 资源冲突（重复、版本冲突） |
| `UNPROCESSABLE_ENTITY` | 422 | 语义错误（业务规则违反） |
| `RATE_LIMITED` | 429 | 频率限制 |
| `INTERNAL_ERROR` | 500 | 未预期的服务器错误 |

---

## 五、鉴权

- 所有接口默认需要鉴权，例外（白名单）: 登录、注册、健康检查、公开资源
- 认证方式: `Authorization: Bearer <token>`
- Token 类型: JWT（含 user_id, role, exp）
- Token 过期后返回 `UNAUTHORIZED` (401)
- 权限不足返回 `FORBIDDEN` (403)

---

## 六、Rate Limit

- 响应 Header 中返回限流信息:
  - `X-RateLimit-Limit`: 窗口内最大请求数
  - `X-RateLimit-Remaining`: 剩余请求数
  - `X-RateLimit-Reset`: 窗口重置时间（Unix timestamp）
- 超限返回 `429 RATE_LIMITED`

---

## 七、Request Validation

- 所有输入必须校验类型、格式、范围
- 必填字段缺失 → `400 VALIDATION_ERROR`
- 校验失败时 `details` 数组列出所有不合规字段
- 不依赖前端校验，后端独立验证

---

## 八、其他规范

- **排序**: Query 参数 `sort`，格式 `-field` (降序) 或 `field` (升序)，如 `?sort=-created_at`
- **字段筛选**: Query 参数 `fields`，逗号分隔，如 `?fields=id,name,email`
- **时间格式**: ISO 8601 (`2024-01-15T10:30:00Z`)
- **ID 类型**: UUID v4 或自增整数（由项目 tech-stack 决定）
- **Content-Type**: 请求和响应均为 `application/json`
