# Свойства, профили

## Передача свойств приложения с помощью переменных окружения

Свойства приложения определены в файле **application.properties**.

При внесении изменений в **application.properties**, нужно пересобрать приложение (JAR, WAR) 

Для развёртывания приложения в различных окружениях могут потребоваться разные свойства.

Для этого для соответсвующих свойств нужно подставить _плэйсхолдеры(placeholder)_ 

```
main.datasource.url = ${DB_URL}
main.datasource.username = ${DB_USER}
main.datasource.password = ${DB_PASSWORD}
```

Перед запуском программы, нужно экспортировать переменные с помощью команды:

```bash
# Unix:
export DB_URL=jdbc:postgresql://localhost/projectdb
export DB_USER=username
export DB_PASSWORD=userpassword

#Windows
$env:DB_URL='jdbc:postgresql://localhost/projectdb'
$env:DB_USER='username'
$env:DB_PASSWORD='userpassword'
```

Например, можно задать таким образом значения для логина и пароля по умолчанию:

```bash
ui.login.defaultUsername = ${APP_USER}
ui.login.defaultPassword = ${APP_PASSWORD}
```

## Профили выполнения

> Профиль - набор свойств для каждой среды выполнения

Чтобы использовать различные свойства для различных профилей, нужно создать для каждого файл `application-{profile}.properties`:

    - application-dev.properties

    - application-prod.properties

Активный профиль может быть указан:

- В команде запуска:

```bash
java -Dspring.profiles.active=dev -jar ProjectManager.jar
```

- В переменной окружения:

```bash
# Unix
export SPRING_PROFILES_ACTIVE=dev,oauth 

# Windows
$env:SPRING_PROFILES_ACTIVE='dev'

# Можно несколько профилей. Дополняют друг друга. Совпадающие свойства переписываются последующим профилем.
```
## Свойства приложения

Помимо основных, жизненно важных для работы приложения свойств, существует множество других.

Документация:

- [Свойства приложения](https://docs.jmix.ru/jmix/app-properties.html)

- [Свойства пользовательского интерфейса](https://docs.jmix.ru/jmix/flow-ui/ui-properties.html)

## Указание профиля для бина

Например, имеем два бина для `dev` и `prod`, реализующих один интерфейс:

```java
public interface PaymentService {
    int performPayment(BigDecimal amount, Long accountId);
}

@Service
@Profile("dev")
public class DevPaymentService imlements PaymentService {
    @Override
    int performPayment(BigDecimal amount, Long accountId) {
        // эмуляция оплаты
    }
}

@Service
@Profile("prod")
public class ProdPaymentService imlements PaymentService {
    @Override
    int performPayment(BigDecimal amount, Long accountId) {
        // работа с реальной базой данных, реальная оплата
    }
}
```

Профиль указывается при запуске следующей командой:

```bash
java -Dspring.profiles.active=dev -jar appname.jar
```
Если аннотация `@Profile` у бина отсутствует, то он будет использован, если в команде запуска не указан профиль. Но если профиль указан при запуске, то наличие бина без аннотации `@Profile` приведёт к ошибке при обращении к методам бина, потому что в систему будет два бина с одинаковым интерфейсом.

