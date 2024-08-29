# Диалоговые окна

### JOptionPane

Все окна, создаваемые с помощью класса JOptionPane, являются модальными.

В этом классе определены четыре фабричных статических метода для создания черырёх различных диалога:

- showConfirmDialog()

- showInputDialog()

- showMessageDialog()

- showOptionDialog()

Все методы перегружены и позволяют гибко настраивать форму диалога.

```java
public static void showMessageDialog(Component parentComponent,
                                     Object message)
                              throws HeadlessException

public static void showMessageDialog(Component parentComponent,
                                     Object message,
                                     String title,
                                     int messageType,
                                     Icon icon)
                              throws HeadlessException
                             
// messageType: ERROR_MESSAGE, INFORMATION_MESSAGE, PLAIN_MESSAGE, QUESTION_MESSAGE, WARNING_MESSAGE                             
```

### JDialog

```java
JDialog()

JDialog(Frame parent)

JDialog(Frame parent, String title)

JDialog(Frame parent, boolean isModal)

.....
```

### JFileChooser

```java
JFileChooser()

JFileChooser(File dir)

JFileChooser(String dir)
```

Для отображения на экране нужно вызвать один из методов:

```java
int ShowOpenDialog(Component parent) throws HeadlessException

int ShowSaveDialog(Component parent) throws HeadlessException

int ShowDialog(Component parent, String name) throws HeadlessException

// Возвр: APPROVE_OPTION, CANCEL_OPTION, ERROR_OPTION
```

Некоторые методы FileChooser:

```java
File getSelectedFile()

File[] getSelectedFiles()

void setFileSelectionMode(int fsm)

void setFileFilter(FileFilter ff)

void setMultiSelectionEnabled(boolean on)

void setFileHidingEnabled(boolean on)

// fsm: FILES_ONLY, DIRECTORIES_ONLY, FILES_AND_DIRECTORIES
```

Для от ображения конкретных типов файлов, нужно использовать фильтры, представляющие собой экземпляры классов, расширяющих абстрактный класс FileFilter из пакета javax.swing.filechooser, в котором объявлены методы:

```java
abstract boolean accept(File file)

abstract String getDescription()
```

При использовании фильтров разработчика, каталоги не отображаются. Изменить это поведение можно, добавив соответствующий код в метод accept():

```java
if (file.isDirectory()) return true;

if (file.getName().endWith(".java")) return true;
// отобразит только *.java
```

### JColorChoser

В этом классе определены три конструктора, но обычно для создания окна выбора цвета применяется статический метод:

```java
static Color showDialog(Component parent, 
  String title, Color initClr) 
                       throws HeadlessException
```