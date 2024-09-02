# Таблицы

Компонент JTable позволяет отображать данные в виде двумерной таблицы и управлять ими.

```java
JTable()

JTable(Object[][] data, Object[] headerNames)

JTable(TableModel tm)

JTable(int rows, int cols)

JTable(TableModel tm, TableColumnModel tcm)

JTable(TableModel tm, TableColumnModel tcm, ListSelectionModel lsm)
```

Не поддерживает прокрутку. При включении в JScrollPane заголовки столбцов автоматически отображаются на экране, в противном случае об этом нужно позаботиться вручную.

Поместив таблицу в JScrollPane, желательно установить предпочтительный размер *прокручиваемой области просмотра* таблицы:

```java
void setPreferredScrollableViewportSize(Demension dim)
```

Компонент JTable базируется на трёх моделях;

1. TableModel управляет отображением данных в виде двумерной структуры

2. TableColumnModel  - модель столбца

3. ListSelectionModel определяет порядок выбора пунктов.

По умолчанию, JTable позволяет выделять одну или несколько строк таблицы. Можно изменить поведение, позволив выделять столбцы или отдельные ячейки. 

Для выбора столбцов выполняется в два этапа:

```java
void setColumnSelectionAllowed(boolean enabled) // разрешить выбор столбцов

void setRowSelectionAllowed(boolean enabled) // запретить выбор строк.
```

Разрешить выбор ячеек можно двумя способами:

- разрешить выбор и столбцов и строк
- вызов метода setCellSelectionEnabled()

```java
void setCellSelectionEnabled(boolean enabled)
```

Можно предоставить возможность выделять по одному объекту:

```java
void setSelectionMode(int mode)

// mode: SINGLE_SELECTION, SINGLE_INTERVAL_SELECTION, MULTIPLE_INTERVAL_SELECTION(def)
```

При выборе строки, столбца или ячейки таблицы возникает событие ListSelectionEvent.

При изменении данных возникает событие TableModelEvent.

При изменении модели столбца возникает событие TableColumnEvent.

Для поддержки событий, связанных с выбором строк, нужно зарегистрировать ListSelectionListener в модели выбора таблицы, которую можно получить:

```java
ListSelectionModel getSelectionModel()
```

Для поддержки событий выбора столбцов. нужно зарегистрировать ListSelectionListener в модели выбора, получаемой из модели столбца:

```java
TableColumnModel tcm = jtable.getColumnModel();

ListSelectionModel lsmCol = tcm.getSelectionModel();
```

Для поддержки событий выбора ячеек, нужно зарегистрировать как обработчик выбора строк, так и обработчик выбора столбцов.

Для определения выбранных строк или столбцов нужно использовать методы класса JTable:

```java
int getSelectedRow()

int[] getSelectedRows()

int getSelectedColumn()

int[] getSelectedColumns()
```

Чтобы отслеживать изменения данных таблицы (редактирование данных, заголовков, включении или удалении столбцов). нужно зарегистрировать TableModelListener в модели таблицы. Для получения модели служит метод:

```java
TableModel getModel()
```

В TableModelListener для регистрации слушателя служит метод:

```java
void addTableModelListener(TableModelListener tml)
```

В интерфейсе TableModelListener только один метод:

```java
void tableChanged(TableModelEvent tme)
```

Класс TableModelEvent предоставляет методы:

```java
int getColumn() // индекс столбца, поддерживаемый моделью, а не представлением

int getFirstRow()

int getLastRow()

int getType() // TableModelEvent.DELETE, TableModelEvent.INSERT, TableModelEvent.UPDATE

```

По умолчанию, при изменении размера столбца, размеры остальных столбцов изменяются таким образом, чтобы размер таблицы оставался неизменным. Это поведение можно изменить, используя метод:

```java
void setAutoResizeMode(int how)

// how: JTable.AUTO_RESIZE_ALL_COLLUMNS, JTable.AUTO_RESIZE_LAST_COLUMN, 
// JTable.AUTO_RESIZE_NEXT_COLUMN, JTable.AUTO_RESIZE_OFF
```

Можно установить размер столбца из программы. Для этого нужно получить ссылку на модель столбцов таблицы методом getColumnModel(), и из неё извлечь ссылку на требуемый столбец:

```java
TableColumn getColumn(int idx)
```

TableColumn предоставляет методы для получения и установки значения ширины столбца:

```java
void setPreferredWidth(int w)

void setMinWidth(int w)

void setMaxWidth(int w)

int getWidth()
```

Модель таблицы, определяемая пользователем.

Проще всего создать пользовательскую модель, создав класс, наследующий класс AbstractTableModel, который реализует интерфейс TableModel . В классе AbstractTableModel реализованы все методы за исключением getValueAt(), getRowCount() и getColumnCount() и если нужно использовать имена столбцов, отличные от принятых по умолчанию (A-Z), нужно также переопределить метод getColumnName().

Чтобы установить объект воспроизведения, определяющий как данные, содержащиеся в таблице будут отображаться на экране, нужно вызвать метод:

```java
public void setDefaultRenderer(Class<?> columnClass,
                               TableCellRenderer renderer)
```

Можно определить собственный редактор ячеек (компонент, активизирующийся когда пользователь редактирует ячейку):

```java
public void setDefaultEditor(Class<?> columnClass,
                             TableCellEditor editor)
```

zsdfgasdf