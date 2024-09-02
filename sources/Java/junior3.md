# Лекция 3. Сериализация.

@GerbertShildt(гл.21)

**Сериализация**

это процесс записи состояния объектов в поток вывода байтов.

**RMI (Remote Method Invocation)**

@GerbertShildt(гл.30)

механизм *удалённого вызова метода* позволяет объекту Java на одной машине обращаться к методу объекта Java на другой машине. Объект может быть предоставлен в виде аргумента этого удалённого метода. Передающая машина сериализует и посылает объект, а принимающая машина десериализует его. 

**Интерфейс Serializable**

Не имеет никаких членов. Если класс сериализуется, то сериализуются и его подклассы.

Не сохраняются средствами сериализации:

- переменные с модификатором `transient`

- статические переменные

**Интерфейс Externalizable** 

Содержит методы для управления процессом сериализации-десериализации

```java
void readExternal(ObjectInput поток_ввода) throws IOException, 
                                                  ClassNotFoundException
void writeExternal(ObjectOutput поток_вывода) throws IOException
// поток_ввода - поток байтов, из которого может быть введён объект
// поток_вывода - поток байтов, куда этот объект может быть выведен

// Объект, имплементирующий этот интерфейс должен определить методы
@Override
public void writeExternal(ObjectOutput out) throws IOException

@Override
public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException
```

**Интерфейс ObjectOutput**

Расширяет `AutoCloseable` , `DataOutput` . Поддерживает сериализацию. Все методы, при возникновении ошибок генерируют исключение типа `IOException` 

```java
void close()
void flush()
void write(byte[] buffer) // Записывает массив байтов в вызывающий поток вывода
void write(byte[] buffer, int смещение, int количество_байтов)
void write(int b) // Записывает одиночный байт(младший) в вызывающий поток
void writeObject(Object объект) //
```

**Класс ObjectOutputStream**

Расширяет класс `OutputStream`  и реализует интерфейс `ObjectOutput` . Имеется вложенный класс `PutField` , упрощающий запись постоянных полей.

Класс `ObjectOutputStream`  отвечает за вывод объекта в поток.

```java
// Constructor
ObjectOutputStream(OutputStream поток_вывода) throws IOException
// поток_вывода - поток, в который могут быть выведены сериализуемые объекты

void writeBoolean(boolean b)
void writeByte(int b)
voie writeChar(int c)
......
final void writeObject(Object объект)
```

**Интерфейс ObjectInput**

Расширяет интерфейсы `AutoCloseable`  и `DataInput` . 

```java
int available()
void close()
int read() // возвращает целочисленное представление следующего байта или -1
int read(byte[] buffer) // пытается прочитать в указанный массив. возвращает
// количество прочитанных байтов. По достижении конца файла возвращает -1
int read(byte[] buffer, int смещение, int количество_байтов)
Object readObject() // читает объект из вызывающего потока ввода
Long skip(long количество_байтов)
```

**Класс ObjectInputStream**

Расширяет класс `InputStream`  и реализует интерфейс `ObjectInput` .

Класс `ObjectInputStream` отвечает за ввод объектов из потока.

```java
// Constructor
ObjectInputStream(InputStream поток_ввода) throws IOException
// поток_ввода - поток, из которого должен быть введён сериализованный объект

boolean readBoolean()
byte readByte()
....
final Object readObject()
```

Для сериализуемых классов обычно требуется определить статическую `static long` константу `serialVersionUID`  как закрытый член класса. Хотя её значение определяется в Java автоматически, в реальных программах лучше определять её вручную.

Чтобы сериализовать объекты в формат json и xml можно воспользоваться возможностями фрэймворка jackson. Для этого нужно подключить зависимости в `pom.xml` 

```xml
<dependencies>
        <!-- Добавляем зависимость для Jackson -->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.16.0</version>
        </dependency>
        <!-- Поддержка xml-сериализатора -->
        <dependency>
            <groupId>com.fasterxml.jackson.dataformat</groupId>
            <artifactId>jackson-dataformat-xml</artifactId>
            <version>2.16.0</version>
        </dependency>
    </dependencies>
```

Jackson предоставляет классы для сериализации объектов

```java
private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final XmlMapper xmlMapper = new XmlMapper();
```

```java
// Сериализация в json
objectMapper.configure(SerializationFeature.INDENT_OUTPUT, true);
                objectMapper.writeValue(new File(fileName), tasks);

//Десериализация из json в составной объект List<ToDoV2> tasks
tasks = objectMapper.readValue(file, 
                  objectMapper.getTypeFactory()
                              .constructCollectionType(List.class, ToDoV2.class));

// Сериализация в bin
try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(fileName))) {
                    oos.writeObject(tasks);

// Десериализация из bin в List<ToDoV2>
try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
                        tasks = (List<ToDoV2>) ois.readObject();}

// Сериализация в xml
xmlMapper.configure(SerializationFeature.INDENT_OUTPUT, true);
                xmlMapper.writeValue(new File(fileName), tasks);

// Десериализация из xml  в List<ToDoV2>
tasks = xmlMapper.readValue(file, 
                  xmlMapper.getTypeFactory()
                           .constructCollectionType(List.class, ToDoV2.class));
```


 флаги `SerializationFeature` 

```java
public enum SerializationFeature implements ConfigFeature {

WRAP_ROOT_VALUE(false),
INDENT_OUTPUT(false),
FAIL_ON_EMPTY_BEANS(true)
.........

}
```

