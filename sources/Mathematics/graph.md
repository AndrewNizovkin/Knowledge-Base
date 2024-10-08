# Теория графов

**G = {V, E}**, где 

- V - вершины
- E - рёбра

`Инцидентность, смежность` - для вершин и рёбер

`Петля` - ребро, инцидентное одной вершине

`Псевдограф` - граф с петлями

`Кратные` или `параллельные рёбра` имеют одинаковые концевые вершины

`Мультиграф` - граф с кратными рёбрами

`Псевдомультиграф` - граф с петлями и кратными рёбрами

`Степень вершины` - количество рёбер ей инцидентных 

`Изолированная вершина` - вершина с нулевой степенью

`Висячая вершина` - вершина со степенью 1

`Полный граф` - граф, в котором каждые две вершины соединены одним ребром

`Регулярный граф` - граф, в котором степени всех вершин одинаковые

`Двудольный граф` - у которого все вершины можно разделить на два множества таким образом, что каждое ребро соединяет вершины из разных рёбер. Пример: клиент-серверное приложение

`Взвешенный граф` - граф, в котором у каждого ребра и(или) вершины есть вес

`Связный граф` - в котором существует путь между любыми двумя вершинами

`Дерево` - связный граф без циклов

`Ориентированный граф (Орграф)` - в котором рёбра имеют направления

`Путь(маршрут)` - последовательность смежных рёбер. Обычно задаётся перечислением вершин.

firstChild = index * 2

secondChild = index * 2 + 1

parent = index // 2