#!/bin/bash

if ! command -v ss &>/dev/null || ! command -v nmap &>/dev/null; then
    echo "[ERROR] Необходимые штучки не установлены - (ss, nmap)"
    exit 1
fi

LOCAL_PORTS=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d: -f2 | sort -n | uniq)

echo "[INFO] Найдены локальные открытые порты: $LOCAL_PORTS"

PUBLIC_IP=$(curl -s ifconfig.me)

echo "[INFO] Ваш публичный IP: $PUBLIC_IP"

EXPOSED_PORTS=()

for port in $LOCAL_PORTS; do
    nmap -p $port $PUBLIC_IP | grep -q "open"
    if [ $? -eq 0 ]; then
        EXPOSED_PORTS+=("$port")
    fi
done

if [ ${#EXPOSED_PORTS[@]} -eq 0 ]; then
    echo "[OK] Нет публично доступных портов."
else
    echo "[WARN] Публично доступны порты: ${EXPOSED_PORTS[*]}"
fi

# Написал на скорую руку, не судите строго)
