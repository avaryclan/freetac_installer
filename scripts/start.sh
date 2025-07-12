#!/bin/bash

# Скрипт запуска FreeTAK Server

echo "Запуск FreeTAK Server..."

# Переход в директорию FreeTAK Server
cd /opt/FreeTAKServer/FreeTAKServer

# Проверка наличия конфигурационного файла
if [ ! -f "/opt/FreeTAKServer/config/config.py" ]; then
    echo "Создание конфигурационного файла..."
    cp config.py /opt/FreeTAKServer/config/
fi

# Установка переменных окружения
export PYTHONPATH=/opt/FreeTAKServer/FreeTAKServer
export FTS_IP=${FTS_IP:-0.0.0.0}
export FTS_PORT=${FTS_PORT:-8087}
export FTS_SSL_PORT=${FTS_SSL_PORT:-8089}
export FTS_FEDERATION_PORT=${FTS_FEDERATION_PORT:-9000}
export FTS_API_PORT=${FTS_API_PORT:-19023}
export FTS_UI_PORT=${FTS_UI_PORT:-5000}

# Запуск FreeTAK Server
echo "Запуск с параметрами:"
echo "IP: $FTS_IP"
echo "Port: $FTS_PORT"
echo "SSL Port: $FTS_SSL_PORT"
echo "Federation Port: $FTS_FEDERATION_PORT"
echo "API Port: $FTS_API_PORT"
echo "UI Port: $FTS_UI_PORT"

# Запуск основного сервиса
python3 -m FreeTAKServer.controllers.FTS 