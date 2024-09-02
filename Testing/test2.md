# Урок 2. Знакомство с тестовыми фреймворками.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5493159/attachment/9d159dd0a747cdbf9eb9b4dc70da9015.pdf)

---

Вот некоторые широко используемые фреймворки, с которыми мы так или иначе
столкнёмся на курсе:
● Mockito
● JBehave
● Spock
● TestNG
● JUnit

### Семейство xUnit

Все фреймворки из семейства xUnit имеют следующие базовые компоненты
архитектуры, которые в различных реализациях могут слегка варьироваться.
Общие архитектурные принципы семейства xUnit:

1. Test runner (Средство выполнения тестов) — это исполняемая программа,
которая запускает тесты, реализованные с использованием фреймворка
xUnit, и сообщает о результатах тестирования.
2. Test case (Тестовый пример) — это класс, от которого мы хотим
наследоваться, если пишем свой тест.
3. Test fixtures (Тестовые инструменты) — это набор предварительных
условий или состояний, необходимых для запуска теста.
4. Test suites (Наборы тестов) — позволяет упаковать много тестов, вроде
контейнера, и можно запускать сразу несколько (набор) тестов.
5. Test execution (Выполнение теста) — это выполнение отдельного теста,
когда сначала подготавливается контекст теста, потом тело теста и

завершающая часть.
6. Test result formatter — модуль форматирования результатов теста и их
анализ.
7. Assertions (Ассерты) — уже знакомые нам по принципу проверки.

### Установка JUnit 5

Скачиваем архивы

[Установка JUnit](https://mvnrepository.com/artifact/org.junit.jupiter/junit-jupiter-api/5.9.1)

[junit-platform-commons » 1.9.1](https://mvnrepository.com/artifact/org.junit.platform/junit-platform-commons/1.9.1)

 и добавляем зависимости в меню File → Project Structure в Ingellij Idea

```java
import org.junit.jupiter.api.*;
```

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/ea81ed0a-2b39-4208-a877-05df4447555f/30607d30-f32a-43dc-9fa5-85a3aefc3f05/Untitled.png)

@test

аннотация, используемая JUnit для указания, что это тест

@BeforeEach

аннотированный метод должен выполняться перед каждым методом…..

JUnit 5 можно разделить на 3 различных проекта (в отличие от 4 версии, которая
была монолитной):

1. JUnit Platform
2. Jupiter
3. Vintage

### JUnit 5 Работа с утверждениями

Фреймворк имеет встроенный инструмент работы с утверждениями.
Механизм, основанный на Assert из JUnit, на самом деле, несколько устарел и не поддерживает некоторые новые функции языка, а также менее объектно-ориентирован, но всё ещё широко используется, так как идёт вместе с фреймворком JUnit по умолчанию.

- junit.framework.Assert

-  `assertEquals`

-  `assertFalse`

-  `assertNotNull`

-  `assertNull`

-  `assertNotSame`

-  `assertSame`

-  `assertTrue`

При этом каждый из этих методов перегружен и может включать сообщение, которое возвращается в случае когда утверждение выбросит исключение
Синтаксис тестов на JUnit Assert похож на AssertJ:

```java
public class MathTest {
	@Test
	public void testEquals() {
		Assert.assertEquals(4, 2 + 2);
		Assert.assertTrue(4 == 2 + 2);
		}
		
		@Test
		public void testNotEquals() {
		Assert.assertFalse(5 == 2 + 2);
	}
}
```

Утверждение, написанное с помощью AssertJ, выглядит следующим образом:

```java
assertThat(notificationText).contains("testuser@google.com");
```