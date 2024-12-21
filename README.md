# Django-Vue
# 實驗性專案

## 測試前端API使用

-> core: 連接資料庫、專案設定等

-> sim:  業務邏輯架構

-> vue:  vite, pinia

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

python3 mane.py runserver
/*  執行測試用API */

npm run dev
/* 執行前端 */

=============================

建置Docker image
docker build -t frontend-app .

RUN Docker image
docker run -p 8080:80 frontend-app

** 目前前端有些問題，運行後python 404 **