# Лекция 5. Клиент/Сервер своими руками.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5716214/attachment/81d5af6d38d29dd33ca8c21fb8476b96.pdf)

## Работа в сети

@GerbertSchildt(гл. 23)

Всего портов 65536

Протокол TCP/IP резервирует первые 1024 порта для отдельных протоколов. В том числе:

- 21 - FTP
- 23 - Telnet
- 25 - электронная почта
- 43 - whois
- 80 - HTTP
- 443 - HTTPS
- 119 - netnews

Пакет [java.net](https://docs.oracle.com/javase/8/docs/api/java/net/package-summary.html) содержит множество полезных классов.

**Класс InetAddress**

этот класс служит для инкапсуляции как IP-адреса, так и его доменного имени. Для взаимодействия с этим классом используется имя IP-хоста.

Конструкторы отсутствуют. Фабричные методы:

```java
static InetAddress getLocalHost() throws UnknownHostException

static InetAddress getByName(String имя_хоста) throws UnknownHostException

static InetAddress[] getAllByName(String имя_хоста) throws UnknownHostException

static InetAddress getByAddress(?? IP_адрес) throws UnknownHostException
```

Методы экземпляра:

```java
boolean equals(Object другой) // Сравнивает адреса объектов

byte[] getAddress // массив байтов адреса

String getHostAddress()

String getHostName()

boolean isMulticastAddress() // если адрес групповой

```

**Класс Socket**

(клиентский сокет) предназначен для клиентов. Служит для подключения к серверным сокетам

```java
// Constructors

Socket(String имя_хоста, int порт) throws UnknownHostException

Socket(InetAddress IP-адрес, 
              int порт) 
       throws UnknownHostException

Socket(InetAddress address,
              int port,
              InetAddress localAddr,
              int localPort)
       throws IOException

// Methods

InetAddress getInetAddress()

int getPort() // удалённый порт. Если нет = 0

int getLocalPort() // локальный порт. Если нет = -1

InputStream getInputStream() throws IOException

OutputStream getOutputStream() throws IOException
..........

```

**Класс URL**

URL - унифицированный указатель ресурса

спецификация URL основывается на четырёх составляющих

Пример: [`http://www.HerbSchildt.com:80/index.html`](http://www.HerbSchildt.com:80/index.html) 

- http - сетевой протокол
- //www.HerbSchildt.com  - имя хоста или IP-адрес. Может отделяться справа “/”
- 80 - номер порта
- index.html - путь к файлу

```java
// Constructors

URL(String спецификатор_URL) throws MalformedURLException

URL(String имя_протокола, 
    String имя_хоста, 
    int порт) throws MalformedURLException

URL(String имя_протокола, 
    String имя_хоста, 
    String порт) throws MalformedURLException

// Methods

public URLConnection openConnection() throws IOException

public String getHost()

public String getPath()

public final Object getContent(Class<?>[] classes) throws IOException

.........
```

**Класс URLConnection**

Служит для доступа к атрибутам удалённого ресурса. Можно получить из экземпляра URL методом `openConnection()` 

```java
public int getContentLength()

public InputStream getInputStream() throws IOException

public OutputStream getOutputStream() throws IOException
.....
```

**Класс HttpURLConnection**

расширяет `URLConnection` . Чтобы получить, нужно вызвать метод `openConnection()` на объекте типа `URL` , но результат привести к типу `URLConnection` 

```java
public String getRequestMethod()

public static boolean getFollowRedirects()

public String getResponseMessage() throws IOException
.......
```

**Класс ServerSocket**

применяется для создания серверов, которые принимают запросы как от локальных, так и от удалённых клиентских программ, желающих установить соединение через открытые порты.

```java
// Constructors

ServerSocket(int port) throws IOException
.....

// Methods

public Socket accept() throws IOException 
// блокирующий вызов до начала соединения, а затем 
// возвращает обычный Socket, который служит для взаимодействия с клиентом
......
```

## **Дейтаграммы**

это порции данных, передаваемых между машинами.

Дейтаграммы реализуются в Java поверх сетевого протокола UDP с помощью двух классов `DatagramPacket`  (контейнер данных) и `DatagramSocket` (механизм для передачи и приёма пакетов типа `DatagramPacket` )

**Класс DatagramSocket**

Этот класс представляет сокет для отправки и получения пакетов дейтаграмм.

```java
// Constructors

public DatagramSocket(int port) throws SocketException
.......

// Methods

public void receive(DatagramPacket p) throws IOException

public void send(DatagramPacket p) throws IOException

public boolean isConnected()

public void close()
........
```

**Класс DatagramPacket**

Этот класс представляет пакет дейтаграмм.

```java
// Constructors

DatagramPacket(byte[] buf, int length)

DatagramPacket(byte[] buf,
 int length,
 InetAddress address,
 int port)
.......

// Methods

public InetAddress getAddress()

public byte[] getData()

public int getLength()

public void setAddress(InetAddress iaddr)

public void setData(byte[] buf)
.........

```