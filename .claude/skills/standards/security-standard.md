# Security Standard

安全开发规范。所有代码必须遵守。

---

## 一、输入校验

- 所有外部输入（Request body、Query params、Headers）必须校验
- 校验规则: 类型、长度、格式、范围、枚举值
- 校验失败返回 `400 VALIDATION_ERROR`，不暴露内部实现细节
- 后端独立校验，不依赖前端验证

---

## 二、注入防护

### SQL 注入

- **禁止** 字符串拼接 SQL
- **必须** 使用参数化查询或 ORM
- 动态表名/列名/排序字段必须白名单校验

```python
# 禁止
query = f"SELECT * FROM users WHERE id = {user_id}"

# 正确
query = "SELECT * FROM users WHERE id = :user_id"
```

### XSS 防护

- 所有用户输入在输出到 HTML 前必须转义
- 使用框架内置的转义机制（React JSX 自动转义、模板引擎 auto-escaping）
- 富文本输入使用 DOMPurify 等库清洗后渲染
- **禁止** 使用 `dangerouslySetInnerHTML` 插入未清洗内容
- 设置 CSP Header: `Content-Security-Policy: default-src 'self'`

### 命令注入

- **禁止** 将用户输入拼接到系统命令中
- 如需执行外部命令，使用参数数组形式（避免 shell 解析）

---

## 三、认证与授权

### Token 管理
- 使用 JWT（RS256 签名）或 OAuth2
- Access Token 有效期 ≤ 1 小时，使用 Refresh Token 续期
- Token 存储在 HttpOnly / Secure / SameSite=Strict Cookie 中（Web 应用）
- 禁止将 Token 放在 URL 中

### 权限
- 每个接口独立校验权限，不依赖前端隐藏按钮
- 资源级权限: 用户只能访问自己的数据（检查 `user_id` 所有权）
- 角色级权限: admin / user 区分敏感操作

---

## 四、数据保护

### 敏感数据处理
- **禁止** 硬编码密钥、密码、Token、API Key（使用环境变量或密钥管理服务）
- 密码: bcrypt / argon2 哈希（不存储明文，不用 MD5/SHA1）
- 日志中不得包含密码、Token、身份证号等敏感信息
- 响应中不得暴露内部错误栈、数据库 schema、服务器路径

### 传输安全
- 生产环境强制 HTTPS
- 敏感数据不在 URL Query 参数中传输（使用 POST Body）

---

## 五、CSRF 防护

- 状态变更操作（POST/PUT/PATCH/DELETE）必须验证 CSRF Token 或使用 SameSite Cookie
- SPA + JWT 方案: 使用 `SameSite=Strict` Cookie 或自定义 Request Header (`X-Requested-With`)

---

## 六、依赖安全

- CI 流程中集成依赖漏洞扫描（`npm audit` / `pip-audit` / `trivy`）
- Critical/High 漏洞必须在合并前修复或评估为误报
- 定期更新依赖版本

---

## 七、安全检查清单

代码审查时逐项检查:

- [ ] 无 SQL 拼接（全部使用参数化查询/ORM）
- [ ] 无硬编码密钥或密码
- [ ] 用户输入经过校验和转义
- [ ] 敏感接口有权限检查
- [ ] 日志不包含敏感数据
- [ ] 响应不暴露内部错误信息
- [ ] 状态变更接口有 CSRF 防护
- [ ] 依赖无已知 Critical/High 漏洞
