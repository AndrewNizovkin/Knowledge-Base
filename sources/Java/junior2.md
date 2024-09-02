# Лекция 2. Аннотации, Reflection API

## **Аннотации**

@Read(Герберт Шилдт гл.12)

Аннотация содержит информацию, которая может быть использована различными инструментальными средствами на стадии разработки или развёртывания прикладных программ. (java.lang.annotation)

Аннотация — это специальная конструкция языка, связанная с классом, методом или переменной, предоставляющая программе дополнительную информацию, на основе которой программа может предпринять дальнейшие действия или реализовать дополнительную функциональность, такую как генерация кода, проверка ошибок и т. д.

### **@SuppressWarnings**

используется для подавления предупреждений компилятора.  Например, `@SuppressWarnings("unchecked")` отключает  предупреждения, связанные с "сырыми" типами (Raw Types).

### **@Deprecated**

используется для пометки устаревших методов или типов.

### **@FunctionalInterface**

используется для указания того, что в интерфейсе не может быть более одного абстрактного метода. Если абстрактных методов будет больше одного, то компилятор выдаст ошибку.

### **@SafeVarargs**

Функциональность varargs позволяет создавать методы с переменным количеством аргументов. При использовании в аргументах метода обобщенных типов выдаются предупреждения. Аннотация `@SafeVarargs` позволяет подавить их:

```java
@SafeVarargs
private void printStringSafeVarargs(List<String>... testStringLists) {
```

### **Мета-аннотации**

Мета-аннотации — это аннотации, применяемые к другим аннотациям для предоставления информации об аннотации компилятору или среде выполнения.

Мета-аннотации могут ответить на следующие вопросы об аннотации:

1. Может ли аннотация наследоваться дочерними классами?

2. Должна ли аннотация отображаться в документации?

3. Можно ли применить аннотацию несколько раз к одному и тому же элементу?

4. К какому типу элементов можно применить аннотацию: к классу, методу, полю и т.д.?

5. Обрабатывается ли аннотация во время компиляции или в рантайме?

Чтобы указать информацию об области действия аннотации и о типах элементов, к которым она может быть применена, используются мета-аннотации.

### `@Target`

определяет типы элементов, к которым может применяться аннотация. Например, в приведенном выше примере аннотация `@Company` была определена как TYPE, и поэтому может быть применена только к классам.

Существуют следующие типы целей, названия которых говорят сами за себя:

- `ElementType.ANNOTATION_TYPE` - другая аннотация

- `ElementType.CONSTRUCTOR` - конструктор

- `ElementType.FIELD` - поле

- `ElementType.LOCAL_VARIABLE` - локальная переменная

- `ElementType.METHOD` - метод

- `ElementType.PACKAGE` - пакет

- `ElementType.PARAMETER` - параметр

- `ElementType.TYPE`  - класс, интерфейс или перечисление

- `ElementType.TYPE_PARAMETER`  - параметр типа

- `ElementType.TYPE_USE`  - использование типа

В аннотации @Target можно задать одно или несколько значений этих констант.

```java
@Target({ ElementType.FIELD, ElementType.LOCAL_VARIEBLE })
```

В отсутствие @Target аннотацию можно применять к любому элементу, за исключением параметров типов

### `@Retention`

 задаёт *правила удержания аннотаций,* указывает, когда аннотация будет доступна:

- `SOURCE` — аннотация доступна в исходном коде и удаляется после компиляции.

- `CLASS` — аннотация сохраняется в class-файле во время компиляции, но недоступна при выполнении программы.

- `RUNTIME` — аннотация доступна в рантайме.

Например, чтобы указать, что аннотация применяется только к классам, используется аннотация `@Target(ElementType.TYPE)`. А мета-аннотация `@Retention(RetentionPolicy.RUNTIME)` указывает, что аннотация должна быть доступна в рантайме.

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Company{
	String name() default "ABC";
	String city() default "XYZ";
}
```

### **@Inherited**

По умолчанию аннотация не наследуется от родительского класса к дочернему. Мета-аннотация `@Inherited` позволяет ей наследоваться:

```java
@Inherited
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Company{
  String name() default "ABC";
  String city() default "XYZ";
}
```

### **@Documented**

@Documented указывает, что аннотация должна присутствовать в JavaDoc.

```java
@Inherited
@Documented
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Company{
  String name() default "ABC";
  String city() default "XYZ";
}

@Company(name = "AAA", city = "ZZZ")
public class MultiValueAnnotatedEmployee {
  
}
```

## **Классификация аннотаций**

Аннотации можно классифицировать по количеству передаваемых в них параметров: без параметров, с одним параметром и с несколькими параметрами.

### **Маркерные аннотации**

Маркерные аннотации не содержат никаких членов или данных. Для определения наличия аннотации можно использовать метод `isAnnotationPresent()`

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface CSV {
}

@CSV
public class XYZClient {
    ...
}

public class TestMarkerAnnotation {

  public static void main(String[] args) {

  XYZClient client = new XYZClient();
  Class clientClass = client.getClass();

    if (clientClass.isAnnotationPresent(CSV.class)){
        System.out.println("Write client data to CSV.");
    } else {
        System.out.println("Write client data to Excel file.");
    }
  }
}
```

### **Аннотации с одним значением**

Аннотации с одним значением содержат только один атрибут, который принято называть value.

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface SingleValueAnnotationCompany {
  String value() default "ABC";
}

@SingleValueAnnotationCompany("XYZ")
public class SingleValueAnnotatedEmployee {
//...
}
```

### **Практический пример**

В качестве практического примера обработки аннотаций напишем простой аналог аннотации `@Test` из JUnit. Пометив методы аннотацией `@Test`, мы сможем определить в рантайме, какие методы тестового класса нужно запускать как тесты.

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD) 
public @interface Test {
}

// Тестовый класс
public class AnnotatedMethods {

  @Test
  public void test1() {
    System.out.println("This is the first test");
  }

  public void test2() {
    System.out.println("This is the second test");
  }
}

// Код для запуска тестов
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public class TestAnnotatedMethods {

  public static void main(String[] args) throws Exception {

    Class<AnnotatedMethods> annotatedMethodsClass = AnnotatedMethods.class;

    for (Method method : annotatedMethodsClass.getDeclaredMethods()) {

      Annotation annotation = method.getAnnotation(Test.class);
      Test test = (Test) annotation;

      // If the annotation is not null
      if (test != null) {

        try {
          method.invoke(annotatedMethodsClass
                  .getDeclaredConstructor()
                  .newInstance());
        } catch (Throwable ex) {
          System.out.println(ex.getCause());
        }

      }
    }
  }
}
```

[**Пример использования аннотации JavaRush**](https://javarush.com/groups/posts/1896-java-annotacii-chto-ehto-i-kak-ehtim-poljhzovatjhsja)

[Список аннотаций Java docs](https://docs.oracle.com/javase/tutorial/java/annotations/predefined.html)

## **Рефлексия**

@Read(Герберт Шилдт гл.30)

это языковое средство для получения сведений о классе во время выполнения программы. (java.lang.reflect)

С её помощью можно динамически анализировать компоненты программного обеспечения и описывать их свойства во время выполнения, а не компиляции.

Имея в распоряжении объект типа `Class` можно воспользоваться его методами для получения сведений о различных элементах, объявленных в классе, включая аннотацию:

```java
// Получаем объект типа Class
A a = new A();
Class<?> c = a.getClass();

// некоторые методы
Method getMethod();
Method[] getMethods();

Field getField();
Fields[] getFields(); // только публичных полей
Fields[] getDeclaredFields(); // публичные и приватные

Constructor getConstructor();
Constructor[] getConstructors();

Annotationn getAnnotation();

Method[] getDeclaredMethods();
```

**Интерфейс AnnotatedElement**

Этот интерфейс поддерживает рефлексию для аннотации и реализуется в классах Method, Field, Constructor, Class, Package.

В этом интерфейсе определяются методы:

```java
Annotation getAnnotation();
Annotation[] getAnnotations();
Annotation[] getDeclaredAnnotations();
boolean isAnnotationPresent(Class<? extends Annotation>);

```

**Интерфейс Member**

определяет методы, позволяющие получать сведения о поле, конструкторе или методе отдельного класса.

**Класс Modifier**

Предоставляет ряд методов типа `isX`, предназначенных для проверки заданного значения. 

С его помощью можно фильтровать методы класса, получив для каждого значение описывающее модификаторы доступа к этому элементу:

```java
int modifiers = method[i].getModifiers();
if (Modifier.isPublic(modifiers)) 
   System.out.printf("метод %s публичный", method[i].geName()) 
if (Modifier.isPrivate(modifiers)) 
   System.out.printf("метод %s приватный", method[i].geName()) 
```

Класс `Modifier` содержит ряд статических методов, возвращающих тип модификаторов, которые могут быть применены к определённому типу элемента программы.

```java
static int classModifiers()
static int constructorModifiers()
static int fieldModifiers()
static int interfaceModifiers()
static int methodModifiers()
static int parameterModifiers()
```

Примеры:

```java
// Получить все публичные конструкторы
Constructor<?>[] constructors = car.getClass().getConstructors();

// Получить все публичные и приватныеконструкторы
Constructor<?>[] constructors = car.getClass().getDeclaredConstructors();

// Создать экземпляр объекта:
Object gaz = constructors[0].newInstance("Газ-66");
System.out.println(gaz);

// Получить публичные поля
Field[] fieldsPublic = gaz.getClass().getFields();

// Получить публичные и приватные поля
Field[] fieldsPublic = gaz.getClass().getDeclaredFields();

// Сделать поле публичным
fields[i].setAccessible(true);

// Получить значение поля
int tmp = fields[i].getInt(gaz);

// Установить значение поля
fields[i].setInt(gaz, 100);
fields[i].set(gaz, 100);

// Получить все публичные методы, в том числе и методы из суперклассов
Method[] metods = gaz.getClass().getMethods();

// Получить все методы, объявленные в классе
Method[] metods = gaz.getClass().getDeclaredMethods();

```