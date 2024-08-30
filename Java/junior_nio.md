# Система ввода-вывода NIO

NIO построена на двух базовых элементах: буферах и каналах. В буфере хранятся данные, а канал предоставляет открытое соединение с устройством ввода-вывода, например файлом или сокетом.

**Абстрактный класс Buffer**

это суперкласс, в котором определяются основные функциональные возможности для каждого буфера, в том числе:

- Текущая позиция определяет индекс в буфере, с которого в следующий раз начнётся операция чтения или записи данных.

- Предел определяет значение индекса за позицией последней доступной ячейки в буфере.

- Ёмкость определяет количество элементов, которые можно хранить в буфере.

Зачастую предел равен ёмкости.

```java
abstract Object array()

abstract int arrayOffset()

final int capacity() // допустимое количество элементов для храния в буфере

final Buffer clear() // Очищает вызывающий буфер и возвр ссылку на него

final Buffer flip() // Задаёт текущую позицию в качестве предела для вызывающего

abstract boolean hasArray() // поддерживается ли массивом

final boolean hasRemaining() // Остались ли элементы

final int limit() // Предел

final Buffer limit(int предел) // Задаёт предел

final int position() // Текущая позиция

final Buffer position(int n)

int remaining() // количество элементов до предела (предел - тек.поз)

final Buffer mark()

final Buffer reset() // Устанавливает текущую позицию на установленной метке

final Buffer rewind() // Текущую позицию в нуль.

abstract Buffer slice() // Срез из элементов, начиная с текущего
```

От класса `Buffer`  происходят классы конкретных буферов:

- ByteBuffer
- CharBuffer
- DoubleBuffer
- FloatBuffer
- IntBuffer
- LongBuffer
- MappedByteBuffer
- ShortBuffer

Все они предоставляют методы get(), put() и пр.

**Интерфейс Channel**

этот интерфейс реализуют классы каналов. Канал представляет открытое соединение с источником или адресатом ввода-вывода.

Один из способов получения канала подразумевает вызов метода `getChannel()` для объекта, поддерживающего каналы. Например:

- DatagramSocket
- FileInputStream
- FileOutputStream
- RandomAccessFile
- ServerSocket
- Socket

Например для `FileInputStream` , `FileOutputStream` или `RandomAccessFile`  он возвращает `FileChannel` , а для `Socket`  возвращает канал типа `SocketChannel` 

Ещё один способ - использование статических методов класса `Files` , например для получения байтового канала вызвать метод `Files.newByteChannel()` 

```java
// Методы read(), write() из класса FileChannel

abstract int read(ByteBuffer bb) throws IOException 
// читает байты из вызывающего канала в указанный буфер,
// пока не исчерпается буфер или вводимые данные

abstract int read(ByteBuffer bb, long начало) throws IOException

abstract int write(ByteBuffer bb) throws IOException
// Записывает содержимое байтового буфера в вызывающий канал,
// начиная с текущей позиции

abstract int write(ByteBuffer bb, long начало) throws IOException
// начало - количество байтов от начала в вызывающем FileChannel

```

**Селектор**

обеспечивает возможность многоканального ввода-вывода.

**Интерфейс Path**

инкапсулирует путь к файлу и предоставляет методы для манипулирования им.

```java
boolean endWith(String путь) 
// заканчивается ли вызывающий path указанным

boolean endWith(Path путь)

boolean startWith(String путь)

Path getFileName() 
// имя файла, связанное с вызывающим path

Path getName(int индекс) 
// имя элемента пути по указанному индексу (от 0 до getNameCount() - 1)

int getNameCount() 
// количество элементов(кроме корневого)

Path getParent() 
// весь путь, кроме имени файла, определяемого вызывающим объектом

Path getRoot() 
// корневой каталог

boolean isAbsolute()
// абсолютный ли это путь

Path resolve(Path путь)
// если путь не содержит корневой каталог, то он предваряется 
// корневым каталогом из вызывающего

Path toAbsolutePath()
// абсолюнтый путь

String toString()

default File toFile()
```

**Класс Files**

предоставляет ряд методов для манипуляций с файлами

```java
static boolean exists(Path path,
 LinkOption... options
// чтобы предотвратить следование по символическим ссылкам
// option должен быть LinkOption.NOFOLLOW_LINKS

static void delete(Path path)
                   throws IOException

static boolean deleteIfExists(Path path)
                              throws IOException

static boolean isDirectory(Path path,
 LinkOption... options)
// чтобы предотвратить следование по символическим ссылкам
// option должен быть LinkOption.NOFOLLOW_LINKS

static Path copy(Path source,
 Path target,
 CopyOption... options)
                 throws IOException

static Path createDirectory(Path dir,
 FileAttribute<?>... attrs)
                            throws IOException

tatic Path createFile(Path path,
 FileAttribute<?>... attrs)
                       throws IOException

static Stream<Path> list(Path dir)
// поток данных, состоящий из компонентов дирректории dir

static Stream<Path> walk(Path start,
 int maxDepth,
 FileVisitOption... options)
                         throws IOException
// поток данных, начиная с корня start

static Stream<String> lines(Path path)
                            throws IOException
// поток строк файла

static Stream<Path> find(Path start,
 int maxDepth,
 BiPredicate<Path,BasicFileAttributes> matcher,
 FileVisitOption... options)
                         throws IOException

static <A extends BasicFileAttributes> A readAttributes(Path path,
 Class<A> type,
 LinkOption... options) throws IOException
// возвращает объект, инкапсулирующий атрибуты файла

static SeekableByteChannel newByteChannel(Path path,
 OpenOption... options)
                            throws IOException

```

**Класс Paths**

Экземпляр типа `Path`  можно получить вызвав статический метод класса `Paths` 

```java
static Path get(String first,
 String... more)

static Path get(URI uri)
```

### Интерфейсы атрибутов файлов

**Интерфейc BasicFileAttributes**

находится на вершине иерархии

```java
FileTime creationTime() // время создания

Object fileKey()

boolean isDirectory()

boolean isOther() // если НЕ файл, а символическая ссылка или каталог

boolean isSymbolicLink()

FileTime lastAccessTime()

FileTime lastModifiedTime()

long size()
```

**Интерфейс DosFileAttributes**

описывает атрибуты, связанные с файловой системой FAT

```java
boolean isArchive()

boolean isHidden()

boolean isReadOnly()

boolean isSystem()
```

**Интерфейс PosixAttributes**

описывает атрибуты, определённые по стандартам POSIX (Portable Operating System Interface - переносимый интерфейс операционных систем).

```java
GroupPrincipal group() // груповой владелец файла

UserPrincipal owner() // отдельный владелец файла

set<PosixFilePermmission> permissions() // полномочия доступа к файлам
```