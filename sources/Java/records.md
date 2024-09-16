# Java Records (JEP 359)

В **Java 14** введён новый тип `Records`, предназначенный для хранения в объекте какой-то неизменяемой информации

```java
// Пример

public record Cat(String name, int numberOfLives, String color) { }

```

Декомпилированная версия предыдущего кода:

```java
public final class Cat extends java.lang.Record {
    private final java.lang.String name;
    private final int numberOfLives;
    private final java.lang.String color;

    public Cat(java.lang.String name, int numberOfLives, java.lang.String color) { /* compiled code */ }

    public java.lang.String toString() { /* compiled code */ }

    public final int hashCode() { /* compiled code */ }

    public final boolean equals(java.lang.Object o) { /* compiled code */ }

    public java.lang.String name() { /* compiled code */ }

    public int numberOfLives() { /* compiled code */ }

    public java.lang.String color() { /* compiled code */ }
}
```

Записи имеют следующую функциональность:

- Неизменный класс с тремя полями

- Конструктор присваивает эти поля

- Геттеры

- equals(), hashCode() и toString(), которые можно переопределить при желании

**Ограничения**

Существуют некоторые недостатки и ограничения записей, о которых вам следует знать.

- Записи не могут расширять любой класс, хотя они могут 
реализовывать интерфейсы.

- Записи не могут быть абстрактными.

- Записи неявно являются final; они не могут быть унаследованы

- Вы можете объявить дополнительные поля в теле записи, но только если они статичны

В `Records` можно добавить статические методы, и пользовательские конструкторы.