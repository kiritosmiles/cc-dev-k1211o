# API Design Skill

目标：设计符合项目规范的 RESTful API。

输入：
- entity（实体定义）
- action（CRUD 操作）
- auth（鉴权需求）

输出：
- route（路由定义）
- request（请求格式）
- response（响应格式）
- error code（错误码）

---

## 一、设计流程

1. 确定实体和操作 → 映射 HTTP Method
2. 设计 URL 路由 → 遵守 api-standard.md 的版本化和命名规则
3. 定义 Request/Response Schema → 遵守统一响应格式
4. 定义错误码 → 从标准错误码表中选择
5. 标注鉴权 → 明确哪些接口需要什么权限

---

## 二、路由设计规则

| 规则 | 说明 | 示例 |
|------|------|------|
| 版本化 | URL 前缀 `/api/v1/` | `/api/v1/users` |
| 资源复数 | 资源名使用复数名词 | `/users` 而非 `/user` |
| 层级关系 | 子资源嵌套在父资源下 | `/users/:id/orders` |
| 避免动词 | HTTP Method 已表达动作 | 不用 `/getUsers` |
| kebab-case | 多词资源用连字符 | `/api/v1/order-items` |

---

## 三、Request 规范

```json
// POST /api/v1/users
{
  "name": "string (required)",
  "email": "string (required, email format)",
  "role": "string (optional, default: 'member')"
}
```

规则：
- 所有字段标注类型和是否必填
- 使用 camelCase 命名字段
- 不暴露内部 ID 作为必填字段（由后端生成）
- 列表查询必须支持分页参数: `?page=1&page_size=20`

---

## 四、Response 规范

```json
// 成功响应
{
  "success": true,
  "data": { ... },
  "error": null
}

// 分页响应
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

// 错误响应
{
  "success": false,
  "data": null,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email format is invalid",
    "details": [
      { "field": "email", "reason": "must be a valid email address" }
    ]
  }
}
```

---

## 五、标准错误码

| 错误码 | HTTP Status | 说明 |
|--------|-------------|------|
| `VALIDATION_ERROR` | 400 | 请求参数校验失败 |
| `UNAUTHORIZED` | 401 | 未提供认证凭据 |
| `FORBIDDEN` | 403 | 无权限访问该资源 |
| `NOT_FOUND` | 404 | 资源不存在 |
| `CONFLICT` | 409 | 资源冲突（如重复创建） |
| `RATE_LIMITED` | 429 | 请求频率超限 |
| `INTERNAL_ERROR` | 500 | 服务器内部错误 |

---

## 六、鉴权设计

- 所有 API 默认需要鉴权（白名单例外：登录、注册、健康检查）
- 使用 Bearer Token 方案：`Authorization: Bearer <jwt_token>`
- 接口设计时标注所需权限级别：`public` / `authenticated` / `admin`

---

## 七、质量检查

- [ ] 路由符合版本化和命名规则
- [ ] Request 所有字段标注类型和必填
- [ ] Response 使用统一格式 `{ success, data, error }`
- [ ] 分页接口返回 pagination 元数据
- [ ] 错误码从标准码表选取
- [ ] 鉴权级别已标注
