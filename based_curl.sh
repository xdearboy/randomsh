#!/bin/bash

echo "[INFO] Проверка доступности URL..."

URLS=("https://google.com" "https://github.com" "https://yandex.ru")

for url in "${URLS[@]}"; do
    if curl -Is "$url" | head -n 1 | grep -q "200"; then
        echo "[OK] $url доступен."
    else
        echo "[WARN] $url не отвечает."
    fi
done

echo "[INFO] Проверка завершена."

# Чисто быстрый курл готовый емае
