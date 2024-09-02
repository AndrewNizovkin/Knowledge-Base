# Меню

Для поддержания системы меню в Swing используются классы, являющиеся подклассами класса AbstractButton (кроме JSeparator):

```java
JMenuBar

JMenu

JMenuItem

JCheckBoxMenuItem

JRadioButtonMenuItem

JSeparator

JPopupMenu
```

Экземпляр JMenuBar добавляется во фрейм верхнего уровня:

```java
void setJMenuBar(JMenuBar mb)

```

JMenuBar представляет собой контейнер для объектов JMenu, которые могут иметь произвольный уровень вложенности. Компоненты добавляются или удаляются одним из методов:

```java
JMenu add(JMenu menu)

Component add(Component menu, int idx)

void remove(Component menu)

void remove(int idx)
```

### JMenu

```java
JMenu()

JMenu(String name)

JMenu(Action action)
```

Некоторые методы:

```java
JMenuItem add(JMenuItem item)

JMenuItem add(Component item, int idx)

void addSepatator()

void insertSeparator(int idx)

int getMenuComponentCount()

Component[] getMenuComponents()

...........
```

### JMenuItem

```java
JMenuItem()

JMenuItem(String name)

JMenuItem(Icon image)

JMenuItem(String name, Icon image)

JMenuItem(String name, int mnem)

JMenuItem(Action action)
```

Как правило, при работе с компонентами меню, обрабатывается событие ActionEvent.

Для поддержки доступа к пунктам меню (JMenu, JMenuItem) с клавиатуры используются два механизма:

- мнемонические обозначения задают клавишу, позволяющую выбрать пункт активизированного меню:

- клавиши быстрого доступа позволяют выбирать пункты любого меню. Предварительная активация не требуется.

```java
void setMnemonic(int mnem)
// mnem: KeyEvent.VK_F, KeyEvent.VK_A,...

void setDisplayedMnemonicIndex(int idx)
// idx: индекс подчёркнутого символа (def: первый)

void setAccelerator(KeyStroke ks)
// ks: комбинация клавиш, которую надо нажать
```

Класс KeyStroke содержит несколько фабричных методов:

```java
static KeyStroke getKeyStroke(char ch)

static KeyStroke getKeyStroke(Character ch, int modifier)

static KeyStroke getKeyStroke(int ch, int modifier)

// ch: KeyEvent.VK_A, KeyEvent.VK_B,...
// modifier: InputEvent.ALT_MASK, InputEvent.CTRL_MASK, InputEvent.SHIFT_MASK, InputEvent.META_MASK
```

Существует возможность добавлять и удалять пункты меню из программы с помощью методов add(), remove(), унаследованных от класса JContainer.

### JPopupMenu

```java
JPopupMenu()

JPopupMenu(String name) 
```

Процесс активизации контекстного меню включает три этапа:

1. Нужно зарегистрировать обработчик событий, связанных с мышью. 

```java
void addMouseListener(MouseListener ml)

```

1. При выполнении обработчика следует проверять состояние переключателя контекстного меню, используя метод класс MouseEvent:

```java
boolean isPopupTrigger() // true, если событие мыши представляет
// переключатель контекстного меню
```

1. Если переключатель контекстного меню установлен, надо отобразить меню путём вызова метода show():

```java
void show(Copmpnent invoker, int upperX, int upperY)
```

В интерфейсе MouseListener определено четыре метода:

```java
void mouseClicked(MouseEvent me)

void mouseEntered(MouseEvent me)

void mousePressed(MouseEvent me) // устанавливает переключатель контекстного меню

void mouseReleased(MouseEvent me) // устанавливает переключатель контекстного меню
```

Таким образом, для реализации контекстного меню, достаточно использовать класс MouseAdapter.

В классе MouseEvent определены несколько методов, вот некоторые часто используемые:

```java
int getX() 

int getY()

boolean isPopupTrigger()

Component getComponent()

// X, Y: текущие относительно источника события. Определяют
// левый верхний угол контекстного меню.
```

### JToolBar

```java
JToolBar()

JToolBar(String title)

JToolBar(int how)

JToolBar(String title, int how)

// title: отображается только если панель инструментов перетаскивается
// how: JToolBar.HORIZONTAL, JToolBar.VERTICAL
```

Кнопки и другие компоненты добавляются методом add().

Некоторые методы класса JToolBar:

```java
void add(Action actObj)

void addSeparator()

void addSeparator(Dimension dim)

void setFlotable(boolean canFloat)

void setRollover(boolean on) // отслеживать факт помещения курсора мыши.
```

### Действие.

это экземпляр класса, реализующего интерфейс Action, который расширяет интерфейс ActionListener и предоставляет средства для объединения информации о состоянии с обработчиком событий actionPerformed(). Это позволяет управлять несколькими компонентами посредством одного действия.

Действие инкапсулирует следующие возможности:

- Управление клавишами быстрого доступа

- Управление мнемоническими обозначениями

- Поддержка имени

- Поддержка пиктограммы

- Управление строкой подсказки

- Поддержка описания

- Поддержка команды действия

- Управление доступом

Кроме унаследованного actionPerformed, в Action определены собственные методы и особый интерес представляют putValue(), getValue(), которые позволяют получать значение по ключу.

```java

void addPropetyChangeListener(PropertyChangeListener pcl)

void setEnabled(boolean enabled)

boolean isEnabled()

void getValue(String key)

void putValue(String key, Object val)

// key: ACCELERATOR_KEY, ACTION_COMMAND_KEY,....

// Ex:
actionOb.putValue(MNEMONIC_KEY, new Integer(KeyEvent.VK_X));

```

Класс AbstractAction реализует интерфейс Action и в большинстве случаев для своих целей достаточно наследовать от него, переопределив при этом метод actionPerformed().

```java
AbstractAction()

AbstractAction(String name)

AbstractAction(String name, Icon image)
```