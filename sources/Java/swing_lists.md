# Списки.

### JList

Этот компонент основан на двух моделях (интерфейсах):

- ListModel определяет особенности доступа к данным списка. Класс DefaultModel его реализует.

- ListSelectionModel определяет какой пункт или пункты были выбраны. По умолчанию используется класс DefaultListSelection его реализующий.

```java
JList()

JList(Object[] items)

JList(Vector<?> items)

JList(ListModel lm)
```

JList генерирует событие ListSelectionEvent в тот момент, когда пользователь изменяет выбор пунктов.

В интерфейсе ListSelectionListener объявлен только один метод:

```java
void valueChanged(ListSelectionEvent le)
```

Класс ListSelectionEvent имеет ряд полезных методов, но обычно, достаточно обратится к методам вызвавшего это событие объекта JList.

По умолчанию JList позволяет выбрать несколько пунктов (MULTIPLE_INTERVAL_SELECTION). Это поведение можно изменить:

```java
void setSelectionMode(int mode)

// mode: SINGLE_SELECTION, SINGLE_INTERVAL_SELECTION, MULTIPLE_INTERVAL_SELECTION
```

Некоторые методы:

```java
int getSelectedIndex() // индекс первого выбранного или -1

int getSelectedIndices()

Object getSelectedValue()

Object[] getSelectedValues()

void setSelectedIndex(int idx) 

void setSelectedIndices(int[] idxs) 

void setSelectedValue(Object item, boolean scrollToItem)
```

Для установки пунктов списка нужно либо создать модель и работать с ней, либо воспользоваться методами:

```java
void setListData(Object[] items)

void setListData(Vector<?> items)
```

Самый простой способ создания модели списка - использование класса  DefaultListModel, который предоставляет методы для управления данными в списке, в том числе добавлять и удалять. После создания списка можно получить ссылку на модель методом:

```java
ListModel getModel()

// Exampl:
DefaultListModel lm = (DefqultListModel) myList.getModel();
```

Класс, управляющий воспроизведением списка, должен реализовывать интерфейс ListCellRenderer, в котором объявлен только один метод getListCellRendererComponent(). Чтобы задать средство воспроизведения ячеек, надо вызвать метод setCellRenderer() списка.

### JComboBox

Реализует раскрывающийся список.

Класс JComboBox использует модель ComboBoxModel. Этот интерфейс расширяет ListModel и объявляет дополнительные методы getSelectedItem() и setSelectedItem().

Если раскрывающийся список допускает изменение пункта, в нём используется интерфейс MutableComboBoxModel, расширяющий ComboBoxModel. Реализацией интерфейса MutableComboBoxModel по умолчанию является класс DefaultComboBoxModel, в котором содержатся методы, позволяющие добавлять и удалять пункты списка.

```java
JComboBox()

JComboBox(Object[] items)

JComboBox(Vector<?> items)

JComboBox(ComboBoxModel cbm)
```

JComboBox генерирует события действия (ActionEvent)  и событие элемента (ItemEvent)

Чтобы сформировать раскрывающийся список с возможностью редактирования, надо сначала создать экземпляр JComboBox, а затем вызвать метод:

```java
void setEditable(boolean canEdit)
```

Значение, вводимое в поле редактирования не включается в состав списка. Оно используется для навигации по списку.

Добавить пункты можно в модифицируемый список, в том числе поддерживающий модель DefaultComboBoxModel (по умолчанию) c помощью методов:

```java
void addItem(Object item)

void removeItem(Object item)

void removeItemAt(int idx)

void removeAllItems()
```

Некоторые меотоды:

```java
void setPopupVisible(boolean show) // раскрыть список

boolean isPopupVisible() // раскрыт ?

void setEnabled(boolean enable)

ComboBoxModel getModel()

void setModel(ComboBoxModel cbm)
```

### JSpinner

Инкрементный регулятор представляет собой список, снабжённый кнопками со стрелками.

```java
JSpinner() 

JSpinner(SpinnerModel spm)
```

JSpinner использует модель, основанную на интерфейсе SpinnerModel. В этом интерфейсе определены методы для получения значений предыдущего, текущего и следующего пункта, а также для установки текущего значения пункта.

```java
Object getNextValue()

Object getPreviousValue()

Object getValue()

void setValue(Object val)
```

Интерфейс SpinnerModel частично реализуется абстрактным классом AbstractSpinnerModel, который использован в качестве базового для следующих классов стандартных моделей:

```java
SpinnerDateModel // Управление списком дат

SpinnerListModel // Управление списком или массивом

SpinnerNumberModel // Управление списком чисел
```

Модель SpinnerListModel наиболее универсальна. Её конструкторы:

```java
SpinnerListModel()

SpinnerListModel(Object[] items)

SpinnerListModel(List<?> items)
```

Модель SpinnerNumberModel содержит свойства, определяющие минимальную и максимальную величину, шаг и само значение:

```java
SpinnerNumberModel()

SpinnerNumberModel(int val, int min, int max)

SpinnerNumberModel(double val, double min, double max, double stepSize)

SpinnerNumberModel(Number val, Comparable min, Comparable max, Number stepSize)
```

Модель SpinnerDateModel содержит свойства, определяющие начальную и конечную даты, а также свойство calendarField, которое задаёт правила изменения даты:

```java
SpinnerDateModel()

SpinnerDateModel(Date val, Comparable begin, Comparable end, int calField)

// calField: Calendar.AM_PM, Calendar.HOUR, Calendar.DAY_OF_WEEK_IN_MONTH,......
```

Компонент JSpinner генерирует событие изменения состояния (ChangeEvent)