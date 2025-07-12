#!/bin/bash

# Скрипт управления FreeTAK Server

case "$1" in
    start)
        echo "Запуск FreeTAK Server..."
        docker-compose up -d
        echo "Сервисы запущены!"
        ;;
    stop)
        echo "Остановка FreeTAK Server..."
        docker-compose down
        echo "Сервисы остановлены!"
        ;;
    restart)
        echo "Перезапуск FreeTAK Server..."
        docker-compose restart
        echo "Сервисы перезапущены!"
        ;;
    status)
        echo "Статус сервисов:"
        docker-compose ps
        ;;
    logs)
        if [ -z "$2" ]; then
            echo "Логи всех сервисов:"
            docker-compose logs
        else
            echo "Логи сервиса $2:"
            docker-compose logs $2
        fi
        ;;
    shell)
        echo "Вход в контейнер FreeTAK Server..."
        docker-compose exec freetak-server bash
        ;;
    update)
        echo "Обновление FreeTAK Server..."
        docker-compose pull
        docker-compose up -d --build
        echo "Обновление завершено!"
        ;;
    backup)
        echo "Создание резервной копии..."
        tar -czf freetak-backup-$(date +%Y%m%d-%H%M%S).tar.gz data logs config
        echo "Резервная копия создана!"
        ;;
    clean)
        echo "Очистка неиспользуемых ресурсов Docker..."
        docker system prune -f
        echo "Очистка завершена!"
        ;;
    *)
        echo "Использование: $0 {start|stop|restart|status|logs|shell|update|backup|clean}"
        echo ""
        echo "Команды:"
        echo "  start   - Запуск сервисов"
        echo "  stop    - Остановка сервисов"
        echo "  restart - Перезапуск сервисов"
        echo "  status  - Показать статус"
        echo "  logs    - Показать логи (опционально: имя сервиса)"
        echo "  shell   - Войти в контейнер"
        echo "  update  - Обновить сервисы"
        echo "  backup  - Создать резервную копию"
        echo "  clean   - Очистить неиспользуемые ресурсы"
        exit 1
        ;;
esac 