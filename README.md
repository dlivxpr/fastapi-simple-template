# FastAPI Simple Template

基于 FastAPI + SQLAlchemy + MySQL + Redis 的现代化 Web API 模板项目，提供完整的用户认证、权限管理和 CRUD 操作功能。

> 本项目基于 [fastapi-practices/fastapi_sqlalchemy_mysql](https://github.com/fastapi-practices/fastapi_sqlalchemy_mysql) 进行开发和优化。

## ✨ 项目特性

- 🚀 **现代化技术栈**: FastAPI + SQLAlchemy 2.0 + Pydantic v2
- 🔐 **完整认证系统**: JWT 认证、验证码、密码加密
- 📊 **数据库支持**: MySQL 8.0+ 异步操作
- 🔄 **缓存系统**: Redis 集成，支持限流和缓存
- 📝 **API 文档**: 自动生成 OpenAPI 文档
- 🛡️ **安全特性**: CORS、请求限流、SQL 注入防护
- 📦 **依赖管理**: 使用 uv 进行现代化包管理
- 🐳 **容器化**: Docker 和 Docker Compose 支持
- 📋 **数据库迁移**: Alembic 数据库版本控制
- 🔍 **日志系统**: 结构化日志记录
- ✅ **代码质量**: Pre-commit hooks、Ruff 代码检查

## 🛠️ 技术栈

- **Web 框架**: FastAPI 0.116.1
- **数据库 ORM**: SQLAlchemy 2.0.42
- **数据验证**: Pydantic v2
- **数据库**: MySQL 8.0+ (使用 asyncmy 驱动)
- **缓存**: Redis 6.2.0+
- **认证**: JWT (python-jose)
- **密码加密**: bcrypt
- **数据库迁移**: Alembic
- **日志**: Loguru
- **包管理**: uv
- **容器化**: Docker & Docker Compose

## 📋 环境要求

- Python 3.13+
- MySQL 8.0+
- Redis 推荐最新稳定版
- uv (Python 包管理器)

## 🚀 快速开始

### 本地开发

1. **克隆项目**
   ```shell
   git clone <repository-url>
   cd fastapi-simple-template
   ```

2. **安装依赖项**
   ```shell
   # 使用 uv 安装依赖
   uv sync
   
   # 或者使用传统方式
   pip install -r requirements.txt
   ```

3. **数据库配置**
   ```shell
   # 创建数据库
   mysql -u root -p
   CREATE DATABASE fsm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

4. **启动 Redis**
   ```shell
   # 使用 Docker 启动 Redis
   docker run -d --name redis -p 6379:6379 redis:latest
   
   # 或者本地安装启动
   redis-server
   ```

5. **配置环境变量**
   ```shell
   cd backend
   cp .env.example .env
   ```
   
   编辑 `.env` 文件，配置数据库和 Redis 连接信息：
   ```env
   # 环境配置
   ENVIRONMENT=dev
   
   # 数据库配置
   DATABASE_HOST=127.0.0.1
   DATABASE_PORT=3306
   DATABASE_USER=root
   DATABASE_PASSWORD=your_password
   
   # Redis 配置
   REDIS_HOST=127.0.0.1
   REDIS_PORT=6379
   REDIS_PASSWORD=
   REDIS_DATABASE=0
   
   # JWT 密钥 (请生成新的密钥)
   TOKEN_SECRET_KEY=your_secret_key_here
   ```

6. **数据库迁移**
   ```shell
   # 生成迁移文件
   alembic revision --autogenerate -m "Initial migration"
   
   # 执行迁移
   alembic upgrade head
   ```

7. **启动服务**
   ```shell
   # 开发模式启动
   fastapi dev main.py
   
   # 或者使用 uvicorn
   uvicorn main:app --reload
   ```

8. **访问应用**
   - API 文档: http://127.0.0.1:8000/docs
   - ReDoc 文档: http://127.0.0.1:8000/redoc
   - 健康检查: http://127.0.0.1:8000/api/v1/health

## 📚 API 功能

### 认证模块
- `POST /api/v1/auth/login` - 用户登录
- `POST /api/v1/auth/logout` - 用户登出
- `GET /api/v1/auth/captcha` - 获取验证码

### 用户管理
- `POST /api/v1/users/register` - 用户注册
- `GET /api/v1/users/{username}` - 获取用户信息
- `PUT /api/v1/users/{username}` - 更新用户信息
- `PUT /api/v1/users/{username}/avatar` - 更新用户头像
- `GET /api/v1/users` - 分页获取用户列表
- `DELETE /api/v1/users/{username}` - 删除用户
- `POST /api/v1/users/password/reset` - 重置密码

## 🐳 Docker 部署

### 使用 Docker Compose

1. **配置环境变量**
   ```shell
   cd deploy/docker-compose/
   cp .env.server ../../backend/.env
   ```

2. **启动所有服务**
   ```shell
   # 构建并启动所有服务
   docker-compose up -d --build
   ```

3. **查看服务状态**
   ```shell
   docker-compose ps
   docker-compose logs -f
   ```

4. **访问应用**
   - API 文档: http://127.0.0.1:8000/docs

### 单独使用 Docker

```shell
# 构建镜像
docker build -t fastapi-app .

# 运行容器
docker run -d \
  --name fastapi-app \
  -p 8000:8000 \
  --env-file backend/.env \
  fastapi-app
```

## 📁 项目结构

```
fastapi-simple-template/
├── backend/                    # 后端代码
│   ├── app/                   # 应用模块
│   │   └── admin/            # 管理员模块
│   │       ├── api/          # API 路由
│   │       ├── crud/         # 数据库操作
│   │       ├── model/        # 数据模型
│   │       ├── schema/       # 数据验证模式
│   │       └── service/      # 业务逻辑
│   ├── common/               # 公共模块
│   │   ├── exception/        # 异常处理
│   │   ├── response/         # 响应模式
│   │   └── security/         # 安全相关
│   ├── core/                 # 核心配置
│   ├── database/             # 数据库配置
│   ├── middleware/           # 中间件
│   └── utils/                # 工具函数
├── deploy/                   # 部署配置
│   ├── docker-compose/       # Docker Compose 配置
│   └── nginx.conf           # Nginx 配置
├── docs/                     # 文档
├── pyproject.toml           # 项目配置
└── README.md               # 项目说明
```

## 🔧 开发指南

### 代码规范

项目使用 pre-commit hooks 确保代码质量：

```shell
# 安装 pre-commit
uv add --group lint pre-commit

# 安装 hooks
pre-commit install

# 手动运行检查
pre-commit run --all-files
```

### 数据库操作

```shell
# 创建新的迁移文件
alembic revision --autogenerate -m "描述你的更改"

# 应用迁移
alembic upgrade head

# 回滚迁移
alembic downgrade -1

# 查看迁移历史
alembic history
```

### 添加新功能模块

1. 在 `backend/app/` 下创建新模块目录
2. 按照以下结构组织代码：
   ```
   your_module/
   ├── api/          # API 路由
   ├── crud/         # 数据库 CRUD 操作
   ├── model/        # SQLAlchemy 模型
   ├── schema/       # Pydantic 模式
   └── service/      # 业务逻辑服务
   ```
3. 在 `backend/app/router.py` 中注册新的路由

### 环境变量说明

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| `ENVIRONMENT` | 运行环境 (dev/pro) | dev |
| `DATABASE_HOST` | 数据库主机 | 127.0.0.1 |
| `DATABASE_PORT` | 数据库端口 | 3306 |
| `DATABASE_USER` | 数据库用户名 | - |
| `DATABASE_PASSWORD` | 数据库密码 | - |
| `REDIS_HOST` | Redis 主机 | 127.0.0.1 |
| `REDIS_PORT` | Redis 端口 | 6379 |
| `TOKEN_SECRET_KEY` | JWT 密钥 | - |
| `TOKEN_EXPIRE_SECONDS` | Token 过期时间(秒) | 86400 |

## 🤝 贡献指南

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

### 提交规范

请使用以下格式提交代码：

- `feat:` 新功能
- `fix:` 修复 bug
- `docs:` 文档更新
- `style:` 代码格式调整
- `refactor:` 代码重构
- `test:` 测试相关
- `chore:` 构建过程或辅助工具的变动

## 📄 许可证

本项目基于 [MIT 许可证](LICENSE) 开源。

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

---

如果这个项目对你有帮助，请给个 ⭐️ 支持一下！
