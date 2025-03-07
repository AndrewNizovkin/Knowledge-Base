# Развёртывание приложения

### Подключение внешней базы данных(PostgreSQL)

Запускаем postresql, например в контейнере
Через котнтекстное меню пункта `Data Stores -> Main Data Store -> Manage Data Srore` выбираем тип базы данных и её параметры:

- название

- имя пользователя

- пароль

Тестируем соединение.

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

Создание:

```bash
./gradlew -Pvaadin.productionMode=true bootJar
```

Запуск: 

```
% java -jar ProjectManager-0.0.1.jar
```
