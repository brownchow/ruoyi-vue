#!/bin/bash

# =============================================================================
# 停止脚本 - 若依管理系统
# =============================================================================

# 应用名称（需与启动脚本保持一致）
APP_NAME=ruoyi-admin-3.9.1

# 查找应用进程PID
# ps -ef: 显示所有进程
# grep java: 筛选java进程
# grep "$APP_NAME.jar": 筛选目标应用
# grep -v grep: 排除grep自身进程
# awk '{print $2}': 获取PID（进程ID）
PID=$(ps -ef | grep java | grep "$APP_NAME.jar" | grep -v grep | awk '{print $2}')

# 如果未找到进程
if [ -z "$PID" ]; then
    echo "$APP_NAME is not running"
    exit 0
fi

# 发送停止信号
echo "Stopping $APP_NAME (PID: $PID)..."

# -15 (SIGTERM): 正常终止信号，优雅关闭
kill -15 $PID

# 等待进程退出（最多等待30秒）
for i in {1..30}; do
    # 检查进程是否还存在
    if ! ps -p $PID > /dev/null 2>&1; then
        echo "$APP_NAME stopped"
        exit 0
    fi
    sleep 1
done

# 超过30秒未停止，强制杀死进程
echo "Force killing $APP_NAME..."
# -9 (SIGKILL): 强制终止信号，强制关闭
kill -9 $PID
echo "$APP_NAME killed"
