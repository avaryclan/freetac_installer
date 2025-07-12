FROM python:3.11-slim

# Установка переменных окружения
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Обновление системы и установка зависимостей
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Создание пользователя для FreeTAK
RUN useradd -m -s /bin/bash freetak

# Создание директорий
RUN mkdir -p /opt/FreeTAKServer \
    && mkdir -p /opt/FreeTAKServer/FreeTAKServer \
    && mkdir -p /opt/FreeTAKServer/logs \
    && mkdir -p /opt/FreeTAKServer/data \
    && chown -R freetak:freetak /opt/FreeTAKServer

# Переключение на пользователя freetak
USER freetak

# Клонирование FreeTAK Server
WORKDIR /opt/FreeTAKServer
RUN git clone https://github.com/FreeTAKTeam/FreeTAKServer.git

# Установка Python зависимостей
WORKDIR /opt/FreeTAKServer/FreeTAKServer
RUN pip install --user -r requirements.txt

# Создание конфигурационных файлов
RUN mkdir -p /opt/FreeTAKServer/config

# Копирование скриптов запуска
COPY --chown=freetak:freetak scripts/ /opt/FreeTAKServer/scripts/

# Установка прав на выполнение
RUN chmod +x /opt/FreeTAKServer/scripts/*.sh

# Открытие портов
EXPOSE 8087 8089 9000 19023 5000

# Установка рабочей директории
WORKDIR /opt/FreeTAKServer

# Команда по умолчанию
CMD ["/opt/FreeTAKServer/scripts/start.sh"] 