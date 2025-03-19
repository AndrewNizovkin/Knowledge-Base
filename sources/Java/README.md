# Java

## Java Core

[Платформа: история и окружение.](,/javacore1.md)

[ДЗ_1. Компиляция и интерпретация кода.](https://github.com/AndrewNizovkin/HomeWorks/tree/main/java_core_1)

[Файловые системы. Потоки вода-вывода. Пакет java.io](javacore2.md)

[Специализация: ООП и исключения.](javacore3.md)

[ДЗ_4. Урок 4. Обработка исключений](https://github.com/AndrewNizovkin/HomeWorks/tree/main/java_core_4)

[ДЗ_5. Тонкости работы](https://github.com/AndrewNizovkin/HomeWorks/tree/main/java_core_5)

## JDK

[Графический интерфейс. Swing.](swing.md)

[ДЗ-3 Обобщённое программирование](https://github.com/AndrewNizovkin/HomeWorks/tree/main/jdk_3)

[Коллекции](collections.md)

[Урок 5. Многопоточность.](multithreading.md)

[Управление проектом: сборщики проектов.](https://cloud.mail.ru/public/eRAn/DuY2Qt9ET)

[ДЗ-6 Парадокс Монти-Холла](https://github.com/AndrewNizovkin/HomeWorks/tree/main/jdk_6)

## Junior

[Лекция 1. Лямбды и Stream API](junior1.md)

[ДЗ-1](https://github.com/AndrewNizovkin/HomeWorks/tree/main/junior-1)

[Лекция 2. Аннотации, Reflection API](junior2.md)

[ДЗ-2](https://github.com/AndrewNizovkin/HomeWorks/tree/main/junior-2)

[Лекция 3. Сериализация.](junior3.md)

[ДЗ-3](https://github.com/AndrewNizovkin/HomeWorks/tree/main/junior-3)

[Лекция 4. Базы данных и инструменты взаимодействия с ними.](junior4.md)

[ДЗ-4 JDBC, Hibernate](https://github.com/AndrewNizovkin/HomeWorks/tree/main/junior-4)

[Лекция 5. Клиент/Сервер своими руками.](junior5.md)

[ДЗ-5](https://github.com/AndrewNizovkin/HomeWorks/tree/main/junior-5)

[Потоки ввода-вывода IO](junior_io.md)

[Система ввода-вывода NIO](junior_nio.md)

[Регулярные выражения](regular.md)

### Статьи

[JMIX - ускорение разработки веб-приложений на Java](https://www.jmix.ru/)


[Записи](records.md)

[Apache POI. Чтение и запись данных в Excel из Java](https://sky.pro/wiki/java/chtenie-i-zapis-dannykh-v-excel-iz-java-instruktsiya/)

### Глоссарий

Обобщения (гл. 14 Gerbert Shildt)

Сериализация (гл. 21 Gerbert Shildt)

Scanner (гл. 20 Gerbert Shildt)

SimpleDateFormat(pattern)

value instanceof Integer - 

Фабричным  называется такой метод, который возвращает объект своего класса. Как правило, фабричные методы объявляются статическими в своём классе.

`String pathProject = System.*getProperty*("user.dir");`

`String pathFile = pathProject.concat("/file.txt");`

### Форматированный вывод

```java
public class Program {
 public static void main(String[] args) {

 float pi = 3.1415f;
 System.out.printf("%f\n", pi); // 3,141500
 System.out.printf("%.2f\n", pi); // 3,14
 System.out.printf("%.3f\n", pi); // 3,141
 System.out.printf("%e\n", pi); // 3,141500e+00
 System.out.printf("%.2e\n", pi); // 3,14e+00
 System.out.printf("%.3e\n", pi); // 3,141e+00
 }
}
//----
String formattedString = String.format("Local time: %tT", Calendar.getInstance());
//----Formatter можен работать не только со String, но и с StringBuilder, например
Formatter f = new Formatter(); 
 f.format("There are %d planets in the Solar System. Sorry, Pluto", 8); 
 System.out.println(f);
```
### Время

[java.util.Date](http://java.util.Date) - Первое что нужно о нем знать — **он хранит дату в миллисекундах**
, которые прошли с 1 января 1970 года. Для этой даты есть даже отдельное название — “Unix-время”

```java
Date date = new Date(); // Текущая дата на момент создания
Date.getTime() // Вернёт время в мс с 1 января 1970 года
```

