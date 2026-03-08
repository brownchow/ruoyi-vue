#!/bin/bash

# =============================================================================
# 启动脚本 - 若依管理系统
# =============================================================================

# 应用名称（jar文件名）
APP_NAME=ruoyi-admin-3.9.1

# 日志文件名
LOG_NAME=ruoyi

# 获取脚本所在目录
APP_HOME=$(cd "$(dirname "$0")" && pwd)

# 获取应用根目录（脚本所在目录的父目录）
BASE_DIR=$(cd "$APP_HOME/.." && pwd)

# JVM 启动参数
# -Dname: 应用名称，用于日志识别
# -Duser.timezone: 设置时区
# -Xms512m: 初始堆内存大小
# -Xmx1024m: 最大堆内存大小
# -XX:MetaspaceSize=128m: 初始元空间大小
# -XX:MaxMetaspaceSize=512m: 最大元空间大小
# -XX:+HeapDumpOnOutOfMemoryError: OOM时生成堆转储文件
# -XX:+PrintGCDateStamps: 打印GC日期时间戳
# -XX:+PrintGCDetails: 打印GC详情
# -XX:NewRatio=1: 新生代与老年代比例
# -XX:SurvivorRatio=30: Eden区与Survivor区比例
# -XX:+UseParallelGC: 使用Parallel垃圾收集器
# -XX:+UseParallelOldGC: 使用Parallel Old垃圾收集器
JVM_OPTS="-Dname=$LOG_NAME -Duser.timezone=Asia/Shanghai -Xms512m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC"

# 依赖库目录
LIB_DIR=$BASE_DIR/lib

# 配置文件目录
CONFIG_DIR=$BASE_DIR/config

# 日志目录
LOG_DIR=$BASE_DIR/logs

# 日志文件路径
LOG_FILE=$LOG_DIR/$LOG_NAME.log

# 创建日志目录（如果不存在）
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
fi

# 切换到应用根目录
cd "$BASE_DIR"

# 启动应用
# -Dloader.path: 指定外部依赖目录（用于加载lib下的jar）
# -Dspring.config.location: 指定外部配置文件目录
# nohup ... > /dev/null 2>&1 &: 后台启动，不输出到终端
nohup java $JVM_OPTS -Dloader.path="$LIB_DIR" -Dspring.config.location="$CONFIG_DIR/" -jar "$LIB_DIR/$APP_NAME.jar" > "$LOG_FILE" 2>&1 &

# 等待应用启动
echo "Starting $APP_NAME..."
sleep 2

# 检查应用是否启动成功
PID=$(ps -ef | grep java | grep "$APP_NAME.jar" | grep -v grep | awk '{print $2}')
if [ -n "$PID" ]; then
    echo "$APP_NAME started, PID: $PID"
else
    echo "Failed to start $APP_NAME"
    exit 1
fi
