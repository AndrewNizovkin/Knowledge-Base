# Лекция 4. Базы данных и инструменты взаимодействия с ними.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5716234/attachment/15363422acbfac26058a5b7925c23642.pdf)

[Шпаргалка. Статья Habr](https://habr.com/ru/articles/265061/)

**JPA — Java Persistence API**

это спецификация, описывающая взаимодействие с базой данных.

представляет собой стандартный интерфейс в языке Java для работы с системами управления реляционными базами данных. Этот стандарт был создан для облегчения и унификации разработки приложений, использующих базы данных, и предоставляет объектно-ориентированный способ взаимодействия с реляционными данными

**Persistence (постоянство)** 

относится к характеристике состояния системы, которая переживает (сохраняется дольше, чем) процесс, который ее создал. На практике это достигается путем сохранения состояния в виде данных в компьютерном хранилище данных. Программы должны передавать данные на устройства хранения и с них, а также обеспечивать сопоставление структур данных родного языка программирования со структурами данных устройства хранения.

1. Объектно-Реляционное Отображение (ORM):
JPA предоставляет механизм для отображения Java-объектов на таблицы в
базе данных и наоборот. Это позволяет разработчикам работать с объектами
в коде, не беспокоясь о деталях хранения данных в базе.

2. Аннотации:
Для настройки отображения объектов в базу данных, JPA использует
аннотации, которые добавляются к классам и их полям. Например, аннотация
@Entity используется для обозначения класса как сущности базы данных.

**JPA-provider** 

В настоящее время **Hibernate** является практически стандартом в отрасли. 

Хотя есть и  альтернативные ORM системы, например EclipseLink, MyBatis, iBATIS, TopLink

**ORM — Object-Relational Mapping**

 или в переводе на русский объектно-реляционное отображение. Это технология программирования, которая связывает базы данных с концепциями объектно-ориентированных языков программирования. Если упростить, то ORM это связь Java объектов и записей в БД

**JDBC (Java Database Connectivity)**

это программный интерфейс, предоставляющий набор классов и методов для взаимодействия с базами данных из языка программирования Java. JDBC обеспечивает стандартизированный способ подключения к различным системам управления базами данных (СУБД), выполнения SQL-запросов, получения и обновления данных в базе. Он предоставляет абстракцию, позволяющую разработчикам писать приложения, которые могут взаимодействовать с базами данных, независимо от конкретной используемой СУБД. JDBC используется для создания портативных и эффективных приложений, работающих с данными в базах данных.

### Работа с JDBC

Для работы с СУБД MySQL нужно найти драйвер (mysql driver java maven) и подключить его в pom.xml

```xml
<!-- https://mvnrepository.com/artifact/com.mysql/mysql-connector-j -->
<dependency>
<groupId>com.mysql</groupId>
<artifactId>mysql-connector-j</artifactId>
<version>8.1.0</version>
</dependency>
```

**Класс DriverManager**

это класс, содержащий набор методов для инициализации JDBC-драйвера сервера базы данных и, в конечном итоге, для подключения к нему.

Пример:

```java
private static final String url = "jdbc:mysql://localhost:3306";

private static final String user = "root";

private static final String password = "root";

// Устанавливаем подключение к базе (обрабатываем исключение)
try (Connection con = DriverManager.getConnection(url, user, password)){
Statement statement = con.createStatement();

// Создаём и выполняем запрос на удаление, создание бд
statement.execute("DROP SCHEMA `test` ;");
statement.execute("CREATE SCHEMA `test` ;");

// Создаём таблицу, описываем её поля
statement.execute("CREATE TABLE `test`.`table` (\n" +
" `id` INT NOT NULL,\n" +
" `firstname` VARCHAR(45) NULL,\n" +
" `lastname` VARCHAR(45) NULL,\n" +
" PRIMARY KEY (`id`));");

// Заполняем поля таблицы
statement.execute("INSERT INTO `test`.`table` \n" +
(`id`,`firstname`,`lastname`)\n" +
"VALUES (1,'Иванов','Иван');");
statement.execute("INSERT INTO `test`.`table`
(`id`,`firstname`,`lastname`)\n" +
"VALUES (2,'Петров','Пётр');");

// Получить все данные из таблицы 
ResultSet set = statement.executeQuery("SELECT * FROM `test`.`table`;");
while (set.next()){
System.out.println(set.getString(3) + " " + set.getString(2) + " " + set.getInt(1));
// Statement возвращает результат запроса
// ResultSet создаёт указатель на первую строку результата
}
} catch (SQLException e) {
throw new RuntimeException(e);
}
```

JDBC даёт возможность управлять несколькими соединениями.

Пример. Метод для создания соединения

```java
public Connection getConnection(String url, String user, String password){
Connection con = null;
try {
con = DriverManager.getConnection(url, user, password);
} catch (SQLException e) {
throw new RuntimeException(e);
}
return con;
}
```

## ORM, Hibernate

[Online-учебник](https://proselyte.net/tutorials/hibernate-tutorial/sessions/)

[Вопросы на собеседованиях по Java EE - Hibernate Framework](https://javastudy.ru/interview/jee-hibernate-questions-answers/)

Для поддержки Hibernate нужно добавить зависимость в pom.xml

```java
<dependency>
<groupId>org.hibernate</groupId>
<artifactId>hibernate-java8</artifactId>
<version>6.0.0.Alpha7</version>
<type>pom</type>
</dependency>
```

Hibernate взаимодействует с СУБД через стандартный JDBC, поэтому ему требуются
настройки подключения. Обычно для этого создают внешний конфигурационный
файл. Вынесение конфигурации во внешний файл является хорошей практикой,
поскольку это позволяет изменять настройки без внесения изменений в код. Как
правило, этот файл называется `hibernate.cfg.xml`  и размещается в папке `resources`.
Если название и расположение файла корректны, мы сможем использовать его без
указания пути и имени файла. Пример файла приведен ниже.

```xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
"-//Hibernate/Hibernate Configuration DTD 3.0//EN"
"http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
<session-factory>
<property
name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
<property
name="hibernate.connection.url">jdbc:mysql://localhost:3306</property>
<property name="hibernate.connection.username">root</property>
<property name="hibernate.connection.password">root</property>
<property
name="hibernate.dialect">org.hibernate.dialect.MySQLDialect</property>
<property name="show_sql">true</property>
<mapping class="project.Magic" />
</session-factory>
</hibernate-configuration>
```

Или файл `hibernate.properties`

В конфигурации указан класс для маппинга `project.Magic` 

### Типы аннотаций

```java
@Entity
@Table (name = "test.magic")
public class Magic {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int idmagic;

@Column(name = "название")
private String name;

@Column(name = "повреждение")
private int damage;

@Column(name = "атака")
private int attBonus;

}
// Кроме того нужно добавить пустой конструктор, геттеры и сеттеры

```

**@Entity**

указывает, что мы определяем объект-сущность. Объект, созданный на основе этого класса будет использоваться Hibernate при взаимодействии с базой данных. Объекты-сущности должны следовать спецификации POJO (приватные поля, геттеры, сеттеры, пустой конструктор)

**@Table**

@Table (name = "test.magic") указывает имя базы данных и таблицы, с которыми связана сущность

**@Id**

является обязательной и определяет первичный ключ.

**@GeneratedValue(strategy = GenerationType.IDENTITY)**

определяет стратегию формирования ключа. В данном примере используется GenerationType.IDENTITY, самый простой способ конфигурации ключа, который опирается на auto-increment колонку в таблице.

**@Column**

@Column(name = "название") привязывает поле к колонке в базе данных. Если название поля совпадает с названием колонки, привязывать не обязательно.

### Основные классы ORM Hibernate:

```java
final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
    .configure() // configures settings from hibernate.cfg.xml
    .build();

SessionFactory sessionFactory = new MetadataSources(registry)
    .buildMetadata()
    .buildSessionFactory();

Session session = sessionFactory.openSession();

Magic magic = new Magic("Волшебная стрела", 10, 0, 0);

// Сохранять сущности в БД допустимо только в пределах транзакции
session.beginTransaction();

session.save(magic);

session.getTransaction().commit();

session.close();
```

**Класс StandardServiceRegistry** 

Этот класс содержит механизмы связи с сервером базы данных и менеджер передачи запросов. Файл конфигурации Hibernate, который мы ранее создали, используется этим классом. Поскольку мы разместили файл в нужном каталоге с правильным именем, конфигурировать его можно без дополнительных ссылок.

**SessionFactory**

```java
public class MainApp {
    public static void main(String[] args) {
        SessionFactory sessionFactory = new Configuration()
            .buildSessionFactory();
            
            // работа с базой данных
            
            sessionFactory.close()
    }
}
```

это "неизменяемый, потокобезопасный объект с компилированным маппингом для одной базы данных". Его нужно инициализировать всего один раз. Экземпляр SessionFactory используется для получения объектов Session, которые используются для операций с базами данных.

**Configuration**

Этот объект используется для создания объекта SessionFactory и конфигурирует сам Hibernate с помощью конфигурационного XML-файла, который объясняет, как обрабатывать объект Session.

 **Session**

Этот объект связывает наше приложение с базой данных

В интерфейсе Session определены 23 метода:

```java
Transaction beginTransaction()
// Начинает транзакцию и возвращает объект Transaction.

void cancelQuery()
// Отменяет выполнение текущего запроса.

void clear()
// Полностью очищает сессию

void flush() throws HibernateException
// flushing - процесс синхронизации данных в памяти и в бд

Connection close()
// Заканчивает сессию, освобождает JDBC-соединение и выполняет очистку.

Criteria createCriteria(String entityName)
// Создание нового экземпляра Criteria для объекта с указанным именем.

Criteria createCriteria(Class persistentClass)
// Создание нового экземпляра Criteria для указанного класса.

Serializable getIdentifier(Object object)
// Возвращает идентификатор данной сущности, как сущности,
// связанной с данной сессией.

void update(String entityName, Object object)
// Обновляет экземпляр с идентификатором, указанном в аргументе.

void update(Object object)
// Обновляет экземпляр с идентификатором, указанном в аргументе.

void saveOrUpdate(Object object)
// Сохраняет или обновляет указанный экземпляр.

Serializable save(Object object)
// Сохраняет экземпляр, предварительно назначив сгенерированный идентификатор.

boolean isOpen()
// Проверяет открыта ли сессия.

boolean isDirty()
// Проверят, есть ли в данной сессии какие-либо изменения,
// которые должны быть синхронизованы с базой данных (далее – БД).

boolean isConnected()
// Проверяет, подключена ли сессия в данный момент.

Transaction getTransaction()
// Получает связанную с этой сессией транзакцию.

void refresh(Object object)
// Обновляет состояние экземпляра из БД.

SessionFactory getSessionFactory()
// Возвращает фабрику сессий (SessionFactory), которая создала данную сессию.

Session get(String entityName, Serializable id)
// Возвращает сохранённый экземпляр с указанными именем сущности и идентификатором.
// Если таких сохранённых экземпляров нет – возвращает null.

void delete(String entityName, Object object)
// Удаляет сохранённый экземпляр из БД.

void delete(Object object)
// Удаляет сохранённый экземпляр из БД.

SQLQuery createSQLQuery(String queryString)
// Создаёт новый экземпляр SQL-запроса (SQLQuery) для данной SQL-строки.

Query createQuery(String queryString)
// Создаёт новый экземпляр запроса (Query) для данной HQL-строки.

Query createFilter(Object collection, String queryString)
// Создаёт новый экземпляр запроса (Query) для данной коллекции и фильтра-строки.
```

**Transaction**

Этот объект представляет собой рабочую единицу работы с БД. В Hibernate транзакции обрабатываются менеджером транзакций.

**Query**

Этот объект использует HQL или SQL для чтения/записи данных из/в БД. Экземпляр запроса используется для связывания параметров запроса, ограничения количества результатов, которые будут возвращены и для выполнения запроса.

**Criteria**

[Обзор Criteria Api](https://javastudy.ru/hibernate/hibernate-criteria-examples/)

Используется для создания и выполнения объекто-ориентированного запроса для получения объектов.

 Для операций update, delete или других DDL манипуляций использовать Criteria API нельзя. Критерии используются только для выборки из базы данных в более объектно-ориентированном стиле.

Вот некоторые области применения Criteria API:

- Criteria API поддерживает проекцию, которую мы можем использовать для агрегатных функций вроде sum(), min(), max() и т.д.

- Criteria API может использовать ProjectionList для извлечения данных только из выбранных колонок.

- Criteria API может быть использована для join запросов с помощью соединения нескольких таблиц, используя методы createAlias(), setFetchMode() и setProjection().

- Criteria API поддерживает выборку результатов согласно условиям (ограничениям). Для этого используется метод add() с помощью которого добавляются ограничения (Restrictions).

- Criteria API позволяет добавлять порядок (сортировку) к результату с помощью метода addOrder().

```java
Criteria criteria = session.createCriteria(Persistent.class)
List<Persistent> persistents = criteria.list()
```

Criteria имеет два важных метода:

```java
public Criteria setFirstResult(int firstResult)
// Указывает первый ряд нашего результата, который начинается с 0

public Criteria setMaxResults(int maxResults)
// Ограничивает максимальное количество объектов, которое Hibernate может
// получить в результате запроса
```

Пример:

```java
/**
* Выводит на печать экземпляры Developer из бд
* ограниченные по полю experience значением 3
*/
public void listDevelopersOverThreeYears() {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;

        transaction = session.beginTransaction();
        Criteria criteria = session.createCriteria(Developer.class);
        criteria.add(Restrictions.gt("experience", 3));
        List developers = criteria.list();

        for (Developer developer : developers) {
            System.out.println("=======================");
            System.out.println(developer);
            System.out.println("=======================");
        }
        transaction.commit();
        session.close();
    }

/**
* Выводит сумму значений полей salary
*/    
 public void totalSalary() {
        Session session  = sessionFactory.openSession();
        Transaction transaction = null;

        transaction = session.beginTransaction();
        Criteria criteria = session.createCriteria(Developer.class);
        criteria.setProjection(Projections.sum("salary"));

        List totalSalary = criteria.list();
        System.out.println("Total salary of all developers: " + totalSalary.get(0));
        transaction.commit();
        session.close();
}

```

### Пример. Класс-фабрика сессий

```java
public class Connector{

final StandardServiceRegistry registry;
SessionFactory sessionFactory;

public Connector() {

registry = new StandardServiceRegistryBuilder()
.configure() // configures settings from hibernate.cfg.xml
.build();

sessionFactory = new MetadataSources( registry
).buildMetadata().buildSessionFactory();
}

public Session getSession(){

return sessionFactory.openSession();

}
```

### Пример. Используем возможности Hibernate:

```java
Connector connector = new Connector();

Session session = connector.getSession();

Magic magic = new Magic("Волшебная стрела", 10, 0, 0);

session.beginTransaction();

session.save(magic);

magic = new Magic("Молния", 25, 0, 0);
session.save(magic);

magic = new Magic("Каменная кожа", 0, 0, 6);
session.save(magic);

magic = new Magic("Жажда крови", 0, 6, 0);
session.save(magic);

magic = new Magic("Жажда крови", 0, 6, 0);
session.save(magic);

magic = new Magic("Проклятие", 0, -3, 0);
session.save(magic);

magic = new Magic("Лечение", -30, 0, 0);
session.save(magic);

session.getTransaction().commit();

session.close()
```

Пример. Читаем записи из БД

```java
Connector connector = new Connector();

try (Session session = connector.getSession()) {

	// Чтение из БД не требует транзакции
	List<Magic> books = session.createQuery("FROM Magic",
	Magic.class).getResultList();

	books.forEach(b -> {
		System.out.println("Book of Magic : " + b);
		});

	} catch (Exception e) {
e.printStackTrace();
}
```

Пример. Изменяем объект.

```java
try (Session session = connector.getSession()) {

String hql = "from Magic where id = :id";

Query<Magic> query = session.createQuery( hql, Magic.class);

query.setParameter("id", 4);

Magic magic = query.getSingleResult();

System.out.println(magic);

magic.setAttBonus(12);

magic.setName("Ярость");

session.beginTransaction();

session.update(magic);

session.getTransaction().commit();

} catch (Exception e) {
e.printStackTrace();
}
```

Пример. Удаляем все элементы из БД

```java
try (Session session = connector.getSession()) {

Transaction t = session.beginTransaction();

List<Magic> books = session.createQuery("FROM Magic",

Magic.class).getResultList();

books.forEach(b -> {
session.delete(b);
});

t.commit();

} catch (Exception e) {
e.printStackTrace();
}
}
```

Пример. JPQL-запрос

```java
TypedQuery<User> query = entityManager.createQuery("SELECT u FROM User u WHERE
u.username = :username", User.class);

query.setParameter("username", "john_doe");

List<User> resultList = query.getResultList()
```

### Пример. Отношение один ко многим.

```java
@Entity
public class Author {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
@Column(name = "author_id"
private Long id;

private String name;

@OneToMany(mappedBy = "author")
private List<Book> books;
// геттеры и сеттеры
}

@Entity
public class Book {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

private String title;

@ManyToOne
@JoinColumn(name = "author_id")
private Author author;
// геттеры и сеттеры
}
```

### Транзакции

JPA обеспечивает управление транзакциями, позволяя разработчикам
атомарно выполнять операции чтения и записи.

Пример. Транзакция

```java
EntityManager entityManager = //... получение EntityManager

EntityTransaction transaction = entityManager.getTransaction();

try {

transaction.begin();

// выполняем операции с базой данных

transaction.commit();

} catch (Exception e) {
if (transaction != null && transaction.isActive()) {
transaction.rollback();
}
}
```

Пример. Транзакция, обработка исключений.

```java
Session session = sessionFactory.openSession();
Transaction transaction = null;
    
    try{
        transaction = session.beginTransaction();
        
        /**
         * Here we make some work.
         * */
        
        transaction.commit();
    }catch(Exception e){
        if(transaction !=null){
            transaction.rollback();
            e.printStackTrace();
        }
        e.printStackTrace();
    }finally{
        session.close();
    }
```

### Уровни кэширования

Hibertate имеет три уровня кэширования

https://habr.com/ru/articles/135176/

1. Уровень сессии

2. Уровень фабрики сессий (по умолчанию отключён). Включается добавлением строк в файл конфигурации. При этом hibernate предоставляет одну из структур для реализации кэша второго уровня, которую тоже нужно настроить в своём файле конфигурации, например ehcache.xml. Кроме того, нужно hibernate указать что кэшировать с помощью аннотации. Если кэшируемый класс содержит зависимости, то их тоже нужно аннотировать. Важно помнить, что чтение из кэша второго уровня произойдёт, только если данные на найдены в кэше первого уровня.

```java
@Entity
@Table(name = "shared_doc")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SharedDoc{
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    private Set<User> users;
}

```

1. Уровень запросов (по умолчанию отключён). Для его включения нужно добавить строку в конфигурационный файл.

```xml
<property name="hibernate.cache.use_query_cache" value="true"/>

```

И при создании query (qriteria) добавить:

```java
Query query = session.createQuery("from SharedDoc doc where doc.name = :name");
query.setCacheable(true);

```

Hibernate хранит данные не как объекты, а как массив данных, сходный с хэш-таблицей, в которой id выступает в роли ключа.

### **Стратегии кеширования**

Стратегии кеширования определяют поведения кеша в определенных ситуациях. Выделяют четыре группы:

- Read-only
- Read-write
- Nonstrict-read-write
- Transactional

### **Cache region**

Регион или область — это логический разделитель памяти вашего кеша. Для каждого региона можна настроить свою политику кеширования (для EhCache в том же ehcache.xml). Если регион не указан, то используется регион по умолчанию, который имеет полное имя вашего класса для которого применяется кеширование. В коде выглядит так:

```java
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "STATIC_DATA")

```

А для кеша запросов так:

```java
query.setCacheRegion("STATIC_DATA");
//или в случае критерии
criteria.setCacheRegion("STATIC_DATA");

```

### Три состояния класса-сущности

Экземпляр класса может находиться в одном из трёх состояний:

- **transient** Это новый экземпляр устойчивого класса, который не привязан к сессии и ещё не представлен в БД. Он не имеет значения, по которому может быть идентифицирован.

- **persistent** Мы можем создать переходный экземпляр класса, связав его с сессией. Устойчивый экземпляр класса представлен в БД, а значение идентификатора связано с сессией.

- **detached** После того как сессия закрыта, экземпляр класса становится отдельным, независимым экземпляром класса.

Сущесвуют определённые требования к POJO классам. Вот самые главные из них:

- Все классы должны иметь ID для простой идентификации наших объектов в БД и в Hibernate. Это поле класса соединяется с первичным ключём (primary key) таблицы БД.

- Все POJO – классы должны иметь конструктор по умолчанию (пустой).

- Все поля POJO – классов должны иметь модификатор доступа **private** иметь набор getter-ов и setter-ов в стиле JavaBean.

- POJO – классы не должны содержать бизнес-логику.

### Hibernate Query Language (HQL)

Он очень похож на SQL, за исключением, что в нем используются объекты вместо имен таблиц, что делает язык ближе к объектно-ориентированному программированию.

В сравнении с SQL, HQL полностью объектно-ориентирован и использует понятия наследования, полиформизма и связывания.

```java
/**
* Пример запроса HQL Select
*/
Query query = session.createQuery("from ContactEntity where firstName = :paramName");
query.setParameter("paramName", "Nick");
List list = query.list();

// Так же можно указать параметр сразу:
Query query = session.createQuery("from ContactEntity where firstName = 'Nick' ");
List list = query.list();
```

```java
/**
*Пример запроса HQL Update
*/
Session session = HibernateSessionFactory.getSessionFactory().openSession();

Transaction tx = session.beginTransaction();

Query query = session.createQuery("update ContactEntity set firstName = :nameParam, lastName = :lastNameParam" +
                ", birthDate = :birthDateParam"+
                " where firstName = :nameCode");

        query.setParameter("nameCode", "Nick");
        query.setParameter("nameParam", "NickChangedName1");
        query.setParameter("lastNameParam", "LastNameChanged1" );
        query.setParameter("birthDateParam", new Date());

        int result = query.executeUpdate();

tx.commit();
session.close();

// Можно напрямую
String queryString = "update ContactEntity set firstName = :nameParam, lastName = :lastNameParam" +
                ", birthDate = :birthDateParam"+
                " where firstName = :nameCode";

int result = session.createQuery(queryString)
             .setString("nameParam", "StringName")
             .setString("lastNameParam", "LastNameString")
             .setString("birthDateParam", "2012.08.03")
             .setString("nameCode", "Vasya")
             .executeUpdate();
```

```java
/**
* Пример запроса HQL Delete
*/
Query query =  session.createQuery("delete ContactEntity where firstName = :param");
query.setParameter("param", "Leonid");
int result = query.executeUpdate();

// другой вариант записи
String sqlDeleteString = "delete ContactEntity where firstName = :param";
int result = session.createQuery(sqlDeleteString)
             .setString("param", "Leonid")
             .executeUpdate();
```