# 12.Паттерны проектирования и GoF паттерны в Spring приложении.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5744457/attachment/aa0281224d1c27ecf6edb48091411562.pdf)

### Глоссарий

**Singleton (Одиночка)** — Гарантирует, что класс имеет только один экземпляр и предоставляет глобальную точку доступа к этому экземпляру. В Spring это может быть использовано для создания единственного экземпляра контейнера приложения (ApplicationContext).

**Factory Method (Фабричный метод)** — Позволяет создавать объекты, не указывая конкретный класс объекта. В Spring это видно в конфигурации бинов через XML-файлы или аннотации, где контейнер создает и возвращает бины.

Dependency Injection (Внедрение зависимостей) — Этот паттерн не из GoF, но он ключевой в Spring. Он обеспечивает инверсию управления и позволяет внедрять зависимости в бины. В Spring это достигается с помощью аннотаций `@Autowired` и конфигурации.

**Observer** (Наблюдатель) — Позволяет объектам следить и реагировать на изменения состояния других объектов. В Spring это может быть использовано в публикации событий и подписке на события через ApplicationEvent и ApplicationListener.

**Decorator** (Декоратор) — Позволяет добавлять новую функциональность существующим объектам без их изменения. В Spring это может быть использовано, например, для добавления аспектов (Aspects) к бинам.

**Proxy** (Заместитель) — Позволяет контролировать доступ к объекту, добавляя  дополнительную логику. В Spring это может использоваться для создания прокси-объектов для AOP (Аспектно-Ориентированное Программирование).

**Template Method** (Шаблонный метод) — Определяет скелет алгоритма, но делегирует некоторые шаги подклассам. В Spring это может быть видно в классах-родителях, которые предоставляют базовую логику для создания бинов.

## Архитектурные Паттерны

Они задаются вопросами типа: «Какие у нас будут основные компоненты системы?», «Как они будут взаимодействовать?» и «Как можно масштабировать это все дело?».

Примеры архитектурных паттернов:

- «Микросервисы»
- «MVC»
- «Event-Driven Architecture»

Event-driven архитектура — это концепция программирования, которая позволяет создавать сложные приложения, используя событийно-ориентированный подход. Основная идея заключается в том, что все действия в приложении основаны на событиях. Это позволяет создавать распределенные системы, которые **легко масштабируются** и обладают **высокой отказоустойчивостью**.

Event-driven архитектура – это подход, при котором программа отслеживает происходящие события и реагирует на них. Событие может быть любым действием пользователя, например, клик на кнопке, скроллинг страницы или ввод текста в поле. Однако event-driven архитектура может использоваться не только в пользовательских интерфейсах, но и в бэкенд-разработке.

## Паттерны Интеграций

Они предлагают проверенные способы, чтобы разные части приложения, такие как базы данных или внешние сервисы и API могли не только общаться друг с другом, но и делать это эффективно.

## Паттерны Безопасности

Паттерны безопасности в первую очередь нужны для того, чтобы уберечь ваше приложение от различных угроз. Мы говорим о защите данных, аутентификации, авторизации, шифровании и прочих важных аспектах, которые обеспечивают надежную работу системы.

## Структурные GoF Паттерны

(Gang of Four) Это паттерны, которые помогают разным компонентам системы лучше сочетаться и взаимодействовать. В контексте Spring это особенно актуально, потому что здесь мы работаем с большим количеством разнородных бинов и компонентов.

### Adapter: Переводчик между двумя Мирами

Итак, поговорим про один из самых популярных структурных паттернов — Adapter. Представьте, что у вас есть два класса с разными интерфейсами, которые нужно как-то заставить работать вместе. Adapter в этом случае выступает как переводчик между ними.

```java
// Сторонний класс, который мы не можем изменить
public class ThirdPartyLibrary {
	public void doSomethingSpecific() {
		// логика
	}
}

// Наш интерфейс
public interface OurInterface {
	void doSomething();
}

// Adapter
public class Adapter implements OurInterface {
	
	private ThirdPartyLibrary thirdPartyLibrary;
	
	public Adapter(ThirdPartyLibrary thirdPartyLibrary) {
		this.thirdPartyLibrary = thirdPartyLibrary;
	}
	public void doSomething() {
		thirdPartyLibrary.doSomethingSpecific();
	}
}

/*
Здесь Adapter реализует OurInterface и адаптирует методы ThirdPartyLibrary под наш
интерфейс. В Spring, вы можете сделать этот адаптер бином и внедрить его там, где
нужно использовать OurInterface.
```

### Bridge: Разделяй и Властвуй

Этот паттерн помогает разделить абстракцию от реализации, так что обе стороны могут изменяться независимо друг от друга. В Spring это полезно, когда у вас есть разные реализации одного и того же интерфейса и вы хотите динамически переключаться между ними.

```java
public interface Logger {
	void log(String message);
}

public class ConsoleLogger implements Logger {
	public void log(String message) {
		System.out.println("Console: " + message);
	}
}

public class FileLogger implements Logger {
	public void log(String message) {
		// логика записи в файл
	}
}

public class App {
	
	private Logger logger;
	
	public App(Logger logger) {
		this.logger = logger;
	}
	
	public void doSomething() {
		logger.log("Doing something");
	}
}
/*
Так, у нас есть интерфейс Logger и две его реализации. В App мы можем
динамически изменить реализацию Logger, не затрагивая остальной код.
Используйте Spring для управления этими бинами, и ваш код станет намного гибче.
```

### Composite: Один за Всех и Все за Одного

Этот паттерн позволяет считать единичный объект и композицию объектов одинаково. Круто для работы с деревьями или графами в Spring!

```java
public interface Graphic {
	void draw();
}

public class Circle implements Graphic {
	public void draw() {
		// рисуем круг
	}
}

public class GraphicComposite implements Graphic {

	private List<Graphic> graphics = new ArrayList<>();

	public void addGraphic(Graphic graphic) {
		graphics.add(graphic);
	}
	
	public void draw() {
		for (Graphic graphic : graphics) {
			graphic.draw();
		}
	}
}
/*
Здесь GraphicComposite может содержать как отдельные Graphic элементы, так и
другие GraphicComposite, создавая таким образом дерево или граф. С такой
структурой удобно работать в Spring, особенно если у вас есть иерархические
данные или сложные структуры.
```

## Порождающие паттерны

### Singleton

Он гарантирует, что класс имеет только один экземпляр и предоставляет глобальную точку доступа к этому экземпляру. В контексте Spring это особенно актуально, потому что Spring по умолчанию создает все бины как Singleton.

```java
@Service
public class SingletonService {
	
	private static SingletonService instance;
	
	private SingletonService() {
	}
	
	public static SingletonService getInstance() {
		if (instance == null) {
			instance = new SingletonService();
		}
		return instance;
	}
}

/*
Однако, давайте будем честными: в Spring вам редко придется самостоятельно
реализовывать Singleton, потому что Spring делает это за вас. Определите бин, и вот,
он уже Singleton!
*/
@Service
public class AutomaticallySingletonService {
	// Этот бин будет Singleton по умолчанию, благодаря Spring
}
```

### Factory Method в Spring

Factory Method стоит использовать, когда у вас есть класс с несколькими подклассами, и на основе входных данных нужно вернуть один из этих подклассов. Это особенно полезно, когда вы хотите обеспечить гибкость и расширяемость вашего приложения. Суть в том, чтобы делегировать логику создания объекта самому классу или его подклассам

```java
public interface PaymentService {
	void pay();
}

@Service("paypal")
public class PaypalPaymentService implements PaymentService {
	//...
}

@Service("creditCard")
public class CreditCardPaymentService implements PaymentService {
	//...
}

@Component
public class PaymentServiceFactory {
	
	@Autowired
	private Map<String, PaymentService> services;
	
	public PaymentService getService(String method) {
		return services.get(method);
	}
}
```

### Prototype: Клонируем с умом

Противоположность Singleton — это Prototype, паттерн, который создаёт новый экземпляр класса каждый раз, когда вы его запрашиваете. Это может быть полезно, когда объекты имеют много внутреннего состояния, которое не должно быть общим.
В Spring для этого есть аннотация @Scope("prototype").

```java
@Service
@Scope("prototype")
public class PrototypeService {
	// Каждый раз при запросе будет создан новый экземпляр этого бина
}
/*
В отличие от Singleton, вам придётся чаще взаимодействовать с Prototype в вашем
коде, потому что Spring не будет управлять жизненным циклом этих бинов за вас.
```

## Поведенческие паттерны

### Observer

— это поведенческий паттерн, который предполагает, что у вас есть объект (назовем его «Субъект») и множество «Наблюдателей». Каждый раз, когда в Субъекте происходит какое-то изменение, все его Наблюдатели автоматически получают уведомление.

```java
// 1. Создадим событие
public class TaskUpdatedEvent extends ApplicationEvent {
	
	private Task task;
	
	public TaskUpdatedEvent(Object source, Task task) {
		super(source);
		this.task = task;
	}
	
	// getters
}

// 2. Реализуем слушатель
@Component
public class TaskUpdatedListener implements
	ApplicationListener<TaskUpdatedEvent> {

	@Override
	public void onApplicationEvent(TaskUpdatedEvent event) {
		// Сделать что-то с event.getTask()
	}
}

// 3. Опубликуем событие, когда задача обновляется
@Service
public class TaskService {

	@Autowired
	private ApplicationEventPublisher publisher;
	
	public void updateTask(Task task) {
		// обновляем задачу
	publisher.publishEvent(new TaskUpdatedEvent(this, task));
	}
}
/*
Теперь каждый раз, когда метод updateTask() вызывается, все слушатели,
подписанные на TaskUpdatedEvent, будут уведомлены.
Таким образом, Observer в Spring это не просто хороший стиль программирования.
Это еще и мощный инструмент для создания расширяемых и поддерживаемых
систем.
```

### Strategy

Этот паттерн призван решить проблему выбора алгоритма во время выполнения программы. Например, у нас есть интернет-магазин, и мы хотим предложить пользователям разные способы оплаты: карточкой, PayPal, криптовалютой и так далее. 

В Spring, применение Strategy выглядит как-то так:

```java
// 1. Создаём интерфейс для стратегии
public interface PaymentStrategy {
	void pay(int amount);
}

// 2. Реализуем конкретные стратегии
public class CardPayment implements PaymentStrategy {
	public void pay(int amount) {
		// Реализация оплаты через карточку
	}
}

public class PayPalPayment implements PaymentStrategy {
	public void pay(int amount) {
		// Реализация оплаты через PayPal
	}
}

// 3. Используем их
@Service
public class PaymentService {
	
	private PaymentStrategy paymentStrategy;
	
	public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
		this.paymentStrategy = paymentStrategy;
	}
	
	public void pay(int amount) {
		paymentStrategy.pay(amount);
	}
}
/*
Таким образом, мы можем легко подменять алгоритмы оплаты без изменения
основного кода.
```

### Command

Этот паттерн реализует идею оборачивания запросов или простых операций в объекты. Это особенно удобно, когда у вас есть какие-то операции, которые нужно выполнять асинхронно, или, скажем, отменять.
В контексте Spring, использование Command выглядит примерно так:

```java
public interface Command {
void execute();
}

public class StartCommand implements Command {
	public void execute() {
		// Запуск чего-либо
	}
}

public class StopCommand implements Command {
	public void execute() {
		// Остановка чего-либо
	}
}

@Service
public class CommandExecutor {
	
	private Command command;
	
	public void setCommand(Command command) {
		this.command = command;
	}
	
	public void runCommand() {
		command.execute();
	}
}
/*
Теперь, не зависимо от того, что именно нам нужно сделать, мы просто подставляем
нужный объект команды и вызываем execute(). Это делает код намного чище и
понятнее.
```

## Архитектурные паттерны

### MVC( Model-View-Controller)

Этот паттерн особенно важен, когда у нас есть какой-то интерфейс пользователя или API.

### Microservices

Этот архитектурный паттерн предлагает разбить большое, монолитное приложение на множество маленьких, независимых сервисов. Каждый такой сервис делает что-то одно, но делает это хорошо.

Каждый микросервис можно разрабатывать, развертывать и масштабировать независимо от других. Это упрощает разработку и поддержку. Команда разработчиков на один микросервис может быть меньше, и это позволяет быстрее итерировать и внедрять нововведения.

## Паттерны интеграций

### Message Bus

Этот паттерн позволяет различным компонентам (или даже разным приложениям) общаться друг с другом, не зная деталей реализации каждого.

Spring Framework предлагает для этих целей проект под названием Spring Integration. С его помощью можно легко реализовать Message Bus в вашем приложении

```java
@EnableIntegration
public class AppConfig {

	@Bean
	public MessageChannel messageChannel() {
		return new DirectChannel();
	}
	
	@ServiceActivator(inputChannel = "messageChannel")
	@Bean
	public MessageHandler messageHandler() {
		return message -> System.out.println("Received message: " + message);
	}
}
/*
В этом примере у нас есть канал сообщений messageChannel, и обработчик этих
сообщений messageHandler. Все, что вам нужно сделать, это отправить сообщение в
этот канал, и Spring Integration позаботится о дальнейшей его доставке.
```

### Publish/Subscribe

это паттерн, где одна часть вашего приложения (издатель) отправляет сообщения, а другие части (подписчики) их принимают. И самое крутое — издатель не знает о существовании подписчиков, и подписчики могут подписываться и отписываться на лету.

Spring предоставляет класс ApplicationEventPublisher для реализации Pub/Sub.

```java
@Component
public class Publisher {
	
	@Autowired
	private ApplicationEventPublisher publisher;
	
	public void doStuffAndPublishEvent() {
		// Делаем что-то полезное
		publisher.publishEvent(new MyCustomEvent(this, "Event message"));
	}
}

@Component
public class Subscriber implements ApplicationListener<MyCustomEvent> {
	
	@Override
	public void onApplicationEvent(MyCustomEvent event) {
		System.out.println("Received: " + event.getMessage());
	}
}
/*
Здесь у нас есть издатель, который отправляет MyCustomEvent, и подписчик,
который этот MyCustomEvent получает и обрабатывает
```

## Паттерны безопасности

### Singleton Security Context

В других словах, весь ваш код будет обращаться к одному и тому же «хранилищу» для проверки прав доступа, ролей и так далее. Это обеспечивает унификацию и согласованность данных о безопасности на всем протяжении жизненного цикла приложения.

В Spring Security вы можете увидеть этот паттерн в действии. Контекст безопасности хранится в SecurityContextHolder

```java
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityService {
	
	public void performSecureAction() {
	
	var authentication = SecurityContextHolder
	                    .getContext()
	                    .getAuthentication();
	if (authentication != null &&
		"ROLE_ADMIN".equals(authentication.getAuthorities())) {
		// Выполняем какое-то действие
	} else {
		throw new SecurityException("Недостаточно прав!");
	}
	}
}
/*
Здесь SecurityContextHolder действует как Singleton, храня контекст безопасности. И
каждый раз, когда нам нужно что-то проверить, мы просто обращаемся к нему.
```

### Sharding

это техника, при которой ваша база данных делится на меньшие, более управляемые части, называемые шардами. Каждый шард работает независимо, что позволяет улучшить производительность, масштабируемость и управляемость базы данных. В двух словах, это как класть книги не в одну огромную коробку, а распределить их по меньшим коробкам, чтобы было проще найти нужную.

```java
/* Код только для иллюстрации, Spring Data JPA не предоставляет нативную
поддержку шардинга */
public class OrderService {
	
	public void saveOrder(Order order) {
	
		// Определение шарда на основе ID пользователя
		String shard = shardResolver.resolveShard(order.getUserId());
		
		// Сохранение заказа в соответствующем шарде
		orderRepository.saveToShard(shard, order);
	}
}
```

### Leader Election

В системе с несколькими узлами Leader Election помогает автоматически выбрать один узел, который будет выполнять специфические задачи. Этот узел становится «лидером», а остальные узлы становятся «подчиненными» и выполняют действия согласно указаниям лидера.

В Spring Cloud Cluster представлены абстракции для реализации Leader Election. Обычно этот паттерн активно используется в системах, работающих с консенсусными алгоритмами, такими как Paxos или Raft.

```java
@Service
public class LeaderService implements SmartLifecycle {
	
	private boolean isRunning = false;
	
	@Autowired
	private LeaderInitiator leaderInitiator;
	
	@Override
	public void start() {
		isRunning = true;
		leaderInitiator.start(); // Инициация процесса выбора лидера
		}
	// ...
}
```

eargf