# FreeTAK Server Docker

Docker контейнер для развертывания FreeTAK Server на Ubuntu.

## Требования

- Docker
- Docker Compose
- Ubuntu Server (рекомендуется)

## Быстрый старт

1. **Клонирование репозитория:**
```bash
git clone <your-repo>
cd FreeTAK
```

2. **Создание директорий для данных:**
```bash
mkdir -p data logs config video-config mumble-data
```

3. **Запуск сервисов:**
```bash
docker-compose up -d
```

4. **Проверка статуса:**
```bash
docker-compose ps
```

## Порты

| Сервис | Порт | Описание |
|--------|------|----------|
| FreeTAK Server | 8087 | TCP COT |
| FreeTAK Server | 8089 | SSL COT |
| FreeTAK Server | 9000 | Federation |
| FreeTAK Server | 19023 | REST API |
| FreeTAK Server | 5000 | Web UI |
| NodeRed | 1880 | NodeRed UI |
| NodeRed | 8000 | NodeRed WebUI |
| Video Server | 9997 | MediaMTX |
| Video Server | 8888 | MediaMTX Web UI |
| Voice Server | 64738 | Mumble (UDP/TCP) |

## Конфигурация

### Переменные окружения

Создайте файл `.env` для настройки параметров:

```bash
# FreeTAK Server
FTS_IP=0.0.0.0
FTS_PORT=8087
FTS_SSL_PORT=8089
FTS_FEDERATION_PORT=9000
FTS_API_PORT=19023
FTS_UI_PORT=5000

# Mumble Server
MUMBLE_SUPERUSER_PASSWORD=your_superuser_password
MUMBLE_SERVER_PASSWORD=your_server_password
```

### Персистентные данные

Данные сохраняются в следующих директориях:
- `./data` - данные FreeTAK Server
- `./logs` - логи FreeTAK Server
- `./config` - конфигурационные файлы
- `./video-config` - конфигурация видеосервера
- `./mumble-data` - данные голосового сервера

## Управление

### Запуск
```bash
docker-compose up -d
```

### Остановка
```bash
docker-compose down
```

### Перезапуск
```bash
docker-compose restart
```

### Просмотр логов
```bash
# Все сервисы
docker-compose logs

# Конкретный сервис
docker-compose logs freetak-server
docker-compose logs video-server
docker-compose logs voice-server
```

### Обновление
```bash
docker-compose pull
docker-compose up -d --build
```

## Подключение клиентов

### ATAK
- Сервер: `your-server-ip:8087`
- SSL: `your-server-ip:8089`

### WinTAK
- Сервер: `your-server-ip:8087`
- SSL: `your-server-ip:8089`

### Web UI
- Адрес: `http://your-server-ip:5000`

## Безопасность

1. Измените пароли по умолчанию в `.env`
2. Настройте SSL сертификаты
3. Используйте файрвол для ограничения доступа
4. Регулярно обновляйте контейнеры

## Устранение неполадок

### Проверка статуса сервисов
```bash
docker-compose ps
```

### Просмотр логов
```bash
docker-compose logs -f freetak-server
```

### Вход в контейнер
```bash
docker-compose exec freetak-server bash
```

### Проверка портов
```bash
netstat -tulpn | grep :8087
```

## Поддержка

При возникновении проблем:
1. Проверьте логи: `docker-compose logs`
2. Убедитесь, что все порты открыты
3. Проверьте конфигурацию в `.env`
4. Перезапустите сервисы: `docker-compose restart` 