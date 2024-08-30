# Потоки ввода-вывода IO

**InputStream, OutputStream**

это абстрактные классы, находящиеся на вершине иерархии потоков ввода-вывода

Объекты, реализующие эти классы поддерживают последовательное чтение из него байт (byte)

**Reader, Writer**

Абстрактные классы, описывающие поток символов. Объекты, реализующие эти классы поддерживают последовательное чтение из него символов (char).

[**System.in](http://System.in)** 

статическая переменная типа InputStream

**System.out, System.err**

это статические переменные типа PrintStream

```java
PrintStream console = System.out;
console.println("Hello")

// Выводим в поток строку
ByteArrayOutputStream stream = new ByteArrayOutputStream();
PrintStream console = new PrintStream(stream);
console.println("Hello");

// Читаем строку из консоли после нажатия Enter
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
String str = br.readLine();

```

**FileInputStream, FileOutputStream**

классы для чтения и записи файлов. Работают с байтами.

```java
// Constructor
FileInputStream(String fileName);

// читает один байт из файла и возвращает его как результат
int read();

// возвращает количество непрочитанных (доступных) байт
int available();

// закрывает поток
void close();

// Constructors
FileOutputStream(String fileName);
FileOutputStream(String fileName, boolean append);
FileOutputStream(File file);
FileOutputStream(File file, boolean append);

// Записывает очередной байт, образая data до одного байта
void write(int data);

// Требует немедленно записать всю несохранённую информацию на диск
void flush();

// закрывает поток
void close();
```

**Байтовые потоки ввода, вывода** 

FileInputStream(path), FileOutputStream(path) - возвращают и принимают байт (int)

.read(), write(int bt), close()

**Символьные потоки ввода, вывода**

.read(), write(int bt), close()

FileReader(path), FileWriter(path) - возвращают и принимают код символа (int)

**Буферизированные потоки ввода, вывода**

- BufferedReader(new FileReader(path))

- BufferedWriter(new FileWriter(path)) 

.readline(), .write(String line), .newLine(), close()

**Класс ByteArrayInputStream**

реализует поток ввода, использующий массив байтов в качестве источника данных.

```java
// Constructors
ByteArrayInputStream(byte[] array)
ByteArrayInputStream(byte[] array, int начало, int количество_байтов)
```

**Класс ByteArrayOutputStream**

реализует поток вывода, использующий массив байтов в качестве адресата.

```java
// Constructors
ByteArrayOutputStream() // создаётся буфер размером 32 байта
ByteArrayOutputStream(int количество_байтов)

ByteArrayOutputStream f = new ByteArrayOutputStream();
String s = "Test text";
byte[] buf = s.getBytes();
f.write(buf);

// из потока в массив
byte[] b = f.toByteArray();

// из потока в поток
FileOutputStream f2 = new FileOutputStream("Test.txt");
f.writeTo(f2);

// установка в исходное состояние
f.reset(); // устанавливает указатель на начало, если не mark
```

**Классы FilterOutputStream, FilterInputStream**

фильтруемые потоки ввода-вывода представляют собой оболочки, в которые заключаются базовые потоки ввода-вывода для расширения их функциональных возможностей

```java
FilterOutputStream(OutputStream os)
FilterUnputStream(InputStream is)
```

**Класс SequenceInputStream**

позволяет соединить вместе несколько потоков ввода типа InputStream

```java
SequenceInputStream(InputStream первый_поток, InputStream второй поток)
SequenceInputStream(Enumerations<? extends InputStream> перечисление_потоков)
```

**Классы DataOutputStream, DataInputStream**

эти классы позволяют выводить примитивные данные в поток или вводить их из потока. Они, в том числе, реализуют интерфейсы DataOutput и DataInput

```java
// Constructors
DataOutputStream(OutputStream поток_вывода)
// поток_вывода обозначает поток, в который будут выводиться данные.
DataInputStream(InputStream поток_ввода)
// поток_ввода обозначает тот поток, из которого будут вводиться данные.

// Методы из интерфейса DataOutput
final void writeDouble(double значение) throws IOException
final void writeBoolean(boolean значение) throws IOException
final void writeInt(int значение) throws IOException

// Методы из интерфейса DataInput
final double readDouble() throws IOException
final boolean readBoolean() throws IOException
final int readInt() throws IOException

```

**Класс RandomAccessFile**

инкапсулирует файл произвольного доступа. Реализует интерфейсы `DataInput`  и `DataOutput` . 

Этот класс отличается поддержкой запросов на позиционирование, что позволяет установить указатель файла на любой позиции.

```java
RandomAccessFile(File file, String доступ) throws FileNotException
RandomAccessFile(String fileName, String доступ) throws FileNotException
// доступ  принимает следующие значения:
// "r" - данные можно прочитать из файла
// "rw" - данные можно прочитать и записать
// "rws" - данные можно прочитать из файла и каждое изменение немедленно
// выводится на физическое устройство

// Установить указатель файла на текущей позиции
void seek(long новая_позиция) throws IOException
// новая_позиция - отсчитывается в байтах от начала файла

// Установать длину вызывающего файла
void setLenth(long днина) throws IOException
```

**Класс Console**

Служит для ввода-вывода на консоль, если таковая имеется, и реализует интерфейс `Flushable` .

Является служебным, поскольку функционирует, в основном через стандартные потоки ввода-вывода [`System.in`](http://System.in)  и `System.out` . Конструкторов нет и он получается в результате вызова статического метода console()

```java
static void System.console()
// Консоль может быть доступна не во всех классах, тогда возвращается null

Console console = System.console();

// Использует строку приглашения
String str = console.readLine("Введите строку: ");

```