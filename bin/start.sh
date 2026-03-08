#!/bin/bash

# =============================================================================
# 启动脚本 - 若依管理系统
# =============================================================================

APP_NAME=ruoyi-admin-3.9.1
LOG_NAME=ruoyi

BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)
LIB_DIR=$BASE_DIR/lib
CONFIG_DIR=$BASE_DIR/config
LOG_DIR=$BASE_DIR/logs

JAVA_OPTS="-Xms512m -Xmx1024m -Dname=$LOG_NAME"

mkdir -p "$LOG_DIR"

cd "$BASE_DIR"

nohup java $JAVA_OPTS -Dloader.path="$LIB_DIR" -Dspring.config.location="$CONFIG_DIR/" -jar "$LIB_DIR/$APP_NAME.jar" > "$LOG_DIR/$LOG_NAME.log" 2>&1 &

echo "Starting $APP_NAME..."
sleep 2

PID=$(ps -ef | grep java | grep "$APP_NAME.jar" | grep -v grep | awk '{print $2}')
if [ -n "$PID" ]; then
    echo "$APP_NAME started, PID: $PID"
else
    echo "Failed to start $APP_NAME"
    exit 1
fi
