# Кнопки

**Все классы кнопок являются подклассами AbstractButton, который расширяет класс JComponent.**

- класс AbstractButton также является суперклассом для класса JMenuItem

```java
JButton // Обычная кнопка 
// (ActionAvent, ChangeAvent)

JToggleButton 
// Кнопка с двумя состояниями 
// (ActionAvent, ChangeAvent, ItemEvent)

JCheckBox // Флажок опции
// (ActionAvent, ChangeAvent, ItemEvent)

JRadioButton // Группа переключателей опций
// (ActionAvent, ChangeAvent, ItemEvent)

```

В частности, в классе AbstractButton определены методы, позволяющие задавать пиктограммы, для отображения в различных состояниях:

- деактивизированной
- нажатой
- выбранной
- кнопке, на которой размещён курсор мыши

Часто используемые методы, определённые в классе AbstractButton:

```java
void addActionListener(ActionListener al)

String getText()

void doClic() // Имитирует щелчок на кнопке

ButtonModel getModel()

// ......
```

и много других…

События, связанные с кнопками можно условно разделить на три категории:

- **action event** - события действия

- **item event** - события элемента

- **change event** - события изменения состояния

### JButton

Идентифицировать компонент, сгенерировавший action event можно двумя способами, используя методы объекта ActionAvent:

```java
String getActionCommand() // Совпадает с надписью на кнопке

Object getSource() // возвр. ссылку на объект
```

Обнаружить, была ли нажата какая-нибудь из клавиш модификаторов (<Alt>, <Ctrl>, <META>, <Shift>:

```java
int getModifiers()
// возвр. значение формируется объединением констант:
// ALT_MASK, CTRL_MASK, META_MASK, SHIFT_MASK
```

Получить время возникновения события:

```java
long getWhen()
```

Чтобы сделать кнопку myButton по умолчанию в окне myFrame, нужно поместить следующую команду перед вызовом метода setVisible()

```java
myFrame.getRootPane().setDefaultButton(myButton);
```

```java
void setMnevonic(char mnemonic)
```

Для объектов JButton, JToggleButton можно использовать мнемонические обозначения для клавиш, нажимаемых с комбинацией с <Alt>:

Событие изменения состояния (change event) объекта типа JButton, прослушиваемое объектом типа ChangeListener возникают в модели ButtonModel, доступ к которой можно получить с помощью метода объекта JButton, JToggleButton:

```java
ButtonModel getModel() 
```

В классе ButtonModel для доступа к свойствам кнопки определены методы:

```java
boolean isArmed() // нажата, но не отпущен

boolean isEnabled() // доступна

boolean isPressed() // была нажата

boolean isRollover() // курсор мыши был наведён

boolean isSelected() // выбрана (для JToggleButton)
```

### JToggleButton

Класс JToggleButton является подклассом AbstractButton и является суперклассом для JCheckBox и JRadioButton. Он определяет базовые функции для компонентов с двумя состояниями.

Событие элемента (ItemEvent) используется для реализации выбора и  обрабатывается объектом типа ItemListener, так же являющегося функциональным интерфейсом с методом itemStateChanged(). ItemEvent позволяет получить ссылку на объект типа ToggleButton c помощью метода:

```java
Object getItem() 

int getStateChange() // нажата или отпущена
// возвращает ItemEvent.SELECTED, ItemEvent.DESELECTED
```

### JCheckBox

Этот класс наследует от JToggleButton

При установке или сбросе флажка генерируется событие элемента (ItemAction). Для обработки этого события используется метод itemStateChanged() интерфейса ItemListenter:

```java
void itemStateChanged(ItemEvent e)
```

в теле которого можно использовать методы объекта ItemAction:

```java
Object getItem() 
// ссылка на объект, сгенерировавший событие

ItemSelectable getStateChange()
// возвращает ItemEvent.SELECTED, ItemEvent.DESELECTED
```

Как альтернативный вариант можно проанализировать состояние флажка использовав метод isSelected(), унаследованный от класса AbstractButton.

### JRadioButton

Этот класс наследует от JToggleButton и предназначен для выбора одного из взаимоисключающих значений.

В каждый момент может быть выбрана только одна кнопка из группы ButtonGroup, которую нужно создать и добавить в неё компоненты:

```java
Component add(Component component)
```

При выборе или отмене выбора элемент JRadioButton генерирует события действий (ActionEvent), элемента (ItemEvent) и изменения состояния (ChangeEvent).

Чаще всего обрабатывается событие действия и анализируется состояние компонента или группы компонентов.