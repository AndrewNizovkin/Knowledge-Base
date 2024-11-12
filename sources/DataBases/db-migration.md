## Миграция схемы базы данных

[Миграция схемы базы данных без головной боли](https://habr.com/ru/articles/337816/)

[Использование Liquibase без головной боли. 10 советов из опыта реальной разработки](https://habr.com/ru/articles/179425/)

[Управление миграциями БД с Liquibase](https://habr.com/ru/articles/178665/)

[Использование Liquibase для управления структурой БД в Spring Boot приложении. Часть 1](https://habr.com/ru/articles/460377/)


> **Идемпотентный и конвергентный скрипт** описывает не действия, которые надо произвести над объектом, а состояние, в которое нужно привести объект.

`Идемпотентность` означает, что если такой скрипт выполнен успешно и объект уже находится в нужном состоянии, то повторное выполнение скрипта ничего не изменит и ни к чему не приведёт. Например, если мы говорим о скрипте configuration management системы, декларирующем установку необходимых пакетов, то, если эти пакеты уже установлены, при повторном запуске скрипт просто не выполнит никаких операций.

`Конвергентность` означает, что если скрипт не был выполнен или завершился неуспешно, при его повторном выполнении система будет стремиться к желаемому состоянию. Например, если установка одного из пакетов завершилась с ошибкой, т. к. в момент скачивания пакета пропала сеть, то повторный запуск скрипта приведёт к тому, что пропущенный пакет доустановится (а те, что установились в прошлый раз, останутся на своём месте).

### Liquibase

Liquibase позволяет автоматизировать внесение обновлений в структуру БД. Каждое изменение описывается в декларативном стиле и версионируется. Обновления накатываются в заранее определённом порядке на данную БД, если они ещё не накатывались. Автоматизация процесса наката изменений на базу данных особенно важна, если у вас несколько различных экземпляров приложений и для каждого из них требуется поддерживать свою БД.



Кроме схемы и операций DDL, Liquibase позволяет мигрировать данные приложения, с поддержкой наката изменений данных и их отката.

`Liquibase` использует так называемые «чейнджсеты» 

- `changeset` — набор изменений, XML-код для описания операторов DDL. Они составляют файлы чейнджлогов (`changelog`). 

Следующий чейнджсет создаст таблицу (тэг «createTable») и два столбца (тэг «column»).

```xml
<databasechangelog xmlns="http://www.liquibase.org/xml/ns/dbchangelog" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">
  <changeset id="1" author="mueller@synyx.de" runonchange="true"> 
    <createtable tablename="Person"> 
      <column autoincrement="true" name="id" type="BIGINT"> 
        <constraints nullable="false" primarykey="true"> 
        </constraints>
      </column> 
      <column name="name" type="VARCHAR(255)"> 
        <constraints nullable="false"> 
        </constraints>
      </column> 
    </createtable> 
  </changeset>
</databasechangelog>
```

Liquibase имеет встроенную поддержку отката некоторых типов чейнджсетов, к примеру «createTable». Если мы вызовем Liquibase через командную строку с аргументом «rollbackCount 1» вместо «update», произойдет откат последнего чейнджсета: таблица PERSON будет удалена.

Другие типы чейнджсетов не могут быть удалены автоматически. 

```xml
<databasechangelog xmlns="http://www.liquibase.org/xml/ns/dbchangelog" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">
  <changeset id="init-1" author="mueller@synyx.de"> 
    <insert tablename="Person"> 
      <column name="name" value="John Doe"> 
      </column>
    </insert>
    <rollback> 
      DELETE FROM Person WHERE name LIKE 'John Doe'; 
    </rollback>
  </changeset>
</databasechangelog>
```
При наличии двух ченджлогов, можно создать "главный" файл

```xml
<databasechangelog xmlns="http://www.liquibase.org/xml/ns/dbchangelog/1.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.liquibase.org/xml/ns/dbchangelog/1.9 
                      http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-1.9.xsd"> 
    <include file="db.changelog-0.1.0.xml"></include>
    <include file="db.changelog-0.1.0.init.xml"></include>
</databasechangelog> 
```

При вызове команды «update» для каждого из чейнджсетов происходит проверка, был ли он применен к схеме. Если чейнджсет еще не был применен, происходит его выполнение. Для этого Liquibase сохраняет данные во вспомогательной таблице `DATABASECHANGELOGS`, содержащей уже примененные чейнджсеты, а также их хэш-значения. Хэши используются для того, чтобы нельзя было изменить уже выполненные чейнджсеты.

```sql
mysql> select id, md5sum, description from DATABASECHANGELOG; 
+--------+------------------------------------+--------------+ 
| id     | md5sum                             | description  | 
+--------+------------------------------------+--------------+ 
| 1      | 3:5a36f447e90b35c3802cb6fe16cb12a7 | Create Table | 
| init-1 | 3:43c29e0011ebfcfd9cfbbb8450179a41 | Insert Row   | 
+--------+------------------------------------+--------------+ 
2 rows in set (0.00 sec)
```