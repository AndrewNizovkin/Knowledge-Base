# Файловые системы. Потоки вода-вывода. Пакет java.io

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5533911/attachment/ebe37c3a20fcdc939394d61b6c756d07.pdf)

---

**Файловая система**

это способ разбиения диска на сегменты, чтобы записывать туда данные

### MBR, GPT

ОС Linux, например, предоставляет возможность разбивки жесткого диска компьютера на отдельные разделы. Пользователи могут определить их границы по так называемым таблицам разделов. Основная загрузочная запись (MBR) и таблица разделов GUID (GPT) – это два стиля формата разделов, которые позволяют компьютеру загружать операционную систему с жесткого диска, а также индексировать и упорядочивать данные. Основная загрузочная запись (MBR) – устаревшая форма разделения загрузочного сектора – первый сектор диска, который содержит информацию о том, как разбит диск. Он также содержит загрузчик, который сообщает компьютеру, как загрузить ОС. Main Boot Record состоит из трех частей:

- Основной загрузчик – MBR резервирует первые байты дискового пространства для основного загрузчика. Windows размещает здесь очень упрощенный загрузчик, в то время как другие ОС могут размещать более сложные многоступенчатые загрузчики.
- Таблица разделов диска – таблица разделов диска находится в нулевом цилиндре, нулевой головке и первом секторе жёсткого диска. Она хранит информацию о том, как разбит диск. MBR выделяет 16 байт данных для каждой записи раздела и может выделить всего 64 байта. Таким образом, Main Boot Record может адресовать не более четырёх основных разделов или трёх основных раздела 
и один расширенный раздел.
- Конечная подпись – это 2-байтовая подпись, которая отмечает конец MBR. Всегда устанавливается в шестнадцатеричное значение 0x55AA.

### Windows

**Файловая система FAT32**

- возможность перемещения корневого каталога
- - возможность хранения резервных копий

**Файловая система NTFS**

(от англ. New Technology File System), файловая система новой технологии

- права доступа
- Шифрование данных
- Дисковые квоты
- Хранение разреженных файлов
- Журналирование

## Файловая система и представление данных

### File

```java
File file = new File("file.txt");
```

 Использования файла для директории:

```java
File folder = new File(".");
for (File file : folder.listFiles())
System.out.println(file.getName());
```

Если просто указать имя файла, то будет использован файл в той же папке, что исполняемая программа, а если указана точка, то это означает использование непосредственно данной папки. метод listFiles() возвращает список файлов из указанной папки. А метод getName() выдаёт имя файла с расширением.

Методы класса File:

```java
System.out.println("Is it a folder - " + folder.isDirectory());
System.out.println("Is it a file - " + folder.isFile());
File file = new File("./Dockerfile");
System.out.println("Length file - " + file.length());
System.out.println("Absolute path - " + file.getAbsolutePath());
System.out.println("Total space on disk - " +
folder.getTotalSpace());
System.out.println("File deleted - " + file.delete());
System.out.println("File exists - " + file.exists());
System.out.println("Free space on disk - " +
folder.getFreeSpace());
```

### Paths, Path, Files, FileSystem

Вместо единого класса File появились три класса: Paths, Path и Files. Также
появился класс FileSystem, который предоставляет интерфейс к файловой системе.

- URI – Uniform Resource Identifier (унифицированный идентификатор ресурса);
- URL – Uniform Resource Locator  (унифицированный определитель  местонахождения ресурса);
- URN – Uniform Resource Name  (унифицированное имя ресурса).

Использование классов Path и Paths:

```java
Path filePath = Paths.get("pics/logo.png");
Path fileName = filePath.getFileName();
System.out.println("Filename: " + fileName);
Path parent = filePath.getParent(); 
System.out.println("Parent directory: " + parent);
boolean endWithTxt = filePath.endsWith("logo.png");
System.out.println("Ends with filepath: " + endWithTxt);
endWithTxt = filePath.endsWith("png");
System.out.println("Ends with string: " + endWithTxt);
boolean startsWithPics = filePath.startsWith("pics");
System.out.println("Starts with filepath: " + startsWithPics);
```

🔥 В методы startsWith() и endsWith() нужно передавать путь, а не просто
набор символов: в противном случае результатом всегда будет false, даже
если текущий путь действительно заканчивается такой последовательностью символов

Если в программе появился путь, использующий "." или "..", метод normalize() позволит удалить их и получить путь, в котором они не будут содержаться.

```java
Path path = Paths.get("./sources-draft/../pics/logo.png");
System.out.println(path.normalize());
```

Files — это утилитарный класс, куда были вынесены статические методы из класса File. Он сосредоточен на управлении файлами и директориями.

```java
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
Path file = Files.createFile(Paths.get("../pics/file.txt"));
System.out.print("Was the file captured successfully in pics
directory? ");
System.out.println(Files.exists(Paths.get("../pics/file.txt")));
Path testDirectory = Files.createDirectory(Paths.get("./testing"));
System.out.print("Was the test directory created successfully? ");
System.out.println(Files.exists(Paths.get("./testing")));
file = Files.move(file, Paths.get("./testing/file.txt"), REPLACE_EXISTING);
System.out.print("Is our file still in the pics directory? ");
System.out.println(Files.exists(Paths.get("../pics/file.txt")));
System.out.print("Has our file been moved to testDirectory? ");
System.out.println(Files.exists(Paths.get("./testing/file.txt")));
Path copyFile = Files.copy(file, Paths.get("../pics/file.txt"), REPLACE_EXISTING);
System.out.print("Has our file been copied to pics directory? ");
System.out.println(Files.exists(Paths.get("../pics/file.txt")));
Files.delete(file);
System.out.print("Does the file exist in test directory? ");
System.out.println(Files.exists(Paths.get("./testing/file.txt")));
System.out.print("Does the test directory exist? ");
System.out.println(Files.exists(Paths.get("./testing")));
```

Класс Files позволяет не только управлять самими файлами, но и работать с его содержимым. Для записи данных в файл у него есть метод write(), а для чтения: read(), readAllBytes() и readAllLines().

```java
List lines = Arrays.asList( "The cat wants to play with you", "But you don't want to play with it");
Path file = Files.createFile(Paths.get("cat.txt"));
if (Files.exists(file)) {
    Files.write(file, lines, StandardCharsets.UTF_8);
    lines = Files.readAllLines(Paths.get("cat.txt"), StandardCharsets.UTF_8);
    for (String s : lines) {
        System.out.println(s);
    }
}
```

## Потоки ввода-вывода, пакет [java.io](http://java.io/)

💡 В Java для описания работы по вводу/выводу используется специальное понятие потока данных (stream). Поток данных это абстракция, физически никакие потоки в компьютере никуда не текут.

### **Классы InputStream и OutputStream**

InputStream

это базовый абстрактный класс для потоков ввода, т.е. чтения. InputStream описывает базовые методы для работы со входящими байтовыми потоками данных

OutputStream

это базовый абстрактный класс для потоков вывода, т.е. записи. В
классе OutputStream аналогичным образом определяются три метода write() – один принимающий в качестве параметра int, второй – byte[] и третий – byte[], и два int-числа

Реализация потока вывода может быть такой, что данные записываются не сразу, а хранятся некоторое время в памяти. Чтобы убедиться, что данные записаны в поток, а не хранятся в буфере, вызывается метод flush(). Когда работа с потоком закончена, его следует закрыть, для этого
вызывается метод close().

### Классы ByteArrayInputStream и ByteArrayOutputStream

Класс ByteArrayInputStream представляет собой поток, считывающий данные из массива байт. Этот класс имеет конструктор, которому в качестве параметра передается массив byte[].

Соответственно, при вызове методов read() возвращаемые данные будут браться именно из этого массива.

Класс ByteArrayOutputStream применяется для записи байт в массив.

Этот класс использует внутри себя объект byte[], куда записывает данные, передаваемые при вызове методов write(). Чтобы получить записанные в массив данные, вызывается метод toByteArray(). В

```java
ByteArrayOutputStream out = new ByteArrayOutputStream();
out.write(1); 
4 out.write(-1);
out.write(0);
ByteArrayInputStream in = new
ByteArrayInputStream(out.toByteArray());
int value = in.read();
System.out.println("First element is - " + value); 11 12 value = in.read();
System.out.println("Second element is - " + value + ". If (byte)value - " + (byte)value); 15 16 value = in.read();
System.out.println("Third element is - " + value);
```

### Классы FileInputStream и FileOutputStream

Класс FileInputStream используется для чтения данных из файла. Конструктор такого класса в качестве параметра принимает название файла, из которого будет производиться считывание. При указании строки имени файла нужно учитывать, что она будет напрямую передана операционной системе, поэтому формат имени файла и пути к нему может различаться на разных платформах. Если при вызове этого конструктора передать строку, указывающую на несуществующий файл или каталог, то будет брошено java.io.FileNotFoundException. Если же объект успешно создан, то при вызове его методов read() возвращаемые значения будут считываться из указанного файла. Для записи байт в файл используется класс FileOutputStream. При создании объектов этого класса, то есть при вызовах его конструкторов, кроме имени файла, также можно указать, будут ли данные дописываться в конец файла, либо файл будет полностью перезаписан.
🔥 Если не указан флаг добавления, то всегда сразу после создания
FileOutputStream файл будет создан (содержимое существующего файла
будет стёрто).

### Другие потоковые классы

PipedInputStream и PipedOutputStream 

характеризуются тем, что их объекты всегда используются в паре – к одному объекту PipedInputStream привязывается (подключается) один объект PipedOutputStream. Они могут быть полезны, если в программе необходимо организовать обмен данными между модулями. Более явно выгода от использования проявляется при разработке многопоточных (multithread) приложений.

StringBufferInputStream (deprecated)

Иногда бывает удобно работать с текстовой строкой как с потоком байт. Для этого возможно воспользоваться классом StringBufferInputStream. При создании объекта этого класса необходимо передать конструктору объект String.

SequenceInputStream 

объединяет поток данных из других двух и более входных потоков. Данные будут вычитываться последовательно – сначала все данные из первого потока в списке, затем из второго, и так далее. Конец потока SequenceInputStream будет достигнут только тогда, когда будет достигнут конец потока, последнего в списке.

### BufferedInputStream и BufferedOutputStream

### String pool

Экземпляр класса String хранится в памяти, именуемой куча (heap), но есть некоторые нюансы. Если строка, созданная при помощи конструктора хранится непосредственно в куче, то строка, созданная как строковый литерал, уже хранится в специальном месте кучи — в так называемом пуле строк (string pool). В нем сохраняются исключительно уникальные значения строковых литералов. Процесс помещения строк в пул называется интернирование (от англ. interning, внедрение, интернирование). Когда объявляется переменная типа String ей присваивается строковый литерал, то JVM обращается в пул строк и ищет там такое же значение. Если пул содержит необходимое значение, то компилятор просто возвращает ссылку на соответствующий адрес строки без выделения дополнительной памяти. Если значение не найдено, то новая строка будет интернирована, а ссылка на нее возвращена и присвоена переменной.