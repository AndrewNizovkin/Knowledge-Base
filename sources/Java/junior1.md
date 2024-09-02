# Лекция 1. Лямбды и Stream API

### Лямбда-выражения

(Gerbert Shildt гл.15)

Для передачи лямбда-выражения в качестве аргумента параметр, получающий это выражение в качестве аргумента, должен иметь тип функционального интерфейса. совместимого с этим лямбда выражением.

### Ссылки на метод.

Если параметром является функциональный  интерфейс, то в качестве аргумента можно передать ссылку на статический метод класса, метод конкретного экземпляра или нестатический метод класса 

Для создания ссылки на статический метод класса служит следующая общая форма:

```java
имя_класса::имя_метода
```

Для передачи ссылки на метод экземпляра для конкретного объекта служит следующая общая форма:

```java
ссылка_на_объект::имя_метода
```

Используя оператор `super` , можно обращаться к варианту метода из суперкласса:

```java
super::имя_метода
```

### Ссылки на конструкторы

Следующая ссылка может быть присвоена любой ссылке на функциональный интерфейс, в котором определяется метод, совместимый с конструктором.

```java
имя_класса::new
```

### Предопределённые функциональные интерфейсы

В пакете java.util.function предоставляется целый ряд предопределённых интерфейсов. Некоторые из них:

```java
UnaryOperator<T>
// Выполняет унарную операцию над объектом типа T и возвращает 
// результат того же типа. apply()

BinaryOperator<T>
// Выполняет логическую операцию над двумя объектоми типа T и возвращает 
// результат того же типа. apply()

Consumer<T> // потребитель
// Выполняет операцию над объектом типа T. accept()

Suplier<T> // поставщик
// Возвращает объект типа T. get()

Function<T, R> 
// Выполняет операцию над объектом типа T и возвращает
// объект типа R. apply()

Predicate<T>
// Возвращает логическое значение, определяющее, 
// удовлетворяет ли объект типа T некоторому условию. test()

```

[Consumer, Supplier, Predicate и Function статья на Habr](https://habr.com/ru/articles/677610/)

[Официальная документация Oracle](https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html)

## Stream Api

(Gerbert Shildt гл.29)

Получение потока

```java
List<Double> myList = Arrays.asLlist(7.0, 18.0, -10.0, 23.0);

// Получить последовательный поток данных
Stream<Double> stream = myList.stream());

// Получить параллельный поток данных
Stream<Double> streamParallel = myList.parallelStream();
// или
Stream<Double> streamParallel = stream.parallel();

// Получить последовательный поток данных с уникальными значениями
Stream<Double> stream = myList.stream().distinct());
 
```

### Класс Optional

(Gerbert Shildt гл.20)

Экземпляр класса Optional может содержать значение типа T или быть пустым. Конструкторы отсутствуют, но в нём определяется ряд методов. Метод get() при отсутствии значения возвращает NoSuchElementException

```java
class Optional<T>

// Возвращает пустой объект
Optional<String> noVal = Optional.empty();

// Создаёт экземпляр Optional
Optional<String> hasVal = Optional.of("abcdef");

// Проверяет наличие значения
if (hasVal.isPresent()) System.out.println(hasVal.get());

// Вызывает заданную функцию, если значение присутствует
hasVal.ifPresent(x -> System.out.println("Значение элемента: " + x));

```

### Операции min(), max(), count(), sort()

Следует помнить, что эти операции *употребляют* поток данных и чтобы вновь им воспользоваться необходимо его снова создать

```java
// Минимальное значение из потока
Optional<double> minVal = myList.stream().min(Double::compare);
if(minVal.isPresent()) System.out.println(minVal.get());

// Получить отсортированный поток
Stream<Double> sortedStream = myList.stream().sorted();

// Получить отсортированный поток, только положительных
Stream<Double> sortedStreamPositiv = myList.stream().sorted().filter(x -> x >= 0);

// Получить количество элементов в потоке:
long count = myStream.count();
```

### Сведение reduce()

Используется для возвращения значения из потока по любому произвольному критерию.

```java
Optional<T> reduce(BinaryOperator<T> накопитель>
T reduce(T значение_идентичности, BinaryOperator<T> накопитель)
// Для параллельных потоков может быть полезной следующая форма:
<U> U reduce(U значение_идентичности,
						BiFunction<U, ? super T, U> накопитель,
						BinaryOperator<U> обединитель)

// Пример. Получить произведение квадратов всех элементов
Optional<Double> productObj = myList.stream()
                                    .reduce((a, b) -> a * Math.sqrt(b));
// или
double product = myList.stream()
                       .reduce(1, (a, b) -> a * Math.sqrt(b));
// или
double product = myList.parallelStream()
                       .reduce(1, (a, b) -> a * Math.sqrt(b), (a, b) -> a*b);
```

### Отображение map()

Используется для отображения элементов одного потока данных на элементы другого потока.

```java
<R> Stream<R> map (Function<? super T, ? extends R>

// Пример. Отобразить квадратные корни из списка на новый поток данных:
List<Double> myList = Arrays.asLlist(7.0, 18.0, 10.0, 23.0);

Stream<Double> myStream= myList.stream().map((a) -> Math.sqrt.(a)); 
```

### Накопление collect()

Используется для получения коллекции из  потока данных. Этот метод выполняет операцию *изменяемого сведения*. Дело в том, что в результате сведения получается изменяемый объект хранения.

```java
<R, A> R collect (Collector<? super T, A, R> функция_накопления)
```

### Класс Collectors

Предоставляет ряд статических методов накопления:

```java
// Возвращает накопитель, предназначенный для накопления элементов в List
static <T> Collector<T, ?, List<T>> toList()

// Возвращает накопитель, предназначенный для накопления элементов в Set
static <T> Collector<T, ?, Set<T>> toSet()

// Пример. Получим список из потока:
List<Double> sqrtList = myStream.collect(Collectors.toList());

// Пример. Получим множество из потока:
Set<Double> sqrtSet = myStream.collect(Collectors.toSet());
```

### generate(), limit()

 generate генерирует бесконечную последовательность на основе переданного ему функционального интерфейса.

limit() задаёт ограничение 

```java
public static void main(String[] args) {
   ArrayList<String> nameList = new ArrayList<>();
   nameList.add("Elena");
   nameList.add("John");
   nameList.add("Alex");
   nameList.add("Jim");
   nameList.add("Sara");

   Stream.generate(() -> {
       int value = (int) (Math.random() * nameList.size());
       return nameList.get(value);
   }).limit(5).forEach(System.out::println);
}
```

### iterate()

Данный метод схож с методом `generate`: он также генерирует бесконечную последовательность но имеет два аргумента:

- первый — элемент, с которого начинается генерация последовательности;
- второй — `UnaryOperator`, который указывает принцип генерации новых элементов с первого элемента.

```java
public static void main(String[] args) {
   Stream.iterate(9, x -> x * x)
           .limit(4)
           .forEach(System.out::println);
}
// каждый наш элемент умножен на самого себя, и так для первых четырёх чисел.
```

### Итераторы (Iterator)

Чтобы получить итератор для потока нужно вызвать метод iterator()

```java
Iterator<Double> itr = myStream.itetaror();
```

### Итераторы-разделители (Spliterator)

Служат альтернативой обычному итератору. Содержит ряд интересных методов

```java
// Выполняет действие над следующим элементом и продвигает итератор дальше
// возвращает true, если имеется следующий элемент или false, если элементов
// больше нет
boolean tryAdvance(Consumer<? super T> действие)

// Пример. 
Spliterator<double> split = myStream.splirerator();
while(split.tryAdvance(x -> System.out.println(x));

// Выполняет действие над всеми элементами сразу
default void forEachRemaining(Consumer<? super T> действие)

// Пример.
split.forEachRemaining(x -> System.out.println(x));
```

### Ещё чуть-чуть

```java
boolean allMatch(Predicate<? super T> predicate)
boolean anyMatch(Predicate<? super T> predicate)
boolean noneMatch(Predicate<? super T> predicate)
// удовлетворяет ли один или несколько элементов условию

long count()
// Количество элементов в потоке

Stream<T> distinct()
// только однозначные элементы

static <T> Stream<T> of(T... values)
static <T> Stream<T> of(T t)
// возвращает поток из последовательности объектов или одного

```