# Диспетчеры компоновки

### GridLayout

```java
GridLayout()

GridLayout(int rows, int cols)

GridLayout(int rows, int cols, int hgap, int vgap)

// hgap, vgap: зазор по горизонтали и вертикали
```

Все компоненты имеют одинаковый размер.

Все компоненты всегда выводятся на экран вне зависимости от размеров окна.

### GridBagLayout

```java
GridBagLayout()
```

Компоненты располагаются в ячейках таблицы, которые могут иметь разные размеры.

Расположение и размер каждого компонента в таблице определяется набором ограничений, описываемых объектом GridBagConstraints

При использовании в качестве диспетчера компоновки GridBagLayout, для каждого компонента перед добавлением в контейнер, устанавливаются ограничения посредством его метода:

```java
void setConstraints(Component comp, GridBagConstraints cons)
```

В классе GridBagConstraints определены поля, значения которых управляют размером, размещением компонентов и расстоянием между ними:

```java
int ancor
// расположение в ячейке: GridBagConstraints.CENTER(def),
// .NORTH, .SOUTHEAST, ...
// или относительные: .FIRST_LINE_END, .PAGE_END, ....

int fill
// Определяет порядок изменения размеров компонента,
// если он меньше ячейки: GridBagConstraints.NONE(def),
// .HORIZONTAL, .VERTICAL, .BOTH

int gridheight 
// высота компонента (в ячейках)

int gridwidth

int gridX
// коорд. X ячейки в которую помещается компонент
// GridBagConstraints.RELATIVE (def)

int gridY

Insets insets 
// Размеры обрамления (0, 0, 0, 0 def)

int ipadx
// определяет горизонтальный размер дополнительного 
// пространства вокруг компонента (0 def)

int ipady

double weightx
// определяет порядок распределения пространства
// по горизонтали между соседними ячейками, а также
// между ячейками и краями контейнера
// при всех 0.0 (def) доп простр выделяется на краях контейнера
// и распределяется равномерно

double weigthy

```

Чтобы указать, что компонент должен использовать всё остальное пространство в строке нужно для gridwidth указать значение GridBagConstraints.REMAINDER.

Чтобы указать, что компонент должен быть предпоследним в строке нужно указать GridBagConstraints.RELATIVE. 

То же справедливо и для размеров по вертикали.

### BoxLayout

Позволяет создавать группы элементов, расположенные горизонтально или вертикально.

Кроме обычного способа использования диспетчеров компоновки, Swing предлагает более удобный способ создания контейнеров с использованием класса Box.

Объект Box можно создать двумя способами:

- С помощью конструктора:

```java
Box(int orientation())

// orientation: X_AXIS, Y_AXIS, LINE_AXIS, PAGE_AXIS
```

С использованием фабричных методов класса Box:

```java
static Box createHorizontalBox()

static Box createVerticalBox()
```

Box предоставляет несколько механизмов для добавления пустого пространства.

Можно включить в контейнер объект, называемый *жёсткой областью*, с помощью метода:

```java
static Component createRigidArea(Dimension dim)
```

Чтобы управлять расширением зазора между компонентами можно использовать механизм склейки (glue). Дополнительное пространство распределяется между склеенными компонентами.

```java
static Component createHorizontalGlue()

static Component createVerticalGlue()

```

Распорка (struts) - это объект, имеющий один фиксированный и один переменный размер. Ширина горизонтальной распорки фиксирована, а высота может меняться. Аналогично для вертикальной распорки.

```java
static Component createHorizontalStrut(int width)

static Component createVerticalStrut(int height)

```

### CardLayout

```java
CardLayout()

CardLayout(int hgap, int vhap)
```

Очередная “карта” добавляется к контейнеру с менеджером компоновки CardLayout, обычно добавляется посредством метода:

```java
void add(Component comp, String name)
```

Для активации (отображения на переднем плане) конкретных “карт” служат следующие методы класса CardLayout:

```java
void show(Container parent, String name)

void first(Container parent)

void last(Container parent)

void next(Container parent)

void previous(Container parent)
```