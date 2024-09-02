# 10.Spring Testing. JUnit и Mockito для написания тестов.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5744437/attachment/74d041129815d0602ab0061bc1fcd82b.pdf)

**Spring Test Context Framework** — инфраструктура Spring для тестирования
Spring-компонентов с JUnit или TestNG.

**@SpringBootTest** — аннотация, используемая для указания, что тестовый класс является тестом Spring Boot. Это помогает в автоматической настройке Spring Application Context. 

Автоматически конфигурирует ваше приложение, поднимает встроенный сервер и готовит всё для интеграционного тестирования. Она создает реальный контекст вашего приложения, что позволяет тестировать его так, как если бы оно работало в продакшене.

**@Test** — аннотация JUnit, указывающая, что метод является тестовым методом. Mockito — популярная библиотека для создания mock-объектов в Java.

**Mock** — созданный объект, который имитирует поведение реального объекта. Используется в юнит-тестировании для изоляции тестируемого компонента.

**@Mock и @MockBean** — аннотации Mockito, используемые для создания и внедрения mock-объектов.

**@InjectMocks** — аннотация Mockito для создания экземпляра класса и внедрения в него mock-объектов.

**@BeforeEach** и **@AfterEach** — аннотации JUnit для методов, которые должны выполняться перед и после каждого тестового метода соответственно.

**@BeforeAll** и **@AfterAll** — аннотации JUnit для методов, которые должны выполняться один раз перед первым тестовым методом и после последнего тестового метода класса соответственно.

**assertThat()** — метод, используемый для утверждений в тестах.

**Matchers** — классы или методы, предоставляемые библиотеками тестирования (например, Mockito или Hamcrest), чтобы помочь в формировании утверждений.

**Test Runner** — класс или инструмент, который управляет запуском тестов и обеспечивает обратную связь о результатах.

**ApplicationContext** — центральный интерфейс для доступа к конфигурации приложения в Spring.

**@ContextConfiguration**  аннотация, используемая для указания конфигурации ApplicationContext для тестов.

**@ActiveProfiles** — аннотация для установки активных профилей Spring в тестах

**JUnit 5**: Современная итерация JUnit, представленная в 2017 году, принесла множество улучшений, в том числе модульную структуру. Это позволило разделить JUnit на три подпроекта: JUnit Platform, JUnit Jupiter и JUnit Vintage. Эта версия добавила много новых функций, таких как динамические тесты, расширенные возможности параметризации и более продвинутые аннотации.

Также рядом: TestNG, Spock и другие
Хотя JUnit является самым известным фреймворком для unit-тестирования в Java, существуют и другие инструменты, такие как TestNG и Spock. Эти инструменты предоставляют свои уникальные особенности и подходы к тестированию, предоставляя разработчикам больше возможностей.

## Spring и Unit-тесты

**Spring TestContext Framework**
Одной из ключевых фич Spring является его TestContext Framework. Этот фреймворк предоставляет аннотации и утилиты для загрузки Spring ApplicationContext в ваших тестах, что позволяет вам тестировать Spring-компоненты в изолированной среде

**@SpringBootTest**
С помощью аннотации @SpringBootTest вы можете легко загрузить весь контекст вашего приложения или его части. Она автоматически настр

Mocking с Mockito и @MockBean
Spring предоставляет аннотацию @MockBean, которая позволяет вам создать mock-версию вашего бина и внедрить ее в контекст Spring. Это особенно полезно, когда вы хотите изолировать конкретный компонент от внешних зависимостей, таких как репозитории или сервисы.

```java
@SpringBootTest
public class MyServiceTest {

	@Autowired
	private MyService myService;
	
	@MockBean
	private MyRepository myRepository;
	
	@Test
	public void testMyService() {
		when(myRepository.findSomething()).thenReturn(someData);
	// Некоторые проверки для myService
	}
}
```

**@WebMvcTest** и **@DataJpaTest**
В Spring Boot есть специальные аннотации для тестирования конкретных частей вашего приложения. Например, с @WebMvcTest вы можете тестировать только веб-слои вашего приложения, игнорируя остальное. А с @DataJpaTest можно сфокусироваться исключительно на тестировании JPA репозиториев.

**@TestConfiguration**
Определяет дополнительные конфигурационные классы или бины для теста. Эта аннотация  помогает определить локальные компоненты, которые будут использоваться только во время тестирования.

```java
@TestConfiguration
public class MyTestConfiguration {

	@Bean
	public MyService myService() {
		return new MyMockedService();
	}
}
```

@BeforeAll и @AfterAll
Использование: Эти аннотации из JUnit 5 используются для определения методов, которые выполняются перед началом всех тестов и после их завершения.

```java
@SpringBootTest
public class MyTests {

	@BeforeAll
	public static void init() {
		// Некоторая инициализация
	}

	@AfterAll
	public static void cleanup() {
		// Очистка после тестов
	}
}
```

## Интеграционные тесты

проверяют взаимодействие между различными частями вашего приложения:

- Взаимодействие с базами данных: Как ваше приложение обращается к базе? Правильно ли данные записываются и извлекаются?
- Общение с внешними сервисами: Если ваше приложение подключается к сторонним API или другим службам, интеграционные тесты могут проверить,правильно ли это происходит.
- Взаимодействие между модулями: Как одна часть вашего приложения
взаимодействует с другой?

### Spring компоненты для тестов:

**Spring TestContext Framework**
Spring предоставляет TestContext Framework, который обеспечивает
функциональности для загрузки контекста Spring и кэширования его между
тестовыми выполнениями для повышения производительности. Это очень удобно,
когда у вас есть тяжелые интеграционные тесты, работающие с реальной БД или
другими внешними ресурсами.

**@SpringBootTest**
Автоматически конфигурирует ваше приложение, поднимает встроенный сервер и готовит всё для интеграционного тестирования. Она создает реальный контекст вашего приложения, что позволяет тестировать его так, как если бы оно работало в продакшене.

**Встроенная поддержка баз данных** 

Spring позволяет легко настраивать встраиваемые базы данных, такие как H2, HSQL
или Derby, для тестирования. Это удобно, потому что не требует отдельной
конфигурации или настройки реальной базы данных.

**MockMvc для веб-тестирования** 

Если вы разрабатываете веб-приложение, MockMvc станет вашим лучшим другом.
Он позволяет быстро и легко создавать запросы к вашему приложению и проверять
ответы, не запуская реальный сервер.

**Spring Boot Test Slices** 

Spring Boot предлагает возможность “срезов тестов” (Test Slices), которые
позволяют тестировать только определенные части вашего приложения,
автоматически настраивая нужные компоненты. Например, @DataJpaTest настроит
только слой JPA вашего приложения для тестирования.

## Нагрузочное тестирование

Зачем нам это?
• Производительность: НТ помогает удостовериться, что ваше приложение
будет работать быстро, даже при большой нагрузке.
• Стабильность: Мы хотим узнать, не упадет ли наше приложение или не будет ли “тормозить”, когда много пользователей пытаются им пользоваться
одновременно.
• Масштабируемость: Узнайте, насколько легко добавлять ресурсы (например,
память, процессоры или серверы) для обработки дополнительной нагрузки.

Как провести нагрузочное тестирование?

1. Определите ожидаемую нагрузку: Начните с определения, сколько
пользователей вы ожидаете на своем сайте или приложении в пиковые часы.
2. Создайте тестовые сценарии: Определите, какие операции пользователи
будут чаще всего выполнять. Это может быть, например, поиск, добавление
товара в корзину или просмотр видео.
3. Подготовьте тестовое окружение: Убедитесь, что ваша тестовая среда
максимально приближена к реальной. Это может включать в себя настройку
серверов, баз данных и сети.
4. Выполните тесты: Используйте специализированные инструменты для
нагрузочного тестирования, чтобы имитировать действия многих
пользователей одновременно.
5. Анализируйте результаты: После тестирования изучите данные, чтобы
выявить узкие места или проблемы производительности, и определить,
соответствует ли система вашим требованиям

Инструменты , которые позволяют разработчикам имитировать большое количество виртуальных пользователей, генерирующих нагрузку на приложения, написанные на Java.

- JMeter
- Grinder
- Gatling

Помимо них, Java предоставляет инструменты такие как JVisualVM, Java Mission
Control и Java Flight Recorder. Это позволяет разработчикам не только
генерировать нагрузку, но и детально анализировать, как их приложение реагирует
на эту нагрузку.

## Нагрузочное тестирование с помощью JMeter

Apache JMeter — это open-source инструмент, разработанный для тестирования
производительности и функционального тестирования. Хотя он изначально
разрабатывался для тестирования веб-приложений, сейчас JMeter может быть
использован для различных сценариев тестирования.

Установка JMeter

1. Скачайте последний релиз JMeter с официального сайта.
2. Распакуйте архив в удобное место.
3. Запустите JMeter с помощью файла jmeter.bat (для Windows) или [jmeter.sh](http://jmeter.sh/)
(для Linux/macOS).
Создание тестового плана
4. Откройте JMeter.
5. Создайте новый тестовый план: Файл -> Новый.
6. Добавьте поток пользователей (Thread Group): ПКМ на вашем тестовом плане
-> Добавить -> Потоки (Users) -> Thread Group.
Настройка запросов
7. В потоке пользователей добавьте HTTP-запрос: ПКМ на Thread Group ->
Добавить -> Запросы (Requests) -> HTTP Request.
8. Введите детали вашего запроса (например, URL вашего сайта).

Добавление слушателей
Слушатели используются для просмотра результатов теста.

1. Добавьте слушателя: ПКМ на Thread Group -> Добавить -> Слушатели
(Listeners) -> График результатов.

### Пример. Web сервис “Заметки”

Создаём проект на Spring Initializr, добавив зависимости:

- Spring Web
- Spring Data JPA
- H2 Database

Model:

```java
@Entity
public class Note {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String title;
	
	@Lob
	private String content;
	// Геттеры, сеттеры и конструкторы
}
```

Repository

```java
@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {}
```

Service

```java
@Service
public class NoteService {

@Autowired
private NoteRepository noteRepository;

public List<Note> getAllNotes() {
	return noteRepository.findAll();
}

public Note getNoteById(Long id) {
	return noteRepository.findById(id).orElse(null);
}

public Note saveOrUpdate(Note note) {
	return noteRepository.save(note);
}

public void deleteNote(Long id) {
	noteRepository.deleteById(id);
}
}
```

Controller

```java
@RestController
@RequestMapping("/api/notes")
public class NoteController {
	
	@Autowired
	private NoteService noteService;
	
	@GetMapping
	public List<Note> getAllNotes() {
		return noteService.getAllNotes();
	}
	
	@GetMapping("/{id}")
	public Note getNote(@PathVariable Long id) {
		return noteService.getNoteById(id);
	}
	
	@PostMapping
	public Note createNote(@RequestBody Note note) {
		return noteService.saveOrUpdate(note);
	}
	
	@PutMapping("/{id}")
	public Note updateNte(@PathVariable Long id, @RequestBody Note updatedNote) {

		Note note = noteService.getNoteById(id);
		note.setTitle(updatedNote.getTitle());
		note.setContent(updatedNote.getContent());
		return noteService.saveOrUpdate(note);
	}
	
	@DeleteMapping("/{id}")
	public void deleteNote(@PathVariable Long id) {
		noteService.deleteNote(id);
	}
}
```

Настройка базы данных:

```java
spring.datasource.url=jdbc:h2:mem:notesdb
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
24
spring.datasource.password=
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.h2.console.enabled=truex
```

### Юнит-тестирование нашего проекта

Подготовка зависимостей:

```xml
<!-- JUnit -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-test</artifactId>
	<scope>test</scope>
</dependency>
<!-- Mockito -->
<dependency>
	<groupId>org.mockito</groupId>
	<artifactId>mockito-core</artifactId>
	<scope>test</scope>
</dependency>
```

Написание тестов.

Создайте новый класс `NoteServiceTest` в папке `src/test/java` в том же пакете, что и
`NoteService`

```java
@RunWith(SpringRunner.class)
public class NoteServiceTest {
	
	@InjectMocks
	private NoteService noteService;
	
	@Mock
	private NoteRepository noteRepository;
	
	@Before
	public void setUp() {
		MockitoAnnotations.initMocks(this);
	}
	
	@Test
	public void getAllNotesTest() {
	
		Note note = new Note();
	
		note.setTitle("Test Title");
	
		note.setContent("Test Content");
	
		List<Note> expectedNotes = Collections.singletonList(note);
	
		when(noteRepository.findAll()).thenReturn(expectedNotes);
	
		List<Note> actualNotes = noteService.getAllNotes();
	
		assertEquals(expectedNotes, actualNotes);
	
	}
	// ... Другие тесты для методов сервиса
}
```

## Интеграционное тестирование нашего проекта

Настройка тестового окружения. Мы можем использовать встроенные базы данных, такие как H2, чтобы эмулировать реальную работу с данными.

```xml
<dependency>
	<groupId>com.h2database</groupId>
	<artifactId>h2</artifactId>
	<scope>test</scope>
</dependency>
```

Написание теста для NoteService

В папке src/test/java создайте новый класс NoteServiceIntegrationTest.

```java
@RunWith(SpringRunner.class)
@SpringBootTest // говорит Spring загрузить полный контекст приложения.
public class NoteServiceIntegrationTest {
	
	@Autowired
	private NoteService noteService;
	
	@Autowired
	private NoteRepository noteRepository;
	
	@Before
	public void setUp() {
		// Очищаем базу данных перед каждым тестом
		noteRepository.deleteAll();
	}
	
	@Test
	public void getAllNotesIntegrationTest() {
		
		Note note = new Note();
		
		note.setTitle("Integration Test Title");
		
		note.setContent("Integration Test Content");
		
		noteRepository.save(note);
		
		List<Note> notes = noteService.getAllNotes();
		
		assertTrue(notes.size() > 0);
		
		assertEquals(note.getTitle(), notes.get(0).getTitle());
	}
	// ... Другие интеграционные тесты
}
```

### Нагрузочное тестирование нашего Spring-проекта

Для нагрузочного тестирования существует множество инструментов. Сегодня я предлагаю использовать один из самых популярных инструментов в мире **Java - Apache JMeter**.

Шаг 1. Установка JMeter
Скачайте и установите JMeter. После установки запустите JMeter.

Шаг 2. Создание тестового плана

1. Создайте новый Test Plan.
2. Добавьте Thread Group. Это ваша группа пользователей, которые будут
осуществлять запросы.
3. Установите нужное количество потоков (например, 100 пользователей) и
количество повторов (например, 10 раз).

Шаг 3. Добавление и конфигурация HTTP Request

1. Выберите ваш Thread Group и добавьте Sampler -> HTTP Request.
2. Настройте его:
– Server Name: localhost
– Port Number: 8080 (или тот порт, на котором у вас работает сервис)
– Path: /notes (если вы хотите получить все заметки)
– Method: GET

Шаг 4. Добавление Listener
Чтобы видеть результаты наших запросов, добавьте Listener. Самый простой и
понятный — View Results in Table.

Шаг 5. Запуск теста
Запустите тест, кликнув на “Start” (зелёный треугольник). После завершения теста
вы увидите результаты в вашем Listener’е.

### Метрики нагрузочного тестирования

1. Throughput (Пропускная способность)
Это количество запросов в секунду, которое ваш сервер может обработать.
Что это значит для нас?
– Если пропускная способность низкая, это может указывать на проблемы с
производительностью.
– Если она резко падает при увеличении нагрузки, это точно тревожный знак.

1. Response Time (Время ответа)
Это время, которое требуется серверу, чтобы ответить на ваш запрос.
Что это значит для нас?
– Если время ответа высокое даже при небольшой нагрузке, то это может
указывать на проблемы в определённых частях вашего приложения.
– Увеличение времени ответа при увеличении нагрузки - ещё один показатель
проблем с производительностью.

1. Error Rate (Процент ошибок)
Процент запросов, которые вернули ошибку.
Что это значит для нас?
– Любое значение, отличное от 0%, уже плохо. Это может указывать на
проблемы с кодом, базой данных или даже инфраструктурой.
– Если процент ошибок увеличивается при нагрузке, это явно не то, что мы
хотели бы видеть.

1. Concurrent Users (Конкурентные пользователи)
Сколько пользователей одновременно взаимодействуют с вашим сервисом.
Что это значит для нас?
– Если приложение начинает “хромать” уже на небольшом числе пользователей,
пора думать об оптимизации.

1. CPU/Memory Utilization (Использование ЦПУ/Памяти)
Какой процент ресурсов сервера используется при нагрузке.
Что это значит для нас?
– Если ваш сервер постоянно на пределе своих возможностей, даже если он справляется с текущей нагрузкой, при малейшем увеличении трафика он “упадет”.