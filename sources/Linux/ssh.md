# Установка и настройка SSH в Ubuntu

```bash
sudo apt update && sudo apt upgrade

sudo apt install openssh-server
```

### Запуск и отключение SSH

```bash

sudo systemctl enable --now ssh
# --now ключ, который помогает запустить программу, добавив её в автозагрузку

sudo systemctl status ssh
# проверка

sudo systemctl disable ssh
# отключает и удаляет из автозагрузки
```

