# 11.Spring Actuator. Настройка мониторинга с Prometheus и Grafana.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5744448/attachment/8925e68d7e9c9e690746a8cb11ca5374.pdf)

**Spring Actuator** — Модуль Spring Framework, предоставляющий различные
возможности мониторинга и управления приложением.

**Endpoints** — Эндпоинты предоставляют доступ к различным информационным и управляющим ресурсам в приложении. Примеры включают `/actuator/health`, `/actuator/metrics` и `/actuator/info`.

**Metrics** — Метрики представляют числовую информацию о работе приложения,
такую как использование памяти, количество HTTP-запросов и другие метрики
производительности.

**Health Indicator** — Компонент Spring Actuator, предоставляющий информацию о
состоянии приложения. Индикаторы здоровья могут определять, находится ли
приложение в рабочем состоянии.

**Custom Endpoints** — Spring Actuator позволяет создавать собственные эндпоинты,
что делает возможным добавление собственных метрик и управляющих операций.

**Prometheus** — это система мониторинга и алертинга с открытым исходным кодом,
которая используется для сбора и хранения временных рядов данных, таких как
метрики приложения.

**Prometheus Actuator** — Этот модуль Spring Actuator предоставляет интеграцию с
Prometheus. Он позволяет экспортировать метрики Spring Actuator в формате,
понятном Prometheus.

**Grafana** — это популярный инструмент для визуализации данных и построения
дашбордов для мониторинга.

**Data Source** — В контексте Grafana, источник данных (Data Source) представляет
собой источник, из которого Grafana извлекает данные для визуализации, включая
данные, собранные Prometheus.

**Dashboards** — Дашборды — это пользовательские интерфейсы в Grafana, на которых
можно создавать графики и панели для визуализации метрик и данных
мониторинга.

**Alerting** — Grafana также поддерживает систему алертинга, которая позволяет
настраивать оповещения на основе данных мониторинга.

**Query Language** — Grafana предоставляет язык запросов, который позволяет
выбирать и агрегировать данные из различных источников данных.

**Grafana Panels** — Графики, диаграммы и другие элементы визуализации данных,
размещенные на дашборде Grafana, называются панелями.

**Exporters** — Программные компоненты, которые предоставляют данные
мониторинга в формате, понятном системам мониторинга, такие как Prometheus.

## Spring Actuator

это подпроект Spring, который предоставляет готовые production-ready функции: метрики, мониторинг, даже некоторую информацию для отладки. Все эти данные предоставляются в виде RESTful сервиса, JMX бинов или даже через SSH.

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

Включаем эндпоинты. Для этого в `application.propetreis`:

```java
management.endpoints.web.exposure.include=env, prometheus, health, info, metrics
```

В вашем приложении теперь есть эндпоинты, такие как `/actuator/health`, `/actuator/info` , `/actuator/metrics` и так далее

Попробуйте зайти на http://localhost:8080/actuator/health и вы увидите JSON с информацией о состоянии вашего приложения.

- Знание и умение использовать Spring Actuator не просто «nice to have», это действительно «must-have» навык для серьезного бэкенд-разработчика.

## Эндпоинт Health

Когда вы отправляете GET-запрос на `/actuator/health`, вы получаете ответ в формате JSON, который может выглядеть примерно так:

```json
"status": "UP",
"components": {
	"db": {
		"status": "UP",
		"details": {
			// детали о состоянии базы данных
		}
	},
	"diskSpace": {
		"status": "UP",
		"details": {
			// детали о доступном дисковом пространстве
		}
	}
		// и так далее
	}
}
```

### Кастомизация эндпоинта Health

К примеру, создадим простой кастомный health indicator:

```java
@Component
public class MyHealthIndicator implements HealthIndicator {
	
	@Override
	public Health health() {
		// ваша логика проверки здесь
		if (someCheck()) {
			return Health.up().build();
		}
		return Health.down().withDetail("reason", "Тут причина проблемы").build();
	}
		
	public boolean someCheck() {
			// реализация проверки
			return true;
		}
}
```

## Эндпоинт Metrics

Он даст вам гораздо более детальную картину: сколько оперативной памяти используется, какова нагрузка на процессор, какие запросы к вашему API занимают больше всего времени, и так далее.

Для доступа к метрикам нужно отправить GET-запрос на `/actuator/metrics`

```json
{
	"name": "jvm.memory.used",
	"description": "The amount of used memory",
	"baseUnit": "bytes",
	"measurements": [
		{
			"statistic": "VALUE",
			"value": 550295
		}
	]
}
```

Эти данные можно использовать для анализа производительности, определения «узких мест» и планирования масштабирования.

### Кастомизация метрик

```java
@Autowired
private MeterRegistry meterRegistry;

public void someMethod() {
	// Ваш код
	// Увеличиваем счетчик на единицу
	meterRegistry.counter("my.custom.counter").increment();
}
```

Теперь эту метрику тоже можно увидеть, запустив GET-запрос на `/actuator/metrics/my.custom.counter`.

## Эндпоинт Info

эндпоинт Info является чем-то вроде визитной карточки вашего приложения. В ней вы можете указать всю базовую информацию: кто разработчик, какая версия, какие основные функции и так далее. Это очень полезно, когда у вас большой проект и куча людей работают над  разными частями.

Допустим, вы только что присоединились к разработке огромного проекта. Чтобы не запутаться во всех этих микросервисах, версиях и зависимостях, легче всего сходить на /actuator/info и быстро понять, что перед вами.

### Настройка

В `application.yml` добавить

```yaml
info:
  app:
    name: "My Cool App"
    version: "1.0.0"
    description: "This app does something awesome!"

```

Теперь, когда кто-то пошлет GET-запрос на `/actuator/info`, получит:

```json
{
	"app": {
		"name": "My Cool App",
		"version": "1.0.0",
		"description": "This app does something awesome!"
	}
}
```

В идеале, можно даже динамически генерировать некоторую информацию. Например, вы можете использовать переменные окружения или значения из других источников

## Эндпоинт Loggers

Эндпоинт Loggers позволяет вам управлять уровнями логирования для различных компонентов вашего приложения. Таким образом, вы можете подробно отслеживать только  те аспекты системы, которые вас интересуют, не засоряя логи лишней информацией.

Отправьте GET-запрос на /actuator/loggers и увидите список всех доступных логгеров с текущими уровнями логирования. Что-то вроде:

```json
{
	"levels": ["OFF", "ERROR", "WARN", "INFO", "DEBUG", "TRACE"],
	"loggers": {
		"ROOT": {
			"configuredLevel": "INFO"
		},
		"com.example": {
			"configuredLevel": "DEBUG"
		},
		// ...
	}
}
```

Теперь, чтобы изменить уровень логирования для определенного логгера, вам нужно будет отправить POST-запрос. Например, чтобы установить уровень DEBUG для com.example, отправьте POST-запрос на /actuator/loggers/com.example с JSON-телом:

```json
{
	"configuredLevel": "DEBUG"
}
```

Что это дает на практике?
Представьте, что у вас есть некая проблема в определенной части вашего приложения. Вместо того, чтобы рыться в куче логов, вы просто «подкручиваете громкость» для этой конкретной части и получаете всю нужную информацию, не теряясь в шуме остальных данных

С помощью Spring Actuator вы можете менять уровни логирования вашего приложения на лету, без перезагрузки.

Всё управляется через эндпоинт `/actuator/loggers`. Отправьте PUT-запрос с новым  уровнем логирования

```bash
curl -i -X POST -H 'Content-Type: application/json' -d '{"configuredLevel":
"DEBUG"}' http://localhost:8080/actuator/loggers/com.example.YourClass
```

### Хочу свой эндпоинт!

Ничего сложного. Для создания своего эндпоинта вам нужно определить класс и аннотировать его как `@Endpoint` или `@WebEndpoint`. Давайте пример:

```java
import org.springframework.boot.actuate.endpoint.annotation.Endpoint;
import org.springframework.boot.actuate.endpoint.annotation.ReadOperation;

@Endpoint(id = "myCustomEndpoint")
public class MyCustomEndpoint {
	
	@ReadOperation
	public CustomResponse customMethod() {
		return new CustomResponse("Everything is awesome!", 42);
	}
	
	public static class CustomResponse {
		private String message;
		private int number;
		// getters and setters
	}
}
```

Теперь, отправьте GET-запрос на /actuator/myCustomEndpoint, и вы увидите ваш собственный ответ. Какой-то JSON в духе {"message": "Everything is awesome!", "number": 42}

## JVM метрики в Spring Actuator: 
Пульс вашего Java-приложения

По умолчанию, если у вас настроен Spring Actuator, многие JVM метрики уже будут доступны через эндпоинт /actuator/metrics. Вы можете сделать GET-запрос к  `/actuator/metrics/jvm.memory.used`, чтобы узнать, сколько памяти используется, или к `/actuator/metrics/jvm.threads.daemon` для информации о демон-потоках. Результатом будет JSON с метриками:

```json
{
	"name": "jvm.memory.used",
	"description": "The amount of used memory",
	// ... more metadata and values
}
```

### HTTP метрики

Метрики по HTTP запросам помогут вам понять, как быстро ваше приложение отвечает, какие запросы наиболее часто выполняются, каковы времена их выполнения и многое другое. Это критически важно для определения узких мест в производительности и для понимания, как пользователи взаимодействуют с вашим приложением.

Spring Actuator предоставляет эндпоинт `/actuator/metrics/http.server.requests` для сбора данных о HTTP-запросах. Здесь вы можете увидеть различные метрики, такие как среднее время ответа (http.server.requests.seconds), количество запросов (count), и так далее.
Пример JSON ответа:

```json
{
	"name": "http.server.requests",
	"description": "HTTP Server Requests",
	// ... more data and values
}
```

Spring Actuator может интегрироваться с различными системами управления базами данных (DBMS), и в зависимости от вашей конкретной настройки, различные метрики будут доступны через эндпоинт /actuator/metrics. Например, если вы используете HikariCP как пул соединений, вы можете увидеть метрики типа hikaricp.connections.active или hikaricp.connections.idle. 

Пример JSON’а

```json
{
	"name": "hikaricp.connections.active",
	"description": "Active DB connections",
	// ... more data and values
}
```

## JMX

JMX, или Java Management Extensions, это стандартный механизм для мониторинга и управления ресурсами в Java. С помощью Actuator, вы можете легко экспортировать свои эндпоинты в JMX. Просто откройте application.properties и добавьте:

```java
management.endpoints.jmx.exposure.include=*
```

Теперь вы можете использовать JConsole или любой другой JMX-клиент для подключения к вашему приложению

Spring Actuator прекрасно интегрируется с облачными платформами типа AWS, Google Cloud и Azure. Это открывает перед вами совершенно новые возможности. Например, вы можете использовать AWS CloudWatch для сбора метрик или Azure Monitor для централизованного логирования и мониторинга.

## Системы мониторинга: Prometheus и Grafana

Ну и наконец, чтобы сделать вашу жизнь ещё проще, Spring Actuator можно без проблем подружить с Prometheus и Grafana. Prometheus будет собирать метрики, а Grafana превратит их в красивые и понятные графики. Конфигурация займет всего пару строк кода и немного времени.

В application.properties добавляем:

```java
management.metrics.export.prometheus.enabled=true
```

Запускаем Prometheus, указываем ему, где собирать данные, и вуаля, у вас есть супер-продвинутая система мониторинга!

## Micrometer

Micrometer — это фактически библиотека для сбора метрик, которую можно считать как SLF4J, но для метрик. Под капотом Spring Actuator, именно Micrometer обеспечивает все те красивые графики и числа, которые вы видите в своем мониторинговом решении.

Допустим, у вас есть REST-контроллер, и вы хотите замерить, как быстро
обрабатываются запросы. С Micrometer это становится проще простого. Добавьте
зависимость:

```xml
<dependency>
	<groupId>io.micrometer</groupId>
	<artifactId>micrometer-core</artifactId>
</dependency>
```

и в коде:

```java
import io.micrometer.core.instrument.MeterRegistry;

@RestController
	public class MyController {
	
	private final MeterRegistry meterRegistry;
	
	public MyController(MeterRegistry meterRegistry) {
		this.meterRegistry = meterRegistry;
	}
	
	@GetMapping("/hello")
	public String sayHello() {
		meterRegistry.counter("requests_to_hello").increment();
		// ваша логика
		return "Hello, World!";
	}
}
```

Теперь каждый раз, когда кто-то обращается к /hello, счётчик requests_to_hello увеличивается. А это уже дает вам возможность отслеживать активность и реагировать на изменения в поведении вашего приложения.

### Счетчики

Чтобы создать свою метрику, нам сначала нужен объект MeterRegistry. Этот объект уже настроен Spring Boot’ом и можно его просто заинжектить в ваш компонент или сервис.

```java
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;

@Service
pub1ic class MyService {
	private final Counter myCounter;
	
	public MyService(MeterRegistry meterRegistry) {
		myCounter = Counter.builder("my_custom_counter")
		.description("Counts something very important")
		.register(meterRegistry);
	}
	
	public void doSomethingImportant() {
		// Тут какая-то важная логика
		myCounter.increment();
	}
}
```

В этом примере, каждый раз когда вызывается метод doSomethingImportant,
счетчик my_custom_counter увеличивается на 1. Как видите, у нас есть полное
управление над именем и описанием метрики.

### Таймеры

Таймеры в Micrometer не просто замеряют время, они собирают статистику: минимальное, максимальное и среднее время, и так далее. Вот как можно использовать таймер:

```java
import io.micrometer.core.instrument.Timer;
// ...
	private final Timer myTimer;
	
	public MyService(MeterRegistry meterRegistry) {
		myTimer = Timer.builder("my_custom_timer")
		.description("Timing something very important")
		.register(meterRegistry);
	}
	
	public void doSomethingTimed() {
		myTimer.record(() -> {
		// Тут какая-то важная логика, время выполнения которой мы хотим замерить
	});
}
```

После этого в вашей системе мониторинга появятся графики, отражающие эту информацию. Супер удобно для оптимизации и отладки!

## Prometheus

Prometheus основан на концепции тайм-серий. Это значит, что он хранит значения
метрик во времени. Возьмем, к примеру, загрузку CPU. Не просто «а сейчас у нас
загрузка 90%», а «в 15:35 было 70%, в 15:40 – 80%, а в 15:45 – уже 90%». В итоге,
это дает возможность не просто смотреть на текущую ситуацию, но и анализировать
тренды.

Prometheus работает по принципу «пуллинга». Это значит, что он сам идет к вашему
приложению и забирает нужные метрики. Это немного отличается от других систем
мониторинга, где ваше приложение должно было бы «пушить» данные. В случае с
Prometheus, все, что нужно от вас, — это предоставить эндпоинт, по которому он
может забирать эти данные.

```java
<dependency>
	<groupId>io.micrometer</groupId>
	<artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
```

Это даст возможность Micrometer экспортировать метрики в формате, который сможет прочитать Prometheus.

Включим экспозицию метрик
Теперь, в application.properties или application.yml, добавим следующую строчку:

```java
management.endpoints.web.exposure.include=metrics,prometheus
```

Это включит экспозицию метрик и специальный эндпоинт для Prometheus.

### Настраиваем Prometheus

Скачайте Prometheus с официального сайта и распакуйте архив. В папке с Prometheus найдете файл prometheus.yml. Добавьте в него конфигурацию для вашего Spring приложения. Например:

```yaml
scrape_configs:
  - job_name: 'spring-actuator'
  metrics_path: '/actuator/prometheus'
  static_configs:
    - targets: ['localhost:8080']
```

Это скажет Prometheus, что нужно идти по адресу
http://localhost:8080/actuator/prometheus и забирать метрики оттуда.

### Открываем Prometheus UI

Для начала, давайте откроем веб-интерфейс Prometheus. Если вы все сделали правильно, он должен быть доступен по адресу [http://localhost:9090](http://localhost:9090/). Тут вы увидите поле для ввода запросов. Для проверки наших метрик введите, например, `http_server_requests_seconds_count` и нажмите «Execute». Если все настроено правильно, вы увидите данные о количестве HTTP-запросов к вашему приложению. Не забудьте, что эти данные будут аккумулироваться с течением времени, так что не пугайтесь, если сначала увидите небольшие числа.

### Curl or Postman для теста

Также вы можете использовать curl или Postman для отправки HTTP-запроса на ваш эндпоинт Prometheus в Spring приложении. Просто отправьте GET-запрос на http://localhost:8080/actuator/prometheus, и вы должны увидеть вывод в формате, который Prometheus может читать.

## Grafana для визуализации

Да, Prometheus UI неплох для быстрых проверок, но для полноценного мониторинга
лучше использовать Grafana. Я не буду вдаваться в подробности настройки Grafana
сейчас (об этом поговорим позже), но учтите, что после настройки источника
данных как Prometheus, вы сможете создать дашборды и графики на основе этих
метрик. Вот где уже можно будет разгуляться по полной программе!

Grafana и Prometheus работают в паре, как Бэтмен и Робин в мире мониторинга.
Если Prometheus отвечает за сбор данных, то Grafana превращает эти данные в
понятные и легко читаемые графики, диаграммы, и даже алерты. Вы можете
настроить Grafana так, чтобы она использовала Prometheus как источник данных, и
автоматически обновляла показатели в реальном времени.

### Запуск Grafana

Первое, что нужно сделать, это установить Grafana на ваш компьютер или сервер,
где у вас уже крутится Prometheus. Инструкции для разных ОС можно найти на
официальном сайте, но если вы используете Docker, дело сведется к одной
команде:

```bash
docker run -d -p 3000:3000 grafana/grafana
- targets: ['localhost:8080']
```

### Подключение к Prometheus

Теперь, открываем веб-интерфейс Grafana. По умолчанию это http://localhost:3000/.
Входите с помощью логина admin и пароля admin (менять его — хорошая идея).

Первым делом, давайте добавим Prometheus как источник данных. Заходим в
Settings > Data Sources > Add data source и выбираем Prometheus. В поле HTTP URL
вводим адрес, по которому доступен ваш Prometheus (обычно это
[http://localhost:9090](http://localhost:9090/)). Сохраняем и тестируем. Если все настроено правильно,
Grafana скажет, что все отлично.

## Spring Boot Admin

Spring Boot Admin — это мощный инструмент для мониторинга и управления Spring Boot приложениями. Это типа вашего персонального админ-панели, но круче. Если с Actuator вам нужно было лазить по эндпоинтам, то здесь все эти данные красиво и наглядно отображаются в UI.

1. Встроенный мониторинг: Метрики, логирование, информация о приложении
— все в одном месте. Не нужно заниматься настройкой, просто запускайте и
пользуйтесь.
2. Управление приложениями: Можете менять уровень логирования, смотреть
активные сессии и даже отправлять команды на управление приложением —
все через красивый и интуитивно понятный интерфейс.
3. Связь с Actuator: Да-да, Spring Boot Admin работает поверх Actuator, поэтому
все, что вы узнали про Actuator, здесь тоже применимо.
4. Уведомления: Встроенная система уведомлений позволит быть всегда в
курсе о состоянии ваших приложений.

1. Добавляем зависимость:

```bash
<dependency> 
	<groupId>de.codecentric</groupId>
	<artifactId>spring-boot-admin-starter-server</artifactId>
<version>2.5.1</version> </dependency
```

1. Настройка application.properties: Включаем админ-сервер. properties

```bash
spring.boot.admin.context-path=/admin
```

1. Регистрация приложений: Ваши микросервисы или приложения, которые вы хотите мониторить, должны быть зарегистрированы. Это тоже делается через простую настройку