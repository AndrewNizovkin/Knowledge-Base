# Установка Docker на Ubuntu

Установка состоит из нескольких шагов:

1. Обновить пакеты:

```bash
sudo apt update
```
2. Установить пакеты, которые необходимы для работы пакетного менеджера apt по протоколу HTTPS:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

3. Добавить GPG-ключ репозитория Docker:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

4. Добавить репозиторий Docker:

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
```

5. Обновить пакеты:

```bash
sudo apt update
```

6. Переключитесь в репозиторий Docker, чтобы его установить:

```bash
apt-cache policy docker-ce
```

7. Установить Docker:

```bash
sudo apt install docker-ce
```

8. Проверить работоспособность:

```bash
sudo systemctl status docker
```

9. Вывести на экран список сетевых интерфейсов:

```bash
ip a
```

10. Сопоставить значения MTU для ens3 и docker0. Если они не совпадают, то нужно лечить, потому что это может стать причиной задержек при подключении к интернет-сервисам. Лекарство [здесь](https://help.reg.ru/support/servery-vps/oblachnyye-servery/ustanovka-programmnogo-obespecheniya/kak-ustanovit-docker-na-ubuntu#1)