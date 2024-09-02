# Настройка сети в Linux. Работа с IPtables.


1. Настроить статическую конфигурацию (без DHCP) в Ubuntu через ip и netplan. Настроить IP, маршрут по умолчанию и DNS-сервера (1.1.1.1 и 8.8.8.8). Проверить работоспособность сети.

`cd /etc/netplan`

`sudo touch my_config.yaml`

`sudo nano my_config.yaml`

```java
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [192.168.0.8/24]
      routes:
        - to: 192.168.0.254
      nameservers:
        addresses:
          - 1.1.1.1
          - 8.8.8.8
sudo ip addr add 192.168.0.9/255.255.255.0 broadcast 192.168.0.255
dev enp0s3
ping ya.ru

```

1. Настроить правила iptables для доступности сервисов на TCP-портах 22, 80 и 443. Также сервер должен иметь возможность устанавливать подключения к серверу обновлений. Остальные подключения запретить.

```java
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT\
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
```

1. Запретить любой входящий трафик с IP 3.4.5.6.
    
    ```java
    iptables I INPUT -s 3.4.5.6 -j DROP
    ```
    
2. Запросы на порт 8090 перенаправлять на порт 80 (на этом же сервере).
    
    ```java
    iptables -t nat -I PREROUTING -p tcp --dport 8090 -j REDIRECT --to-port 80
    ```
    
3. Разрешить подключение по SSH только из сети 192.168.0.0/24.\
    
    ```java
    iptables -I INPUT -p tcp --dport 22 -j DROP
    iptables -I INPUT -p tcp --dport 22 -s 192.168.0.0/24 -j ACCEPT
    ```


## Глоссарий

```bash
sudo ip addr add 128.15.11.132 dev lo - добавить ip адрес

sudo ip addr del 128.15.11.132 dev lo - удалить ip адрес

ip route list

ip route add <ip-addr> dev <interf>

ip route add <ip-addr> via <127.0.0.1>

iptables --line-numbers -L -v -n нумерует строки в выводимой таблице

iptables -A INPUT -p icmp --icmp-type 8 -j DROP - запрещает ping

ls /etc/netplan - показ файл all.yaml
```

```yaml
network:
version: 2
renderer: NetworkManager
ethernets:
enp0s3:
dhcp4: false
addresses: [192.168.122.250/24]
nameservers:
addresses: [192.168.122.1,192.168.122.2]
gateway4: 192.168.122.1
```