# Текстовые компоненты.

В основе всех текстовых компонентов лежит абстрактный класс JTextComponent. Модель, используемая этим классом представлена интерфейсом Docement, который реализуется абстрактным классом AbstractDocument. Подклассы PlainDocument  и DefaultStyledDocument этого класса позволяют создавать реальные объекты. DefaultStyledDocument является также суперклассом для класса HTMLDocument.

Позиция курсора (caret) в документе определяет точку приложения следующего действия.

Текстовый курсор представляется посредством экземпляра класса, реализующего интерфейс Caret. Реализацией по умолчанию является класс DefaultCaret.

Некоторые методы класса JTextComponent:

```java
void copy() // копирует в буфер обмена выделенный текст

void cut()

void paste() // копирует содержимое буфера в состав компонента
// если фрагмент выделен, то заменяет его. Иначе на позицию курсора

void setCaretPosition(int newLoc)

void moveCaretPosition(int newLoc) // выделяет текст между исходным и 
// новым положением курсора

void selectAll()

String getSelectedText()

String getText()

void setText(String str)

String getText(int start, int lenth)

boolean isEditable()
```

При каждом изменении расположения текстового курсора генерируется событие CaretEvent.

В интерфейсе CaretListenet определён только один метод:

```java
void caretUpdate(CaretEvent ce)
```

Класс CaretEvent предоставляет методы:

```java
int getDot() // текущая позиция курсора

int getMark() // нпчало выделенного текста
```

### JTextField

По умолчанию использует модель PlainDocument.

```java
JTextField()

JTextField(int cols)

JTextField(String str)

JTextField(String str, int cols)

JTextField(Document model, String str, int cols)
```

При нажатии <Enter> генерируется событие ActionEvent.

С компонентом JTextField связывается команда действия:

```java
void setActionCommand(String cmd)
```

### JPasswordField

Имеет те же конструкторы, что и JTextField. Обращение к методам cut() и copy() запрещено. Применение метода getText() не рекомендовано.

Для получения пароля служит метод:

```java
char[] getPassword()
```

Можно установить заменитель символов, вместо стандартного (*):

```java
void setEchoChar(char echr)
```

### JFormattedTextField

```java
JFormattedTextField()

JFormattedTextField(Object contents) // создание на основе типа данных

JFormattedTextField(Format fmt) // на основе сведений о формате

JFormattedTextField(JFormattedTextField.AbstractFormatter absFmt) 
// на основе сведений о формате маски

JFormattedTextField(JFormattedTextField.AbstractFormatterFactory absFmtFact)

JFormattedTextField(JFormattedTextField.AbstractFormatterFactory absFmtFact, Object contents)
```

**Создание JFormattedTextField на основе типа данных.**

```java
JFormattedTextField jtf = new JFormattedTextField(10)
```

**Создание JFormattedTextField на основе сведений о формате.**

Подклассами абстрактного класса Format являются два абстрактных подкласса DateFormat и NumberFormat. Оба этих класса предоставляют фабричные методы:

```java
static final NumberFormat getCurrencyInstance()
// по умолчанию представление валюты для региона по умолчанию

Static final DataFormat getDateInstance(int dateStyle()
// dateStyle: DateFormat.SHORT, DateFormat.LONG, DateFormat.MEDIUM, DateFormat.FULL

// Examples

// 1
NumberFormat nf = NumberFormat.getCurrencyInstance();
nf.setMaximumIntegerDigits(5);
nf.setMaximumFractionDigits(2);
JFormattedTextField jftf = new JFormattedTextField(nf);
jftf.setColumns(15);
jftf.setValue(new Ingeger(7000));

//2
DataFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM);
JFormattedTextField jftf = new JFormattedTextField(df);
jftf.setColumns(15);
jftf.setValue(new Date); // инициализация текущей датой
```

**Создание JFormattedTextField на основе сведений о формате маски.**

Формат маски поддерживается классом MaskFormatter, который является подклассом класса JFormattedTextField.AbstractFormatter. 

```java
MaskFormatter(String fmtMask)
// fmtMask - стока, включающая литеральные символы (можно пропустить) и
// символы, отмечающие позиции

new MaskFormatter("ID: AA-LL-UU")

try {
    MaskFormatter mf = new MaskFormatter("##-##-##");
    JFormattedTextFiel jftf = new JFormattedTextField(mf);
    } catch (ParseException e) {
    System.out.println("Invalid Format);
    }

```

Используемые символы:

- A - буквы и цифры

- H - Шестнадцатеричные цифры

- L - Буквы (будут преобразованы в нижний регистр)

- U - Буквы (будут преобразованы в верхний регистр)

- \# - Цифры

- \* - Все символы

- ? - Все буквы

- ` - код, применяемый для литерального представления символов форматирования

Значение, соответствующее объекту JFormattedTextField преобразуется из текста, вводимого и видимого, после нажатия <Enter> или передаче фокуса другому компоненту. При стандартном поведении, в случае некорректного ввода, восстанавливается предыдущее значение. Поведение компонента можно изменить:

```java
void setFocusLostBehavior(int what)

// what: FormattedTextField.COMMIT_OR_REVERT, JFormattedTextField.REVERT, 
// JFormattedTextField.COMMIT or JFormattedTextField.PERSIS
```

Чтобы постоянно отслеживать изменение форматированного текста, надо обрабатывать событие изменения свойств PropertyChangeEvent.

В интерфейсе PropertyChangeListener определён только один метод:

```java
void propertyChange(PropertyChangeEvent pe)
```

В классе PropertyChangeEvent определены методы, позволяющие получить имя изменяемого свойства, его старое и новое значение.

Задать обработчик событий изменения можно двумя методами:

```java
void addPropertyChangeListener(PropertyChangeEvent pl)

void addPropertyChangeListener(String propName, PropertyChangeEvent pl)

// propName: value (для компонента JFormattedTextField)
```

Установить значение  для форматированного текста из программы:

```java
void setValue(Object val)

Object getValue()
```

### JTextArea

Позволяет вводить и редактировать несколько строк текста. Не поддерживает стили. По умолчанию использует модель PlainDocument. Генерирует события курсора и документа.

```java
JTextArea()

JTextArea(String str)

JTextArea(int numRows, int numCols)

JTextArea(String str, int numRows, int numCols)

JTextArea(Document model)
```

JTextArea обычно помещают в JScrollPane. При этом если длина вводимого текста превысит ширину компонента, то будет выведена горизонтальная полоса прокрутки. Это поведение по умолчанию. Если нужно, чтобы при достижении границы компонента происходил автоматический переход на следующую строку, нужно воспользоваться методом:

```java
void setLineWrap(boolean wrapOn)
```

По умолчанию осуществляется перенос  отдельных символов. Для переключения на режим переноса целого слова, нужно воспользоваться методом:

```java
void setWrapStyleWord(boolean breakOnWord)
```

Добавить текст из программы:

```java
void append(String str)

void insert(String str, ing idx)

void replaceRange(String str, int begin, int end)

```

Некоторые методы:

```java
void setTabSize(int newSize) // установить значение табуляции (def: 8)

int getLineCount() // количество строк, заканчивающихся переводом каретки
```