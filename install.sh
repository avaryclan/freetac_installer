#!/bin/bash

# Скрипт автоматической установки FreeTAK Server

echo "=== Установка FreeTAK Server ==="

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "Docker не установлен. Устанавливаем..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo "Docker установлен. Перезагрузите систему или выйдите и войдите снова."
    exit 1
fi

# Проверка наличия Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose не установлен. Устанавливаем..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Создание директорий
echo "Создание директорий..."
mkdir -p data logs config video-config mumble-data

# Копирование .env файла если его нет
if [ ! -f ".env" ]; then
    echo "Создание .env файла..."
    cp env.example .env
    echo "Файл .env создан. Отредактируйте пароли перед запуском!"
fi

# Установка прав на выполнение скриптов
chmod +x scripts/*.sh

echo "=== Установка завершена ==="
echo ""
echo "Для запуска выполните:"
echo "docker-compose up -d"
echo ""
echo "Для просмотра статуса:"
echo "docker-compose ps"
echo ""
echo "Не забудьте изменить пароли в файле .env!" 