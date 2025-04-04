# Введение в Docker.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/4924994/attachment/194d8159933c69264fcc852167eefd80.pdf)

- Docker - это платформа, предназначенная для быстрой разработки,
развертывания, тестирования и запуска приложений в контейнерах и может быть использована во многих командах при разработке ПО.
    
    
 - CI/CD (Continuous Integration/Continuous Delivery) — методология разработки программного обеспечения, которая обеспечивает надежность и скорость создания продукта. Относится к одной из типовых DevOps-практик.
 
 ```bash
# Выводит версию докера
docker --version
docker info

# Выводит список image.id
docker images -aq 

# Удаляет все остановленные образы.
# Флаг -a говорит вывести, в том числе, остановленные контейнеры,
# а флаг -q говорит о том, что вывести необходимо ID
# контейнеров.
docker rmi $(docker images -aq) -f

# запускает контейнер ubuntu в интерактивном режиме
docker run -it ubuntu bash
docker run -it ubuntu date 

# выводит информацию о занимаемой памяти
docker system df

# очищает систему. Удаляет остановленные контейнеры и неиспользуемые
# образы
docker system prune -af

# устанавливает программу ip
apt install iproute2

# запуск контейнера в интерактивном режиме
docker exec -it <id> bash

# список образов
docker image ls

# список контейнеров
docker container ls

# список виртуальных дисков
docker volume ls

# Запуск phpMyAdmin и связь его с уже запущенным контейрером с базой данных
docker run --name phpmyadmin1 --link dbcontainer-name:db -p 8080:80 phpmyadmin/phpmyadmin
 ```