# 阶段1：构建前端
FROM node:20-alpine AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend ./
RUN npm run build

# 阶段2：构建后端
FROM node:20-alpine AS backend-builder
WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm install
COPY backend ./
RUN npm run build

# 阶段3：运行环境
FROM node:20-alpine
WORKDIR /app

# 复制后端
COPY --from=backend-builder /app/backend/dist ./backend/dist
COPY --from=backend-builder /app/backend/node_modules ./backend/node_modules
COPY backend/package*.json ./backend/

# 复制前端（静态文件）
COPY --from=frontend-builder /app/frontend/dist ./public

# 暴露端口
EXPOSE 3001

# 启动后端（同时提供静态前端文件）
WORKDIR /app/backend
CMD ["node", "dist/simple-server.js"]
