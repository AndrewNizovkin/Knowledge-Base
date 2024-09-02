## 5.Spring Data для работы с базами данных

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5643795/attachment/e0901f1d5666a0785d6c7d75ea031df0.pdf)

Spring Data Repository – Это интерфейс, который предоставляет базовые операции
CRUD (создание, чтение, обновление, удаление) для сущности. Repository реализует
шаблон проектирования Repository, описанный в Domain-Driven Design (DDD).

CRUD - Сокращение от Create, Read, Update, Delete – это базовые операции, которые
могут быть выполнены в любой базе данных.

JPA (Java Persistence API) – это спецификация для управления, доступа и
сохранения Java объектов в базу данных. Это способ взаимодействия с базой
данных с помощью объектно-ориентированного подхода.

Spring Data JPA – Это подпроект Spring Data, который предоставляет реализацию
Repository, используя JPA. Он упрощает написание кода для работы с базами
данных, предоставляя реализацию шаблонов CRUD и позволяя вам фокусироваться
на написании бизнес-логики.

```java
/**
	 * JDBC JPA
	 * JDBC (java database connectivity) - библиотека внутри Java для работы с базами данных.
	 * Driver, Connection, Statement
	 *
	 * JPA (Jakarta Persistence API) - набор соглашений по работе с реляционными моделями.
	 * Основная идея - "замапить" вашу DB-модель на Java-классы и работать со строками таблиц как с объектами.
	 * JPA - это не реализация, а протокол (api, спецификация)
	 * Hibernate - это одна из реализаций JPA (еще одна реализация - EclipseLink)
	 *
	 * spring-data-jdbc - набор готовых инструментов для взаимодействия с базой данных.
	 * По сути оборачивает стандартный JDBC и предоставляет удобные интерфейсы для настройки и взаимодействия
	 * с базой данных
	 *
	 * spring-data-jpa -набор готовых инструментов для работы с JPA
	 */
```

Пример простого JPA-класса

```java
@Entity
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String name;
	private String email;
	// геттеры и сеттеры
}
```

### Аннотации для полей JPA классов

- @Entity на классе указывает, что этот класс является JPA сущностью и должен быть отображен на таблицу базы данных.
- @Id говорит о том, что это поле является идентификатором (ключом)
- @GeneratedValue(strategy=GenerationType.AUTO) значение генерируется автоматически.
- @Column: позволяет задать имя колонки и другие параметры, такие как
nullable и length.
- @Temporal: используется для указания типа даты/времени для поля java.util.Date или java.util.Calendar.
- @Enumerated: указывает, что поле является перечислением.
- @OneToMany, @ManyToOne, @OneToOne, @ManyToMany: эти аннотации
используются для отображения отношений между сущностями

### Конфигурация Spring Data с помощью Java кода

```java
@Configuration
@EnableJpaRepositories(basePackages = "com.example.myapp.repository")
@EnableTransactionManagement
public class JpaConfig {
	@Bean
	public DataSource dataSource() {
		// создание и настройка источника данных
	}
	
	@Bean
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
		// создание и настройка фабрики EntityManager
	}

	@Bean
	public PlatformTransactionManager transactionManager() {
		// создание и настройка менеджера транзакций
	}
}
```

- @EnableJpaRepositories(basePackages = "com.example.myapp.repository")  активирует создание репозиториев Spring Data. В параметре basePackages указывается пакет, где Spring должен искать интерфейсы репозиториев.
- @EnableTransactionManagement: Эта аннотация включает поддержку управления транзакциями Spring.
- @Bean эти методы создают различные компоненты, необходимые для работы JPA.

### Конфигурация Spring Data с помощью application.yaml

Вместо или в дополнение к Java-конфигурации, мы можем использовать файлы
properties или yaml для настройки Spring Data. Например для mysql, в файле application.yaml
мы можем указать следующее:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mydb
    username: user
    password: secret
    
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
```

● spring.datasource: Здесь мы указываем параметры подключения к базе
данных, такие как URL, имя пользователя и пароль.

● spring.jpa.hibernate.ddl-auto: Этот параметр определяет, как Hibernate должен
управлять схемой базы данных. Могут быть:

1. update Значение update означает, что Hibernate будет автоматически обновлять схему базы данных в соответствии с нашими JPA классами. 
2. validate При запуске (первом соединение) приложение смотрит соответствие таблиц и сущностей и упадёт при несоответствии. Это значение используется в продакшене
3. create
4. create-drop 

● spring.jpa.show-sql: Если этот параметр установлен в true, Hibernate будет
показывать SQL запросы, которые он выполняет.

# Пример.

## Техническое задание.

*Заказчик хочет, чтобы мы разработали простое веб-приложение для управления
заметками. У каждой заметки есть автор, заголовок и текст. Пользователи должны
иметь возможность создавать новые заметки, просматривать существующие,
редактировать и удалять их.
В рамках данного задания нам нужно разработать следующие компоненты:*

*● Модель Note, которая будет представлять заметку. У заметки должны быть
поля id, author, title и content.*

*● Репозиторий NoteRepository, который будет предоставлять операции CRUD
над заметками.*

*● Сервис NoteService, который будет использовать NoteRepository для
выполнения бизнес-логики приложения.*

*● Контроллер NoteController, который будет обрабатывать веб-запросы от
пользователей и использовать NoteService для выполнения операций.*

### Создание Spring проекта

При создании проекта на сайте **Spring Initializr** нужно добавить следующие зависимости

- Spring Web: Для создания веб-приложения с использованием Spring MVC.
- Spring Data JPA: Для работы с базой данных через JPA.
- Thymeleaf: Для создания веб-страниц нашего приложения (это не обязательно, если мы планируем создать REST API).
- Spring Boot DevTools: Для автоматической перезагрузки приложения при
изменении кода.
- PostgreSQL: Драйвер для нашей базы данных. Мы будем использовать
postgres.

Пример `Dockerfile` Для поднятия PostgreSQL в Docker:

```bash
FROM postgres:13.2-alpine
ENV POSTGRES_DB mynotes
ENV POSTGRES_USER mynotes
ENV POSTGRES_PASSWORD secret
```

Создание контейнера:

```bash
docker build -t mynotes-db .
```

Запуск контейнера:

```bash
docker run --name mynotes-db -p 5432:5432 -d mynotes-db
```

Для подключения к `postgres` из Spring проекта нужно добавить в файл конфигурации `application.yaml`:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/mynotes
    username: mynotes
    password: secret
  jpa:
    hibernate:
      ddl-auto: update
  show-sql: true
```

### Класс модели Note

```java
public class Note {
	private Long id;
	
	private String author;
	
	private String title;
	
	private String content;
	
	// геттеры и сеттеры
}
```

### JPA класс NoteEntity

этот класс будет отображать заметки на таблицу базы данных

```java
@Entity
@Table(name = "notes")
public class NoteEntity {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Column(nullable = false)
	private String author;
	
	@Column(nullable = false)
	private String title;
	
	@Column(nullable = false, length = 2000)
	private String content;
	
	// геттеры и сеттеры
}
```

## Слой репозитория

### Создание интерфейса репозитория

В этом интерфейсе мы указываем два параметра типа для JpaRepository: тип нашей
сущности (NoteEntity) и тип идентификатора (Long). JpaRepository предоставляет
нам множество полезных методов, таких как findAll(), findById(), save(), delete(), и
т.д., без необходимости их реализовывать.

```java
public interface NoteRepository extends JpaRepository<NoteEntity, Long> {
}
```

### Добавление пользовательских методов в репозиторий

В дополнение к методам, предоставляемым JpaRepository, мы можем добавить свои
собственные методы в репозиторий. Например, давайте добавим метод для поиска
заметок по автору:

```java
public interface NoteRepository extends JpaRepository<NoteEntity,
Long> {
List<NoteEntity> findByAuthor(String author);
}
```

## Сервисный слой

### Создание интерфейса сервиса

```java
public interface NoteService {
	List<Note> getAllNotes();
	
	Note getNoteById(Long id);

	Note createNote(Note note);

	Note updateNote(Long id, Note note);

	void deleteNote(Long id);
}
```

### Реализация интерфейса сервиса

```java
@Service
public class NoteServiceImpl implements NoteService {
	private final NoteRepository repository;

	@Autowired
	public NoteServiceImpl(NoteRepository repository) {
		this.repository = repository;
	}

	@Override
	public List<Note> getAllNotes() {
		return repository.findAll();
	}

	@Override
	public Note getNoteById(Long id) {
		return repository.findById(id)
		.orElseThrow(() -> new RuntimeException("Note not found"));
	}

	@Override
	public Note createNote(Note note) {
		return repository.save(note);
	}

	@Override
	public Note updateNote(Long id, Note note) {
		// мы должны сначала проверить, существует ли заметка с данным ID
		Note existingNote = getNoteById(id);
	
		// обновляем поля существующей заметки
		existingNote.setTitle(note.getTitle());
	
		existingNote.setContent(note.getContent());
		// сохраняем и возвращаем обновленную заметку
		return repository.save(existingNote);
	}

	@Override
	public void deleteNote(Long id) {
	// проверяем, существует ли заметка с данным ID
	getNoteById(id);

	// если да, то удаляем ее
	repository.deleteById(id);
	}
}
```

### Создание контроллера

```java
@RestController
@RequestMapping("/api/notes")
public class NoteController {
	
	private final NoteService service;
	
	@Autowired
	public NoteController(NoteService service) {
	
	this.service = service;
	
	}
	
		// методы контроллера
		
	@GetMapping
	public List<Note> getAllNotes() {
		return service.getAllNotes();
	}
	
	@GetMapping("/{id}")
	public Note getNoteById(@PathVariable Long id) {
		return service.getNoteById(id);
	}
	
	@PostMapping
	public Note createNote(@RequestBody Note note) {
		return service.createNote(note);
	}
	
	@PutMapping("/{id}")
	public Note updateNote(@PathVariable Long id, @RequestBody Note note) {
		return service.updateNote(id, note);
	}
	
	@DeleteMapping("/{id}")
		public void deleteNote(@PathVariable Long id) {
	service.deleteNote(id);
	}		
			
}
```

Запуск бд 

```bash
	docker run --name mynewdb -e POSTGRES_dB=mynewdb -e 
	POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -p 5432:5432 -d postgres
```

Вход в бд

```bash
docker exec -it mynewdb psql -U mynewdb
```

```bash
\dt # запрос всех таблиц
```

Для работы с этой бд из Java-кода, нужно подключить зависимость в _pom.xml_

Для использования этой бд, нужно добавить код в файл конфигурации application.yaml

Примеры в ДЗ.