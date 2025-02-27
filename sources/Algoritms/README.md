# Алгоритмы

[Оценка сложности алгоритмов](algoritms2.md)

[Рекурсия](./recursion.md)

[Алгоритмы](algoritms1.md)

### Логарифм числа по основанию два (двоичный логарифм)


 это степень, в которую нужно возвести двойку, чтобы получить это число. 

Другими словами, сколько раз нужно делить число на два, чтобы получить единицу.

Ещё одна интерпретация: если из шариков, количеством равным `N` сложить пирамиду, каждый слой которой будет содержать на два шарика меньше предыдущего, а на вершине пирамиды будет только один, то количество слоёв пирамиды и будет двоичным логарифмом числа `N`.


`Динамическое программирование`

Используется для предпроцессинга данных.


### Range minimum requests

Задача поиска минимума в заданном в запросе диапазоне массива данных. Простой алгоритм перебора имеет `O(n)` асимптотику

Один из способов избежать алгоритмов с плохой асимптотикой может быть предварительная обработка данных и выделение памяти для сохранения результатов этой обработки. Обслуживание запросов при этом будет быстрым.

Например можно перебрать все возможные интервалы и сохранить результаты в памяти. При этом алгоритм предпроцессинга будет иметь `O(n^3)`, память `O(n^2)` 


`SQRT-декомпозиция`

 вид предпроцессинга данных, при котором набор данных разбивается на блоки количество которых равно количеству элементов в них и равно корень из `n`

### Жадность

Алгоритм, который использует решение задачи на части данных и при этом старые данные ему больше не нужны, а только новые, называется **жадным**.

Это работает не всегда. Для поиска самого встречающегося элемента.

### Двоичное дерево

Пирамида (куча) полное двоичное дерево, для которого соблюдается правило: значение в каждом родителе не больше чем у детей. Такая пирамида называется **пирамидой на минимум**. В корне такого дерева будет минимальное значение. Высота такого дерева будет логарифмичной.

Реализация пирамиды на массиве:

Определяем индексы для потомков i-го элемента: 

- Левый ребёнок: 2 X i + 1

- Правай ребёнок: 2 X i + 2

```java
public class heap{
    
    private final int[] data; // куча в виде массива

public heap(int[] data) {
    this.data = data;
}

public getRoot() {
    return data[0];
}

public getLeftIndex(int parentIndex) {
    return 2 * parentIndex + 1;
}

public getRightIndex(int parentIndex) {
    return 2 * parentIndex + 2;
}

}

```

Чтобы поместить элемент в кучу, реализованную в виде массива, нужно:

- поместить элемент в конец массива

- выполнить процедуру `всплывания`, сравнивая значение с родителем, и меняя их друг с другом, если родитель больше. Этот алгоритм имеет логарифмическую сложность, поскольку не больше высоты пирамиды.
 
 
Чтобы удалить минимум в пирамиде

- удаляем элемент из корня пирамиды

- заполняем корень последним элементом

- удаляем последний узел пирамиды

 `Просеивание` - это сравнение значение с значениями потомками и обмен с потомком, имеющим наименьшее значение из меньших.

 Оба алгоритма (всплывание и просеивание), после обмена зна используют рекурсию. В первом случае база рекурсии - если элемент в корне, во втором - если у элемента нет потомков

 Однопроходность - иногда важно

 ### Поиск `k` максимумов в массиве с `n` элементов.

 Наиболее эффективным будет алгоритм с дополнительным `деревом на минимум`, в котором в корне минимальное значение.

 Алгоритм является однопроходным. При проходе первых `k` элементов, заполняется дерево. Каждый следующий элемент сравнивается с корнем дерева и помещается в него, если он больше. После этого выполняется балансировка дерева (просеивание).

 ### Дерево поиска. Бинарное дерево.

 Каждое значение узла больше чем все значения слева и меньше чем все значения слева. 

Поиск в бинарном дереве:

 ```java

 Node findeNode(Int key, Node node) throws RuntimeException {
    if(key == node.key) {
        return node;
    } else {
        if(key < node.key) {
            if(node.leftChild.isEmpty) {
                throw new RuntimeException("Not found");
            } 
            return findeNode(key, node.leftChild);
        } else{
            if(node.rightChild.isEmpty) {
                throw new RuntimeException("Not found");
            }
            return findeNode(key, node.rightChild);
        }
    }

 }

 ```

 ### Красно-чёрные деревья

 Узлы этого типа бинарных деревьев имеют дополнительный атрибут "цвет", наличие которого позволяет алгоритму балансировки с помощью поворотов достигать логарифмической высоты дерева.

> Несбалансированное дерево с высотой `n` называется "бамбуком"

