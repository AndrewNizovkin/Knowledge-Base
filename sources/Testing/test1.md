# Урок 1. Цели и смысл тестирования.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5493116/attachment/6a84364651c7028876e1db8536d88e37.pdf)

 [AssertJ — fluent assertions java library](https://assertj.github.io/doc/)

[Assert. Что это? / Хабр](https://habr.com/ru/post/141080/)

---

## Принципы тестирования программного обеспечения

Принципы, представленные ниже определяют, как
тестировать и что тестировать. Понимание этих принципов даёт возможность
избежать множества ошибок, а также оптимизировать затраты времени, сил, и
нервов на тестирование.

1. Тестирование показывает наличие дефектов.
Тестирование только снижает вероятность наличия дефектов, которые находятся
в программном обеспечении, но не гарантирует их отсутствия, другими словами,
тестирование не исправит плохой код, а только покажет, где он плох.

2. Исчерпывающее тестирование невозможно.
Полное тестирование с использованием всех входных комбинаций данных
физически невыполнимо. То есть для тестов надо подобрать правильные
тестовые данные, например, какие-то граничные значения, явно невозможные
значения и т. д. Чтобы проследить корректность поведения программы в этих
случаях, при этом мы делаем важное допущение, что в остальных случаях
программа тоже поведёт себя верно.

3. Раннее тестирование.
Следует начинать тестирование на ранних стадиях жизненного цикла разработки
ПО, чтобы найти дефекты как можно раньше. Это связано с тем, что намного
дешевле исправить дефект на ранних стадиях разработки. Рекомендуется
начинать поиск с момента, когда описаны требования системы.

4. Кластеризация дефектов (или скопление дефектов).
Принцип, который предполагает, что небольшое количество модулей содержат в
себе большинство багов. Это яркий пример применения в тестировании
принципа Парето: 80% проблем таятся в 20% модулей.
Можно просто запомнить что, если вы нашли несколько багов в каком-то модуле,
то стоит изучить его тщательнее, скорее всего, есть ещё скрытые дефекты.

5. Парадокс пестицидов.
Если повторять те же тестовые сценарии снова и снова, в какой-то момент этот
набор тестов перестанет выявлять новые дефекты. Чтобы решить эту проблему,
тесты должны регулярно пересматриваться и обновляться, должны добавляться
новые тесты, ориентированные на другую функциональность или тестирующие
уже существующие функции, но по другому.

6. Тестирование зависит от контекста.
Тестирование проводится по-разному в зависимости от контекста. Например,
программное обеспечение, в котором критически важна безопасность,
тестируется иначе, чем новостной портал: то есть, для обеспечения безопасности
приложения важнее сфокусироваться на тестировании авторизации
пользователей, а для новостного портала важнее будет проверить, правильно ли
отображается текст публикаций.

7. Заблуждение об отсутствии ошибок.
Отсутствие найденных дефектов при тестировании не всегда означает
готовность продукта к публикации. Система должна быть удобна пользователю в использовании и удовлетворять его ожиданиям и потребностям.
Этот принцип говорит о том, что поиск и устранение багов не поможет, если построенная система изначально неправильно построена и не соответствует требованиям клиента. Поэтому, если формально все тесты пройдены, есть ещё очень много всяких «хотелок», которые нужно реализовывать, при этом важно,
что реализация хотелок должна также быть в рамках тестов.

🔥 Ошибки в пограничных случаях — самая частая причина логических
ошибок в программах. Программисты всегда забывают что-нибудь учесть.

💡Обратите внимание, что до Java 1.4 было совершенно законно
использовать слово «assert» для именования переменных, методов и т. д. Это
потенциально создаёт конфликт имён при использовании более старого кода с
более новыми версиями JVM.

💡Поэтому для обеспечения обратной совместимости JVM по умолчанию
отключает возможность использования утверждений. Они должны быть явно включены с помощью аргумента командной строки -enableassertions или его сокращения -ea. В IDEA можно это сделать так:

- меню `Run → Edit Configurations… → Modify Options → Add VM options` и вводим в окне `-ea`

Лучшие практики
Самое важное, что нужно помнить об утверждениях — это то, что они могут
быть отключены, поэтому никогда не предполагайте, что они будут выполнены.
При использовании утверждений имейте в виду следующее:

 
💡Всегда проверяйте наличие нулевых значений.

💡Избегайте использования Assert для проверки входных данных в
публичный метод и вместо этого используйте unchecked исключение, такое как
IllegalArgumentException или NullPointerException.

💡Не вызывайте методы в условиях утверждения, а вместо этого
присваивайте результат метода локальной переменной и используйте эту
переменную с assert.

💡Утверждения отлично подходят для мест в коде, которые никогда не
будут выполнены, например, для оператора switch по умолчанию или после
цикла, который никогда не завершается.

## Библиотека AssertJ

Разница между фреймворком и библиотекой Часто путают библиотеку с фреймворком, многие могут думать, что это синонимы. Рассмотрим сразу эти два понятия вместе, чтобы понять, в чём различия. 

● ФРЕЙМВОРК — это набор взаимосвязанных классов и методов, которые
позволяют создавать приложения, и которые можно использовать в других
приложениях.

● БИБЛИОТЕКА — это просто набор классов. Например, классы, которые вы
написали сами.

Пример фреймворка — `JUnit` (фреймворк для модульного тестирования
программного обеспечения на языке Java, будет рассматриваться дальше в
курсе), а пример библиотеки — `AssertJ` (Используется для написания более
гибких и удобочитаемых утверждений, можно сказать, расширяет assert'ы,
однако есть и отличия).

### Подключение AssertJ

Чтобы начать использовать AssertJ в нашем коде, подключим зависимость:

1. На сайте официальной документации библиотеки [(AssertJ — fluent assertions java library)](https://assertj.github.io/doc/) скачиваем jar-архив библиотеки. Для этого
переходим к пункту [Other build tools](https://assertj.github.io/doc/#other-build-tools), затем переходим по ссылке в
менеджер репозиториев и скачиваем [архив](https://search.maven.org/remotecontent?filepath=org/assertj/assertj-core/3.23.1/assertj-core-3.23.1.jar).

2. Далее нужно подключить библиотеку к проекту. Это можно сделать
различными способами, рассмотрим на примере подключения с
использованием ide Intellij IDEA. Можно подключить библиотеку разными
способами, об этом можно почитать подробнее в статье — [Подключение библиотек в Java](https://gb.ru/posts/java_libs#:~:text=%D0%9A%D0%B0%D0%BA%20%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C%20Java-%D0%B1%D0%B8%D0%B1%D0%BB%D0%B8%D0%BE%D1%82%D0%B5%D0%BA%D1%83%20%D0%B2%D1%80%D1%83%D1%87%D0%BD%D1%83%D1%8E).

3. В IDEA переходим: `File → Project Structure → Libraries → New Project Library → Java →` выбираем скачанный в 1 пункте архив — подтверждаем.

Теперь переходим в класс Calculator в ide и импортируем AssertJ:

```java
import static org.assertj.core.api.Assertions.*;
```

Теперь, когда нам доступен функционал библиотеки. Рассмотрим пример тестов,
переписанных с использованием этой библиотеки:

```java
// Проверка базового функционала с целыми числами, с
// использованием утверждений AssertJ:
assertThat(Calculator.calculation(2, 6, '+')).isEqualTo(8);
assertThat(Calculator.calculation(2, 2, '-')).isEqualTo(0);
assertThat(Calculator.calculation(2, 7, '*')).isEqualTo(14);
assertThat(Calculator.calculation(100, 50, '/')).isEqualTo(2);
```

### Возможности AssertJ

Помимо сравнений результатов вычислений, как в примере с калькулятором, можно проверять на соответствие строки, например:

```java
assertThat(frodo.getName()).isEqualTo("Frodo");
assertThat(frodo).isNotEqualTo(sauron);
```

Есть инструмент для работы с коллекциями, в примере ниже в передаваемом списке fellowshipOfTheRing размером 9 элементов утверждается наличие элементов frodo, sam и отсутствие sauron. Если будет передан список, который не удовлетворяет этим условиям, будет выброшено исключение.

```java
assertThat(fellowshipOfTheRing).hasSize(9) .contains(frodo,
sam) .doesNotContain(sauron);
```

Причём передаваемую коллекцию можно заранее отфильтровать:

```java
assertThat(fellowshipOfTheRing).filteredOn(character ->
character.getName().contains("o")) .containsOnly(aragorn,
frodo, legolas, boromir);
```

Есть возможность дополнить сообщение об ошибке с помощью as(), оно будет выводиться перед ошибкой:

```java
assertThat(frodo.getAge()).as("check %s's age",
frodo.getName()).isEqualTo(33);
```

Проверка правильности выбрасываемого исключения:

```java
assertThatThrownBy(() -> Callulator.calculator(8, 4, "_"))
.isInstanceOf(IllegalStateException.class);
```