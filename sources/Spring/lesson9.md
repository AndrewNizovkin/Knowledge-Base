# 9.Spring Cloud. Микросервисная архитектура.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5744429/attachment/f4d01233f4bf9384412eebe72138eb8d.pdf)

Микросервис — Это подход к разработке программного обеспечения, при котором
приложение состоит из мелких, независимых компонентов, работающих вместе.

Zuul Proxy — Используется в Spring Cloud в качестве маршрутизатора и
прокси-сервера между клиентом и микросервисами.

Eureka Server — Сервис от Netflix, интегрированный в Spring Cloud, который
предоставляет сервис обнаружения, где микросервисы могут регистрироваться и
находить друг друга.

Spring Cloud Config Server — Централизованный сервер для управления
конфигурациями микросервисов через все окружения.

Load Balancing — Распределение входящего трафика между множеством серверов
или микросервисов.

Feign Client — Декларативный web-клиент от Netflix, интегрированный в Spring Cloud, который упрощает написание кода для взаимодействия с другими микросервисами.

Hystrix — Библиотека от Netflix, интегрированная в Spring Cloud, предоставляющая
латентное и отказоустойчивое выполнение.

Circuit Breaker Pattern — Подход, который позволяет системе продолжать работу,
даже когда часть необходимых сервисов временно недоступна.

Spring Cloud Bus — Механизм, который соединяет различные узлы микросервисного комплекса с легкостью и доступностью облачного средства.

Service Mesh — Подход к управлению и контролю трафика между микросервисами.

API Gateway — Сервер, который является точкой входа в микросервисную
архитектуру и маршрутизирует запросы к соответствующим службам.

Service Registry & Discovery — Механизм для автоматической регистрации и
обнаружения микросервисов в среде.

Distributed Tracing — Подход к мониторингу запросов в микросервисной
архитектуре, позволяющий отслеживать выполнение запроса через все
микросервисы.

Spring Cloud Stream — Фреймворк для создания приложений для обработки
потоковых данных с использованием Spring Boot.

Spring Cloud Data Flow — Инструмент для оркестровки приложений потоковых
данных на основе Spring Cloud Stream

# Компоненты Spring Cloud

1. Spring Cloud Config: Этот компонент управляет внешними настройками для
приложений во всех окружениях. Представьте, что у вас есть универсальный
пульт управления для всех настроек ваших микросервисов!
2. Spring Cloud Netflix: На самом деле это набор подпроектов, вдохновленных Netflix OSS. К нему относятся:
– Eureka для обнаружения сервисов.
– Hystrix для контроля над временем ожидания между микросервисами и обработки сбоев.
– Zuul для маршрутизации и фильтрации на уровне API.
3. Spring Cloud Gateway: Это более современный маршрутизатор на основе
Spring, который можно использовать в качестве альтернативы Zuul.
4. Spring Cloud Bus: Этот компонент использует легковесные брокеры сообщений (часто
с помощью RabbitMQ или Kafka) для обмена информацией между различными
частями системы.

## Eureka

это система обнаружения сервисов, которую можно представить как “телефонную книгу” для ваших микросервисов. Когда микросервис запускается, он регистрируется в Eureka, сообщая ей: “Привет, я здесь, и вот мой адрес!”. Теперь,когда другой микросервис хочет общаться с ним, он просто спрашивает Eureka: “Где мой друг, микросервис X?” Eureka, в свою очередь, предоставляет адрес нужного микросервиса, и взаимодействие может начаться.

Eureka состоит из двух основных компонентов:

1. Eureka Server: Это центральное место, где хранится информация обо всех
зарегистрированных микросервисах. Можно представить его как
“центральную телефонную книгу”.
2. Eureka Client: Это библиотека, которую включают в каждый микросервис.
Она позволяет микросервису регистрироваться в Eureka Server и
запрашивать информацию о других сервисах.

### Настройка Eureka Server

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
</dependency>
```

В вашем главном классе приложения добавьте аннотацию `@EnableEurekaServer:`

```java
@SpringBootApplication
@EnableEurekaServer
public class EurekaServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(EurekaServerApplication.class, args);
	}
}
```

Настройте application.properties или application.yml:

```java
server.port=8761
eureka.client.register-with-eureka=false
eureka.client.fetch-registry=false

```

Теперь, запустив приложение, у вас будет работающий сервер Eureka на порту 8761.

### Регистрация микросервиса как Eureka Client

Чтобы ваш микросервис мог регистрироваться на сервере Eureka, выполните следующие шаги:

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

 В вашем главном классе приложения добавьте аннотацию @EnableEurekaClient:

```java
@SpringBootApplication
@EnableEurekaClient
public class MyMicroserviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(MyMicroserviceApplication.class, args);
	}
}
```

В конфигурационном файле укажите адрес сервера Eureka:

```java
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
```

Теперь, каждый раз когда вы запускаете свой микросервис, он автоматически регистрируется на сервере Eureka.

## Zuul

это API Gateway, что в переводе можно назвать “шлюзом для API”. Его задача — быть первой точкой взаимодействия между пользователями (или другими сервисами) и вашими микросервисами.

1. Маршрутизация: Zuul определяет, к какому микросервису направить приходящий запрос. Это как навигатор, который знает кратчайший путь к нужному месту в замке.
2. Фильтрация: Zuul может обрабатывать запросы, прежде чем они достигнут
микросервиса. Это может включать в себя задачи аутентификации (проверка личности), авторизации (определение, что вы можете делать) или модификации запроса.
3. Защита: С помощью Zuul вы можете защитить свои микросервисы от вредоносных атак или нежелательного трафика, блокируя или ограничивая некоторые запросы.
4. Отказоустойчивость: Zuul может автоматически повторять запросы к другим экземплярам микросервиса, если первый экземпляр не отвечает. Это как если бы у вас было несколько дверей в одной комнате, и если одна дверь заблокирована, вы просто пользуетесь другой.

В основе работы Zuul лежат фильтры. Есть несколько типов фильтров:

- Пред-фильтры (Pre Filters): 
активируются до того, как запрос будет направлен к своему конечному месту назначения — к вашему микросервису. Они идеально подходят для задач, связанных с предварительной обработкой запросов. Пред-фильтры Zuul выполняются в  пределенном
порядке. Если один из фильтров решает, что запрос не должен быть обработан, остальные фильтры могут быть пропущены, и запрос будет немедленно отклонен.
- Фильтры маршрутизации (Route Filters): 
определяют путь, по которому будет направлен ваш запрос после того, как он был предварительно обработан. Их основная задача — прокладывать маршрут для каждого запроса к соответствующему микросервису или конечной точке.
- Пост-фильтры (Post Filters):
активируются после того, как запрос был обработан и получил ответ от микросервиса. Эти фильтры обычно используются для различных "постобработок" ответа перед его отправкой пользователю.

### Настройка Zuul как API Gateway

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-zuul</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

Активируем Zuul в вашем главном классе приложения, добавив аннотацию `@EnableZuulProxy`:

```java
@SpringBootApplication
@EnableZuulProxy
public class ZuulGatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(ZuulGatewayApplication.class, args);
	}
}
```

В конфигурационном файле укажите адрес сервера Eureka и задайте маршруты для Zuul:

```java
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
zuul.routes.myservice.url=http://localhost:8080
```

Теперь, любой запрос, приходящий на ваш Zuul Gateway по пути /myservice/**, будет перенаправлен на микросервис, который слушает на порту 8080

### Применение фильтров в Zuul

Создадим простой пред-фильтр, который логирует информацию о приходящем запросе.

```java
@Component
public class SimplePreFilter extends ZuulFilter {
	private static final Logger log = LoggerFactory.getLogger(SimplePreFilter.class);

	@Override
	public String filterType() {
		return "pre";
	}
	
	@Override
	public int filterOrder() {
		return 1;
	}

	@Override
	public boolean shouldFilter() {
		return true;
	}
	
	@Override
	public Object run() {
		RequestContext ctx = RequestContext.getCurrentContext();
		HttpServletRequest request = ctx.getRequest();
		log.info(String.format("%s request to %s", request.getMethod(),
		request.getRequestURL().toString()));
		return null;
	}
}
```

Теперь, каждый раз когда кто-то обращается к вашему API Gateway, этот фильтр будет записывать метод и URL запроса.

## Spring Cloud Config

предоставляет сервер и клиентский компоненты для централизованного управления внешними конфигурациями в распределенной системе.

Все ваши конфигурации (настройки для разных окружений, параметры, секреты) хранятся в одном месте, обычно в Git-репозитории. Таким образом, вы можете отслеживать изменения, вносить правки и даже использовать разные версии конфигурации.

Кроме того Spring Cloud Config позволяет динамически обновлять конфигурации и обеспечивает безопасное и шифрованное хранение данных.

### Настройка Config Server

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-config-server</artifactId>
</dependency>
```

 В главном классе приложения активируем Config Server с помощью аннотации:

```java
@SpringBootApplication
@EnableConfigServer
public class ConfigServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ConfigServerApplication.class, args);
	}
}
```

Укажем местоположение нашего Git-репозитория в application.properties или application.yml:

```java
spring.cloud.config.server.git.uri=URL_ВАШЕГО_РЕПОЗИТОРИЯ
```

### Использование Config Client

Чтобы ваш микросервис мог получать настройки из Config Server, выполните
следующие шаги:

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-config</artifactId>
</dependency>
```

Укажите в bootstrap.properties или bootstrap.yml местоположение вашего Config Server:

```xml
spring.cloud.config.uri=http://АДРЕС_ВАШЕГО_CONFIG_SERVER
```

Теперь, при старте, ваш микросервис будет подключаться к Config Server и получать
необходимые настройки.

### Обновление конфигурации в реальном времени

Для этого потребуется ещё одна зависимость:

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-bus-amqp</artifactId>
</dependency>
```

Теперь, когда вы измените что-то в вашем Git-репозитории с конфигурациями, достаточно отправить POST-запрос на `/actuator/bus-refresh` вашего микросервиса, и он подхватит новые настройки без перезапуска.

- Для использования этого эндпоинта вам также понадобится настроить Spring Cloud Bus и, например, RabbitMQ.
    
    

## Hystrix

это библиотека из мира Spring Cloud, которая предоставляет “обертку” вокруг ваших внешних вызовов. Эта обертка предотвращает сбои и предоставляет резервные стратегии. Если что-то идет не так, Hystrix может “переключить” вас на резервный план, чтобы ваше приложение продолжало работать.

Основные функции:

1. Обнаружение ошибок: Hystrix быстро определяет, когда внешний сервис начинает “хромать” или не отвечать.
2. Обход ошибок: Если внешний сервис не работает, Hystrix может автоматически переключить вас на “резервный” метод.
3. Ограничение потоков: Чтобы избежать перегрузки, Hystrix может ограничивать количество одновременных запросов к внешнему сервису.
4. Резервные стратегии: Hystrix позволяет настроить альтернативное поведение для сценариев, когда внешний сервис недоступен.
5. Мониторинг и метрики: С помощью Hystrix Dashboard вы можете отслеживать состояние всех ваших вызовов в реальном времени.

### Подключение Hystrix

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
```

### Активация Hystrix

В главном классе приложения добавь аннотацию @EnableCircuitBreaker:

```java
@SpringBootApplication
@EnableCircuitBreaker
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
```

### Защита метода с помощью Hystrix

Чтобы защитить метод `fetchData()`, используем аннотацию `@HystrixCommand`:

```java
@HystrixCommand(fallbackMethod = "defaultData")
public String fetchData() {
	// ... вызов внешнего сервиса
	return "Data from external service";
}

public String defaultData() {
	return "Default data";
}

/* Если вызов fetchData будет длиться слишком долго или завершится ошибкой,
Hystrix автоматически переключится на defaultData.
```

### Настройка Hystrix

Hystrix предоставляет множество настроек для тонкой настройки. Например, в
application.properties:

```java
hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds=2000
// Здесь мы устанавливаем тайм-аут для команд Hystrix по умолчанию в 2 секунды.
```

### Мониторинг с Hystrix Dashboard

```xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-hystrix-dashboard</artifactId>
</dependency>
```

Активируй Hystrix Dashboard:

```java
@SpringBootApplication
@EnableHystrixDashboard
public class DashboardApplication {

	public static void main(String[] args) {
		SpringApplication.run(DashboardApplication.class, args);
	}
}
```

Теперь вы можете открывать панель управления Hystrix по адресу /hystrix.

С помощью Hystrix вы не только защищаете ваше приложение от сбоев, но и получаете инструменты для мониторинга и диагностики проблем в реальном времени. Это делает вашу систему более устойчивой и надежной.

## **RabbitMQ**

https://habr.com/ru/companies/slurm/articles/684412/

В сложных системах, системах с вычислительными задачами, а также требующих гарантированной доставки важно организовать распределённую архитектуру и наладить коммуникацию между компонентами. Для решения задач с подобными вводными требованиями выбирают RabbitMQ — брокер сообщений с открытым исходным кодом.

**Брокеры сообщений** — посредники между сервисами. Они находятся в центре архитектуры и управляют потоками информации. Благодаря этому каждый сервис может послать сообщение другому сервису или целой группе сервисов. 

**RabbitMQ** — распределённый и горизонтально масштабируемый брокер сообщений. Упрощённо его устройство можно описать так:

- паблишер, который отправляет сообщения;
- очередь, где хранятся сообщения;
- подписчики, которые выступают получателями сообщений.

RabbitMQ передаёт сообщения между поставщиками и подписчиками через очереди. Сообщения могут содержать любую информацию, например, о событии, произошедшем на сайте.