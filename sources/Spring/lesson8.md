# 8.Spring AOP. Управление транзакциями.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5643816/attachment/60f9bf48666048cdcbf00dcf14c9bf5e.pdf)

[Документация по Propogation, Isolation](https://www.baeldung.com/spring-transactional-propagation-isolation)

Aspect – модуль, который определяет Advices, срезы и привязки. Это
кросс-функциональные заботы, такие как логирование, аудит, безопасность и т. д.

Join Point – точка в программе, такая как выполнение метода, где можно применить
Advices (advice). В Spring AOP, join points представляют собой выполнение методов.

Advice – действие, предпринимаемое аспектом в определенной точке соединения.
Существуют разные типы Advices, такие как before, after, after-returning,
after-throwing, и around.

Pointcut – выражение, которое выбирает определенные join points. Advices
применяются к join points, выбранным через pointcuts.

Target – объект, к которому применяется Advices.

Proxy – объект, созданный после применения Advice к целевому объекту.

Weaving – процесс комбинирования аспектов с другим типом приложения для
создания прокси-объекта. Это может быть выполнено во время компиляции (CTW),
загрузки класса (LTW) или во время выполнения.

Introduction (Inter-type declaration) – добавление новых методов или свойств в
существующие классы.

Транзакция – последовательность действий, которые либо полностью
выполняются, либо полностью отменяются.

ACID – принципы транзакций — Атомарность, Согласованность, Изоляция и
Долговечность (Atomicity, Consistency, Isolation, Durability).

Propagation – определяет, как транзакции относятся к друг другу. Например,
REQUIRED, REQUIRES_NEW, SUPPORTS и т. д.

Isolation – уровень изоляции транзакции определяет, как данные, доступные одной
транзакции, становятся видимыми для других.

@Transactional – аннотация Spring для объявления транзакционного метода.

Transaction Manager – компонент, который управляет транзакциями. Например,
DataSourceTransactionManager для JDBC.

Rollback – отмена изменений, выполненных в рамках транзакции.

# Spring AOP (Aspect-Oriented Programming)

Аспекты в Spring AOP — это способ организовать “сквозную” функциональность в
вашем приложении без необходимости менять основной код. Это как магические
стикеры, которые вы можете приклеить к любой части вашего кода, чтобы добавить
дополнительное поведение или функциональность.

```xml
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-aop</artifactId>
		</dependency>

```

### Компоненты аспектов.

Основные из них — это Advices, Introductions и Around-Advices.

1. **Advices**
Advice – это действие, которое выполняется аспектом в определенное время
(например, перед или после выполнения метода). В Spring AOP существует
несколько типов Advices, включая:

• Before Advice: Выполняется до целевого метода. Примером может служить
логирование или проверка прав доступа.
*Пример. Логирование методов:*

В этом примере `@Before` говорит о том, что аспект должен выполняться перед
вызовом метода, а выражение в `execution()` указывает на то, какие именно методы
нужно “перехватить”. В данном случае перехватываются все методы из всех
классов в пакете *com.example.service*. `JoinPoint` это интерфейс описывающий метод к которому обращается advice

```java
@Aspect
@Component
public class LoggingAspect {
	
	@Before("execution(* com.example.service.*.*(..))")
	public void logBeforeMethodCall(JoinPoint joinPoint) {
			System.out.println("Метод " + joinPoint.getSignature().getName() + "
			был вызван");
	}
}
```

• After Returning Advice: Выполняется после того, как целевой метод успешно
завершил свою работу (без исключений). Можно использовать для
дополнительной обработки результата метода.

*Пример. Изменение возвращаемого значения.*

С помощью атрибута `returning`, мы указываем, что хотим получить возвращаемое
значение метода и использовать его в нашем advice.

В этом примере после вызова метода getName из пакета *com.example.service*, его
возвращаемое значение будет изменено на “Измененное имя”.

```java
@Aspect
@Component
public class ChangeReturnValueAspect {
	
	@AfterReturning(pointcut = "execution(* com.example.service.getName(..))",
	returning = "result")
	public void changeName(JoinPoint joinPoint, String result) {
			result = "Измененное имя";
	}
}
```

• After Throwing Advice: Выполняется, если во время выполнения метода
возникло исключение.
*Пример . AfterThrowing Advice*

```java
@Component
@Aspect
public class PaymentAspect {

	@AfterThrowing(pointcut = "execution(* com.example.service.PaymentService.processPayment(..))", 
                           	throwing = "exception")
	public void logPaymentError(Exception exception) {
		System.out.println("Произошла ошибка при обработке платежа: " +
		exception.getMessage());
	}
}
/*
Здесь execution(* com.example.service.PaymentService.processPayment(..)) — это
точка соединения (pointcut). Атрибут throwing позволяет нам захватить исключение,
выброшенное целевым методом, и использовать его в нашем advice.
*/
```

• After (or After Finally) Advice: Выполняется в любом случае после вызова
метода, независимо от того, было ли исключение или нет.
Все эти advices позволяют нам вмешиваться в жизненный цикл вызова метода на
разных этапах.

1. Around-Advices
Around-Advice — это, пожалуй, самый мощный тип advice. Он объединяет в себе все
остальные типы advices, так как позволяет вам вмешиваться в вызов метода до его
выполнения, после него и даже изменять возвращаемое значение или кидать
исключение вместо целевого метода

Пример. Измерение времени выполнения:

```java
@Aspect
@Component
public class PerformanceAspect {
	
	@Around("execution(* com.example.service.*.*(..))")
	public Object measureMethodExecutionTime(ProceedingJoinPoint joinPoint) 
																						throws Throwable {
		
		long start = System.currentTimeMillis();
		
		Object result = joinPoint.proceed();
		
		long elapsedTime = System.currentTimeMillis() - start;
		
		System.out.println("Метод " + joinPoint.getSignature().getName() + "
		выполнился за " + elapsedTime + " миллисекунд");
		
		return result;
	}
}
/* Здесь метод joinPoint.proceed() вызывает целевой метод. Время, 
затраченное на его выполнение, измеряется и выводится в консоли.
```

Почему это может быть полезно?

- Измерение времени выполнения метода.
- Транзакционное управление.
- Изменение аргументов или возвращаемого значения метода.
- Предотвращение вызова целевого метода под определенными условиями.

1. Introductions
Introduction (или “Mixin”) позволяет добавлять новые методы или свойства в существующие бины. Другими словами, с помощью introductions вы можете добавить новую функциональность к уже существующим объектам в вашем приложении без изменения их кода. Они дают возможность объекту реализовывать интерфейс, который изначально он не реализовывал.

Допустим, у нас есть следующий интерфейс:

```java
public interface Flyer {
void fly();
}
```

И у нас есть класс Car, который, естественно, изначально не умеет летать:

```java
public class Car {
	public void drive() {
		System.out.println("Car is driving...");
	}
}
```

Теперь, используя Introductions, мы можем “научить” Car летать:

```java
@Aspect
public class FlyerIntroduction {
	
	@DeclareParents(value = "com.example.Car", defaultImpl = 	FlyingImpl.class)
		public static Flyer flyer;
	}
	
```

```java
public class FlyingImpl implements Flyer {
	@Override
	public void fly() {
		System.out.println("Car is now flying!");
	}
}
```

Теперь каждый объект класса Car также будет реализовывать интерфейс Flyer, и вы
сможете вызывать метод fly() для него!

Introductions могут быть полезны в ряде сценариев:

- Переиспользование кода: Вместо дублирования методов в разных классах,
вы можете использовать Introductions, чтобы предоставить общую
функциональность.
- Постепенное внедрение новых возможностей: Если вы хотите добавить
новую функцию в ряд объектов, но не хотите изменять их базовый код,
Introductions — ваш выбор.
- Работа с сторонними библиотеками: Иногда у вас есть библиотека, и вы
хотели бы добавить ей новые возможности, но у вас нет доступа к исходному
коду. С помощью Introductions вы можете “расширить” функциональность
этой библиотеки.

## Join Points

— это место в программе, где аспект может быть применен. Это может быть при вызове метода, при обработке исключения, при инициализации объекта и так далее. Join Points обозначают конкретные моменты в выполнении программы, когда можно “вмешаться” с помощью аспектов.

Наиболее распространенным типом Join Point является момент, когда метод вызывается.

### Определение Join Points

Для того чтобы определить, где именно ваш аспект должен “вступать в игру”, вы
используете выражения Pointcut. Эти выражения позволяют вам выбирать, на какие
методы, классы или даже пакеты должен реагировать ваш аспект.

Применение аспекта ко всем методам в классе

```java
@Aspect
@Component
public class MyAspect {

	@Before("execution(* com.example.service.MyService.*(..))")
	public void beforeAnyMethodInMyService() {
		System.out.println("Вызван метод в MyService!");
	}
}
/**
В данном примере execution(* com.example.service.MyService.*(..)) — это Pointcut
выражение. Оно говорит Spring AOP применить аспект перед выполнением любого
метода (.*(..)) в классе MyService
```

Применение аспекта ко всем методам в пакете:

```java
@Aspect
@Component
public class MyAspect {

	@Before("execution(* com.example.service.*.*(..))")
	public void beforeAnyMethodInServicePackage() {
		System.out.println("Вызван метод в пакете service!");
	}
}
```

Применение аспекта к конкретным методам:

```java
@Aspect
@Component
public class MyAspect {

	@Before("execution(* com.example.service.MyService.specificMethod(..))")
	public void beforeSpecificMethod() {
		System.out.println("Вызван конкретный метод specificMethod!");
	}
}
```

## Pointcut Expressions

https://docs.spring.io/spring-framework/reference/core/aop/ataspectj/pointcuts.html

В мире Spring AOP Pointcut Expressions позволяют вам точно определить, на какие
методы, классы или даже пакеты будет реагировать ваш аспект.

Базовый формат Pointcut выглядит так:

```java
execution(модификатор_доступа возвращаемый_тип имя_пакета.имя_класса.имя_метода(параметры))
```

Чтобы не прописывать pointcat для каждого advice делают так:

```java
    @Pointcut("execution(* ru.gb.springbootlesson8.MyServiceBean.*(..))")
    public void myServiceBeanMethods(){}
    
    // теперь этот pointcat можно использовать:

    @Before("myServiceBeanMethods()")
    public void before(JoinPoint joinPoint){
        System.out.println("args: " + Arrays.toString(joinPoint.getArgs()));
    }
```

poincats можно объединять с помощью логических операторов ||, &&

Выбор всех методов:

```java
@Pointcut("execution(* *.*(..))")
private void selectAllMethods() {}
//Здесь * *.*(..) означает “любой метод любого класса с любыми аргументами”.
```

Выбор методов по имени:

```java
@Pointcut("execution(* *.set*(..))")
private void selectAllSetters() {}
/* Здесь мы используем шаблон set* для выбора всех методов, 
которые начинаются на “set”.
```

Выбор методов по параметрам:

```java
@Pointcut("execution(* *.find*(String))")
private void selectAllStringFinders() {}
/*Этот Pointcut выберет все методы, начинающиеся на “find” 
и принимающие один параметр типа String.
```

### Дополнительные Pointcut выражения

Pointcut не ограничивается только модификатором execution. Есть и другие, например:

- within(): ограничивает матчинг методов в определенных классах или пакетах.

```java
@Pointcut("within(com.example.service.*)")
private void allMethodsInService() {}
```

- this(): ограничивает матчинг методов, где прокси-объект имеет заданный тип.
- target(): ограничивает матчинг методов, где целевой объект (реальный объект, а не прокси) имеет заданный тип.
- args(): ограничивает матчинг методов, где аргументы имеют заданные типы

```java
@Pointcut("args(String,..)")
private void methodsWithStringFirstArg() {}
```

- @annotation(): реагирует на методы, которые имеют определенную аннотацию.

```java
@Pointcut("@annotation(com.example.annotations.MyCustomAnnotation)")
private void methodsWithMyCustomAnnotation() {}
```

## Как управлять порядком Advices в Spring AOP

Spring предоставляет механизм, который называется “заказной номер” или Order. Каждый аспект может иметь свой заказной номер, который определяет его приоритет при выполнении. Чем меньше число, тем выше приоритет, и тем раньше будет выполнен аспект.

Пример:

```java
@Aspect
@Order(1)
public class SecurityAspect {
  // код аспекта безопасности
}

@Aspect
@Order(2)
public class LoggingAspect {
  // код аспекта логирования
}

/* SecurityAspect будет выполнен перед LoggingAspect, потому что его
Order равен 1, что меньше, чем у LoggingAspect.
```

Если у нас есть несколько Advices в одном аспекте, они будут выполняться в порядке, определенном их типом. Так, например, `Before Advices` всегда выполняются перед `After Advices`. Но что, если у нас есть два Before Advicesа? Опять же, можно использовать Order для контроля их порядка выполнения

# Прокси и AOP Proxy

Когда мы говорим о применении аспектов к нашим компонентам в Spring, мы на
самом деле говорим о создании “прокси”. Прокси — это своего рода “посредник”
между вызывающим и целевым объектом. Spring создает эти прокси-объекты,
чтобы вмешаться в вызов метода и выполнить нужные аспекты перед или после
нашего основного метода.

## JDK Dynamic Proxy vs. CGLIB proxy

JDK Dynamic Proxy: Этот метод создает прокси для интерфейсов. Если ваш
компонент или сервис реализует какой-либо интерфейс, Spring, как правило,
использует этот метод. Под капотом здесь используется рефлексия Java,
чтобы динамически создать новый объект, который реализует тот же
интерфейс, что и ваш целевой объект.

CGLIB proxy: А что, если у вас класс, который не реализует никакого
интерфейса? Здесь на помощь приходит CGLIB. Этот механизм создает
подкласс вашего целевого класса. Внешне он выглядит и ведет себя как ваш
оригинальный класс, но внутри он добавляет логику для аспектов.

Spring автоматически решает, какой из механизмов использовать. Если ваш класс
реализует интерфейс, Spring, скорее всего, будет использовать JDK Dynamic Proxy.
Если нет интерфейса, то выбор падает на CGLIB. Но вы также можете явно указать
Spring’у, какой механизм использовать, если у вас есть для этого особые причины. Для этого бины должны реализовывать интерфейсы

```yaml
  aop:
    proxy-target-class: false
```

# Транзакции и AOP

Самый простой способ объявить метод транзакционным в Spring - это использовать
аннотацию @Transactional. Эта аннотация говорит Spring, что метод должен
выполняться в контексте транзакции.

```java
@Service
public class BookService {
	
	@Autowired
	private BookRepository bookRepository;
	
	@Transactional
	public void addTwoBooks(Book book1, Book book2) {
		bookRepository.save(book1);
		bookRepository.save(book2);
	}
}
```

Вы также можете настроить поведение @Transactional, используя её параметры.
Например, вы можете определить, при каких исключениях транзакция должна
откатываться или даже установить разные уровни изоляции для транзакции.

```java
@Transactional(rollbackFor = CustomException.class)
public void someTransactionalMethod() {
	// ваш код
}
```

## **Transaction Propagation**

```java
@Transactional(propagation = Propagation.REQUIRED)
public void requiredExample(String user) { 
    // ... 
}
```

- ***REQUIRED* Propagation**

```java
if (isExistingTransaction()) {
    if (isValidateExistingTransaction()) {
        validateExisitingAndThrowExceptionIfNotValid();
    }
    return existing;
}
return createNewTransaction();
```

- ***SUPPORTS* Propagation**

```java
if (isExistingTransaction()) {
    if (isValidateExistingTransaction()) {
        validateExisitingAndThrowExceptionIfNotValid();
    }
    return existing;
}
return emptyTransaction;
```

- ***MANDATORY* Propagation**

```java
if (isExistingTransaction()) {
    if (isValidateExistingTransaction()) {
        validateExisitingAndThrowExceptionIfNotValid();
    }
    return existing;
}
throw IllegalTransactionStateException;
```

- ***NEVER* Propagation**

```java
if (isExistingTransaction()) {
    throw IllegalTransactionStateException;
}
return emptyTransaction;
```

- ***NOT_SUPPORTED* Propagation**

```java
/* If a current transaction exists, first Spring suspends it, 
and then the business logic is executed without a transaction:
```

- ***REQUIRES_NEW*  Propagation**

```java
/* When the propagation is REQUIRES_NEW, 
Spring suspends the current transaction if it exists, 
and then creates a new one:
```

- ***NESTED* Propagation**

```java
/* For NESTED propagation, Spring checks if a transaction exists, 
and if so, it marks a save point. 
This means that if our business logic execution throws an exception, 
then the transaction rollbacks to this save point. 
If there’s no active transaction, it works like REQUIRED.
```

## **Transaction Isolation**

Each isolation level prevents zero or more concurrency side effects on a transaction:

- **Dirty read:** read the uncommitted change of a concurrent transaction
- **Nonrepeatable read**: get different value on re-read of a row if a concurrent transaction updates the same row and commits
- **Phantom read:** get different rows after re-execution of a range query if another transaction adds or removes some rows in the range and commits

The default isolation level is *DEFAULT*. As a result, when Spring creates a new transaction, the isolation level will be the default isolation of our RDBMS. Therefore, we should be careful if we change the database.

```java
@Transactional(isolation = Isolation.READ_UNCOMMITTED)
public void log(String message) {
    // ...
}
```

***READ_UNCOMMITTED* Isolation**

s the lowest isolation level and allows for the most concurrent access.

As a result, it suffers from all three mentioned concurrency side effects. A transaction with this isolation reads uncommitted data of other concurrent transactions.

***READ_COMMITTED* Isolation**

The second level of isolation, *READ_COMMITTED,* prevents dirty reads.

***REPEATABLE_READ* Isolation**

The third level of isolation, *REPEATABLE_READ,* prevents dirty, and non-repeatable reads. So we are not affected by uncommitted changes in concurrent transactions.

***SERIALIZABLE* Isolation**

*SERIALIZABLE* is the highest level of isolation. It prevents all mentioned concurrency side effects, but can lead to the lowest concurrent access rate because it executes concurrent calls sequentially.

## Перехватчики (Interceptors)

Под “перехватчиками” в Spring мы понимаем механизмы, которые позволяют
“перехватывать” входящие и исходящие сообщения или запросы, обычно в
контексте веб-приложений. Они часто используются для таких задач, как
логирование, безопасность, производительность и другие перекрестные задачи.
Advices (Advices), с другой стороны, больше связаны с AOP и обеспечивают
перекрестную функциональность на уровне метода.
В простых словах: - Advices — это действия, которые выполняются до, после или
вокруг метода. - Перехватчики — это механизмы, которые “перехватывают”
запросы, перед тем как они достигнут их назначения (например, контроллера в
веб-приложении).

Пример:

В этом примере у нас есть перехватчик, который регистрирует URL каждого
входящего запроса, а также регистрирует информацию после обработки запроса и
после завершения обработки запроса.

```java
public class LoggingInterceptor extends HandlerInterceptorAdapter {
		
		@Override
		public boolean preHandle(HttpServletRequest request,
		                         HttpServletResponse response, 
		                         Object handler) throws Exception {
				System.out.println("Request URL: " + request.getRequestURL().toString());
				return true;
		}
		
		@Override
		public void postHandle(HttpServletRequest request,
				                   HttpServletResponse response, 
				                   Object handler, 
				                   ModelAndView	modelAndView) throws Exception {
				System.out.println("After handling the request");
		}
		
		@Override
		public void afterCompletion(HttpServletRequest request,
				                        HttpServletResponse response, 
				                        Object handler, 
				                        Exception ex) throws Exception {
				System.out.println("Request completed");
		}
}

// Чтобы этот перехватчик работал, его нужно зарегистрировать:

@Configuration
public class AppConfig implements WebMvcConfigurer {
		
		@Override
		public void addInterceptors(InterceptorRegistry registry) {
			registry.addInterceptor(new LoggingInterceptor());
		}
}
```

Таким образом, перехватчики – это мощный инструмент для управления входящими
и исходящими запросами в вашем веб-приложении, в то время как Advices AOP
позволяют управлять поведением методов в вашем приложении. Оба эти
механизма являются чрезвычайно полезными для реализации перекрестной
функциональности