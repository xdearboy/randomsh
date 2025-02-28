#!/bin/bash

# Скрипт для очистки докера в целом

echo "[INFO] Очистка Docker-контейнеров и images..."

if ! command -v docker &>/dev/null; then
    echo "[ERROR] Docker не установлен."
    exit 1
fi

docker container prune -f

docker image prune -a -f

echo "[OK] Очистка завершена."
