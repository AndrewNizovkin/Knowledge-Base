# Docker. Практика

Выводит настройки сети, хоста, все volumes, которые подключены к контейнеру:

```sql
docker inspect <conteiner>
```

### Установка mysql-server

1. Скачать пакет с нужной версией MySQL сервера. Например, чтобы скачать версию 8.0, нужно в параметрах команды указать *mysql-server:8.0*. Если не указать версию, то будет поставлен параметр *latest* - последняя версия.

```
docker pull mysql/mysql-server:8.0
```

2. Запустить контейнер с MySQL сервером, указав в параметрах имя, пароль для *root*, язык и пакет с нужным образом.

```
docker run --name mysql57 -e MYSQL_ROOT_PASSWORD=passw -e LANG=C.UTF-8 -d mysql/mysql-server:8.0

docker logs mysql57

```

```
docker exec -it mysql57 mysql -uroot -p

SHOW DATABASES;

exit
```

The end