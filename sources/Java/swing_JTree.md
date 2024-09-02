# Деревья

Компонент JTree даёт возможность организовать данные в виде дерева.

Дерево берёт начало в корневом узле, которому подчинены один или несколько дочерних узлов, которые делятся на два типа:

- *листья* (*терминальные узлы*) - не имеют дочерних узлов

- *узлы-ветви* - выступают в качестве корневых узлов для поддеревьев

*Путь* - это последовательность узлов, по которым можно перейти от корневого узла к конкретному узлу .

```java
JTree()

JTree(TreeNode tn)

JTree(TreeNode tn, boolean checkLeaf)

JTree(Object[] obj)

....

JTree(TreeModel tm)

// tn: корневой узел дерева
```

В интерфейсе TreeNode определены методы, инкапсулирующие информацию об узле дерева. Интерфейс MutableTreeNode расширяет TreeNode и допускает расширение, изменение и удаление дочерних узлов. Класс DefaultMutableTreeNode реализует его по умолчанию.

```java
DefaultMutableTreeNode(Object obj)
```

Для создания иерархической структуры дерева и соединения узлов служит метод:

```java
void add(MutableTreeNode child)
```

По умолчанию узлы дерева не допускают редактирования. Чтобы разрешить:

```java
void setEditable(boolean canEdit)
```

С каждым узлом дерева связаны:

- объект воспроизведения на основе класса, реализующего интерфейс TreeCellRenderer. По умолчанию это класс DefaultTreeCellRenderer

- редактор на основе класса. реализующего интерфейс TreeCellEditor. По умолчанию это класс DefaultTreeCellEditor.

Компонент JTree не поддерживает прокрутку и нуждается в помещении в JScrollpane.

JTree базируется на двух моделях:

- TreeModel - управляет отображением данных и по умолчанию реализуется классом DefaultTreeModel.

- TreeSelectionModel - определяет порядок выбора пунктов и по умолчанию реализуется классом DefaultSelectionModel. Поддерживаются три режима выбора, которые задаются константами, определёнными в этом интерфейсе:

    - CONTIGUOUS_TREE_SELECTION

    - DISCONTIGUOS_TREE_SELECTION (def)

    - SINGLE_TREE_SELECTION
    

JTree генерирует различные события, основные: 

**TreeSelectionEvent** 

Возникает при выборе или отмене узла.

Класс, реализующий интерфейс TreeSelectionListener нужно зарегистрировать в экземпляре JTree. В этом интерфейсе только один метод:

```java
void valueChanged(TreeSelectionEvent tse)
```

В классе TreeSelectionEvent определены методы:

```java
TreePath getPath()

Object[] getPath()

Object getLastPathComponent()

......
```

**TreeExpansionEvent**

Возникает при свёртывании или развёртывания дерева.

Класс, реализующий интерфейс TreeExpansionListener нужно зарегистрировать в экземпляре JTree. В этом интерфейсе два метода:

```java
void treeCollapsed(TreeExpansionEvent tee)

void treeExpanded(TreeExpansionEvent tee)
```

В классе TreeExpansionEvent определён один метод:

```java
TreePath getPath()

// TreePath содержит путь к узлу, вызвавшему событие
```

**TteeModelEvent**

Возникает при изменении данных или структуры дерева.https://www.notion.so/e144cd10763c4a2ab48b88a7086306d3?pvs=21

Класс, реализующий интерфейс TreeModelListener нужно зарегистрировать в модели дерева. В этом интерфейсе определены методы:

```java
void treeNodesChanged(TreeModelEvent tme)

void treeStructureChanged(TreeModelEvent tme)

void treeNodesInserted(TreeModelEvent tme)

void treeNodesRemoved(TreeModelEvent tme)
```

В классе TreeModelEvent определены методы:

```java
TreePath getTreePath() 

// возвращает путь к родительскому узлу, потомок которого претерпел изменения

.....
```

Дополнительные возможности:

```java
void setRootVisible(boolean visible)
// устанавливает видимым корневой узел (def: true)

```

В классе DefaultMutableTreeNode определены методы, позволяющие изменять содержимое узла, удалить, добавить узел, установить различные варианты обхода дерева.