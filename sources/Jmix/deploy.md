# Развёртывание приложения

Приложение Jmix может быть поставлено в JAR и WAR архивах.

- **JAR (Java Archive)** - это формат пакетных файлов. Файлы JAR имеют расширение .jar и могут содержать библиотеки, ресурсы и файлы метаданных. По сути, это архив,  содержащий сжатые версии файлов .class и ресурсов скомпилированных Java-библиотек и приложений. Настройки подключения к БД обычно определяются внутри приложения.

- **WAR (Web Application Archive)** - формат с расширением .war, предназначенный для упаковки веб-приложений, которые могут быть развернуты на любом контейнере Servlet/JSP. Настройки подключения к БД могут быть вынесены из приложения - при развертывании WAR можно использовать предоставляемый сервером источник данных JNDI.

Для генерации архивов JAR и WAR используются задачи Spring Boot. 

### Подключение внешней базы данных(PostgreSQL)

- Запускаем postresql, например в контейнере.

    Через котнтекстное меню раздела `Data Stores -> Main Data Store -> Manage Data Srore` выбираем тип базы данных и её параметры:

    - название

    - имя пользователя

    - пароль

- Тестируем соединение.

### Создание JAR

Имя приложения формируется из параметров, расположенных в соответствующих файлах раздела `Build Scripts`:

- **settings.gradle**

    ```
    rootProject.name = 'ProjectManager'

    ```

- **build.gradle**

    ```
    group = 'com.company'

    version = '0.0.1'
    ```

После редактирования файлов нужно обновить конфигурацию, нажав кнопку(как и с Maven)

- Создание:

```bash
./gradlew -Pvaadin.productionMode=true bootJar
```

- Запуск из командной строки: 

```
% java -jar ProjectManager-0.0.1.jar
```

### Создание WAR

- Имя приложения формируется, как и при создании JAR из параметров, расположенных в соответствующих файлах раздела `Build Scripts`:

- **settings.gradle**

    ```
    rootProject.name = 'ProjectManager'

    ```

- **build.gradle**

    ```
    group = 'com.company'

    version = '0.0.1'
    ```
    После редактирования файлов нужно обновить конфигурацию, нажав кнопку(как и с Maven)

- Секция `plugins` файла **build.gradle** должна содержать параметр `if 'war'`. Редактируем, добавляем.

- Главный класс приложеия должен быть подклассом `SpringBootServletInitializer`. Редактируем файл **ProjectManagerAppllication.java**

- Создание:

```
./gradlew -Pvaadin.productionMode=true bootWar
```

Созданный файл будет исполняемым. Его можно поместить в контейнер сервлетов, например в `Tomcat`.

[Установка Apache Tomcat на Ubuntu 22.04](https://ruvds.com/ru/helpcenter/kak-ustanovit-apache-tomcat/)

###  Работа с Docker

Образ можно создать с помощью терминальной команды:

```bash
./gradlew -Pvaadin.productionMode=true bootBuildImage --imageName=jmixtest/jmix-pm

# jmixtest/jmix-pm - имя контейнера. Указывается в docker-compose.yaml
```
В корневой папке ПРОЕКТА нужно создать папку `docker`, а в ней файл `docker-compose.yaml`