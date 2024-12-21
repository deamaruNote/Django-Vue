###### 前端構建階段 ######
FROM node:18-alpine AS frontend-build

# 設置工作目錄
WORKDIR /frontend

# 複製前端相關文件
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend ./

# 構建前端/編譯成靜態檔案
RUN npm run build

###### 以下為後端環境建置 ######
# 後端構建階段
FROM python:3.11 AS backend

# 設置工作目錄
WORKDIR /app

# 安裝後端依賴
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製整個母層目錄
COPY . .

# 從前端構建階段複製靜態資源到後端
COPY --from=frontend-build /frontend/dist /app/frontend/dist

# 設定靜態文件的根目錄，確保路徑存在
RUN mkdir -p /app/static

# 遷移數據庫並收集靜態文件
RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

# 替換前端環境變量的 API 地址
RUN sed -i 's|http://localhost:8000/api|/api|g' /app/frontend/dist/index.html

# 暴露API端口
EXPOSE 8000

# 啟動 Django 開發伺服器
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
