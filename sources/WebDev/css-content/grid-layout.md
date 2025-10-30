## Grid Layout

Grid Layout  позиционирует элементы сразу в двух направлениях - в виде строк и столбцов, образуя тем самым таблицу.

> Cледует учитывать, что только относительно недавно производители браузеров стали внедрять поддержку этого модуля в свои браузеры. Кроме того, IE (начиная с версии 10) и Microsoft Edge имеет лишь частичную поддержку модуля. А Android Browser, Opera Mini, UC Browser вовсе ее не имеют.

### Создание grid-контейнера

Основой для определения компоновки **Grid Layout** является **grid container**, внутри которого размещаются элементы. Для создания grid-контейнера необходимо присвоить его стилевому свойству `display` одно из двух значений: `grid` или `inline-grid`.

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            .grid-container {
                border: solid 2px #000;
                display: grid;
            }
            .grid-item {
                text-align:center;
                font-size: 1.1em;
                padding: 1.5em;
                color: white;
            }
 
            .color1 {background-color: #675BA7;}
            .color2 {background-color: #9BC850;}
            .color3 {background-color: #A62E5C;}
            .color4 {background-color: #2A9FBC;}
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="grid-item color1">Grid Item 1</div>
            <div class="grid-item color2">Grid Item 2</div>
            <div class="grid-item color3">Grid Item 3</div>
            <div class="grid-item color4">Grid Item 4</div>
            <div class="grid-item color1">Grid Item 5</div>
        </div>
    </body>
</html>
```

Если значение `grid` определяет контейнер как блочный элемент, то значение `inline-grid` определяет элемент как строчный (`inline`).

В этом случае весь грид занимает только то пространство, которое необходимо для размещения его элементов.

Для управления стилизацией элементов grid-контейнера служат свойства:

|свойство|назначение|
|-|-|
|grid-template-columns|настраивает столбцы|
|grid-template-rows|настраивает строки|
|grid|объединяет два свойства: `grid: grid-template-rows / grid-template-columns;`|
|grid-column-gap|устанавливает отступы между столбцами|
|grid-row-gap|устанавливает отступы между строками|
|gap|устанавливает одинаковые отступы между строками и столбцами|
|grid-row-start|задает начальную горизонтальную grid-линию, с которой начинается элемент|
|grid-row-end|указывает, до какой горизонтальной grid-линии надо растягивать элемент|
|grid-row|определяет два свойства `grid-row: grid-row-start / grid-row-end;`|
|grid-column-start|задает начальную вертикальную grid-линию, от которой начинается элемент|
|grid-column-end|указывает, до какой вертикальной grid-линии нужно растягивать элемент|
|grid-column|определяет два свойства`grid-column: grid-column-start / grid-column-end;`|
|span|задаёт растяжение на несколько ячеек|
|grid-area| объединяет свойства `grid-area: row-start / column-start / row-end / column-end`|
|grid-auto-flow|задаёт направление элементов в контейнере|
|order|определяет порядок элементов в контейнере|
|grid-template-areas|определяет области грида|

### Строки и столбцы

Грид образует сетку из строк и столбцов, на пересечении которых образуются ячейки. 

В качестве значения свойству `grid-template-columns` передается ширина столбцов. Сколько мы хотим иметь в гриде столбцов, столько и нужно передать значений этому свойству.

```css
grid-template-columns: 8em 7em 8em;
```

Для настройки строк у грид-контейнера необходимо установить свойство `grid-template-rows`, которое задает количество и высоту строк:

```css
grid-template-rows: 4em 5em;
```

> Если элементов больше, чем ячеек грида, то образуются дополнительные строки (как в случае со столбцами). Высота дополнительной ячейки будет вычисляться автоматически.

### Функция `repeat`

```css
grid-template-columns: repeat(3, 8em);
grid-template-rows: repeat(4, 5em);
/* Первый параметр функции repeat представляет число повторений, а второй - определение строк или столбцов. */
```

Можно задавать повторение нескольких столбцов и строк:

```css
.grid-container {
    border: solid 2px #000;
    display: grid;
    grid-template-columns: repeat(2, 7em 8em);
    /* будет создано 4 столбца: два раза будут повторяться два столбца с шириной 7em и 8em. */
    grid-template-rows: 6em repeat(3, 5em);
    /* будет сздано 4 строки. Причем первая будет иметь высоту в 6em, а остальные три - 5em.*/
}
```

### Свойство `grid`

Объединяет два свойства и имеет следующий формат:

```css
grid: grid-template-rows / grid-template-columns;
```

Например так:

```css
grid: repeat(4, 5em) / repeat(3, 8em);
```

### Размеры строк и столбцов

- **Фиксированные размеры**

Задаются с помощью свойств `grid-template-columns` и `grid-template-rows`.

- **Автоматические размеры**

Задаются с помощью ключевого слова `auto`. В этом случае ширина столбцов и высота строк вычисляются исходя из размеров содержимого

```css
grid-template-columns: 8em auto auto;
grid-template-rows: auto 4.5em auto;
```

- **Пропорциональные размеры**

Для установки пропорциональных размеров применяется специальная единица измерения `fr`. Она представляет собой часть пространства (fraction), которое отводится для данного столбца или строки. Значение `fr` еще называют flex-фактором (flex factor).

Вычисление пропорциональных размеров производится по формуле:

```
flex-фактор * доступное_пространство  / сумма всех flex-факторов
```
При этом под доступным пространством понимается все пространство grid-контейнера за исключением фиксированных значений строк и столбцов.

```css
grid-template-columns: 8em 2fr 1fr;
grid-template-rows: 1fr 4.5em 1fr;
```

### Отступы между столбцами и строками

Для создания отступов между столбцами и строками применяются свойства `grid-column-gap` и `grid-row-gap` соответственно.

```css
grid-column-gap: 10px;
grid-row-gap: 10px;
```

Если значения свойств `grid-column-gap` и `grid-row-gap` совпадают, то вместо них можно определить одно свойство `gap` (ранее назвалось `grid-gap`), которое установит оба отступа:

```css
gap: 10px;
```

### Позиционирование элементов

Грид представляет собой набор ячеек, которые образуются на пересечении столбцов и строк. Но сами строки и столбцы образуются с помощью grid-линий, которые рассекают грид по вертикали и горизонтали:

![grid-lines](./images/grid-model.png)

По умолчанию каждый элемент в гриде позиционируется в одну ячейку по порядку. Для более точного расположения элемента предназначены свойства:

|свойство|назначение|
|-|-|
|grid-row-start|задает начальную горизонтальную grid-линию, с которой начинается элемент|
|grid-row-end|указывает, до какой горизонтальной grid-линии надо растягивать элемент|
|grid-row|определяет два свойства `grid-row: grid-row-start / grid-row-end;`|
|grid-column-start|задает начальную вертикальную grid-линию, от которой начинается элемент|
|grid-column-end|указывает, до какой вертикальной grid-линии нужно растягивать элемент|
|grid-column|определяет два свойства`grid-column: grid-column-start / grid-column-end;`|
|span|задаёт растяжение на несколько ячеек|
|grid-area| объединяет свойства `grid-area: row-start / column-start / row-end / column-end`|

Например, растянем элемент на несколько столбцов:

```css
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            .grid-container {
                border: solid 2px #000;
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                grid-template-rows: repeat(3, 5em);
            }
            .special-item{
                grid-column-start:2;
                grid-column-end: 5;
            }
            .grid-item {
                text-align:center;
                font-size: 1.1em;
                padding: 1.5em;
                color: white;
            }
            .color1 {background-color: #675BA7;}
            .color2 {background-color: #9BC850;}
            .color3 {background-color: #A62E5C;}
            .color4 {background-color: #2A9FBC;}
            .color5 {background-color: #4e342e;}
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="grid-item color1">Grid Item 1</div>
            <div class="grid-item color2 special-item">Grid Item 2</div>
            <div class="grid-item color3">Grid Item 3</div>
            <div class="grid-item color4">Grid Item 4</div>
            <div class="grid-item color5">Grid Item 5</div>
            <div class="grid-item color1">Grid Item 6</div>
            <div class="grid-item color4">Grid Item 7</div>
        </div>
    </body>
</html>
```

- **span**

С помощью специального слова span можно задать растяжение элемента на несколько ячеек. После слова span указывается, на какое количество ячеек надо растянуть элемент:

```css
.special-item{
    grid-row: 1 / span 2;
    grid-column: 2 / span 2;
}
```

Элемент помещается в ячейку, которая находится на пересечении первой строки и второго столбца, и растягивается на две строки вниз и на два столбца вправо.

- **Наложение элементов**

Манипулируя положением элементов, с помощью позиционирования и CSS-свойства `z-index` мы легко можем осуществить их наложение, создать своего рода слои из элементов.

- **Направление и порядок элементов**

### Свойство `grid-auto-flow`

По умолчанию все элементы располагаются по порядку горизонтально, если места в строке больше нет, то элементы переносятся на следующую строку, но это поведение можно переопределить:

|grid-auto-flow:|результат|
|-|-|
|row|значение по умолчанию, элементы располагаются в строку друг за другом, если места в строке не хватает, элементы переносятся на следующую строку|
|column|элементы располагаются в столбик, если места в столбце не хватает, то элементы переходят в следующий столбец|

### Свойство `order`

Позволяет задать порядок элементов. По умолчанию для каждого элемента в гриде это свойство имеет значение 0. Может иметь отрицательные и положительные целые значения

### Именованные grid-линии

При именовании линий их имена заключаются в квадратные скобки, а между для именами указывается ширина столбца или высота строки, которые находятся между этими линиями. Затем, используя эти названия, мы можем позиционировать элементы между определенными линиями:

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            *{
                box-sizing: border-box;
            }
            html, body{
                margin:0;
                padding:0;
            }
            .grid-container {
                height:100vh;
                display: grid;
                grid-template-columns: [col1start] 1fr [col1end] 10px 
                                        [col2start] 1fr [col2end] 10px
                                        [col3start] 1fr [col3end];
                grid-template-rows: [row1start] 1fr [row1end] 10px [row2start] 1fr [row2end];
            }
             
            .grid-item {
                background-color: #ddd;
            }
             
            .special-item{
                grid-column: col1start / col2end;
                grid-row: row1start;
                background-color: #bbb;
            }
            .item1{
                grid-column: col3start / col3end;
                grid-row: row1start;
            }
            .item2{
                grid-column: col1start / col1end;
                grid-row: row2start;
            }
            .item3{
                grid-column: col2start / col2end;
                grid-row: row2start;
            }
            .item4{
                grid-column: col3start / col3end;
                grid-row: row2start;
            }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="grid-item special-item"></div>
            <div class="grid-item item1"></div>
            <div class="grid-item item2"></div>
            <div class="grid-item item3"></div>
            <div class="grid-item item4"></div>
        </div>
    </body>
</html>
```

С помощью функции `repeat` мы можем растиражировать столбцы и строки, которые создаются между именованными grid-линиями:

```css
grid-template-columns: 10px repeat(3, [column] 1fr [colgutter] 10px);
grid-template-rows: 10px repeat(2, [row] 1fr [rowgutter] 10px);
```
Первый столбец будет иметь ширину в 10 пикселей. Затем происходит тиражирование столбцов с помощью функции `repeat`. Она создает подряд три копии двух столбцов. Первый столбец имеет ширину 1fr, то есть имеет пропорциональные размеры, и располагается между grid-линиями "`column`" и "`colgutter`". После grid-линии "`colgutter`" идет еще один столбец шириной в 10 пикселей. И эти два столбца будут повторяться три раза. То есть всего в гриде будет 7 столбцов.

Со строками будет во многом аналогично, только там создается 5 строк с помощью grid-линий "row" и "rowgutter".

При определении стиля элементов, используя имя grid-линий и их порядковый номер, мы можем явным образом указать с помощью свойств `grid-column` и `grid-row`, где именно должен располагаться элемент:

```css
.special-item{
    grid-column: column 2;  /* второй столбец с именем column */
    grid-row: row 1;        /* первая строка с именем row */
    background-color: #bbb;
}
```

И более того мы можем дополнительно добавлять новые именованные грид-линии вне функции `repeat`  и использовать номера grid-линий, как в данном случае происходит в отношении сайдбара:

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            *{
                box-sizing: border-box;
            }
            html, body{
                margin:0;
                padding:0;
            }
            .grid-container {
                height:100vh;
                display: grid;
                grid-template-columns: 10px repeat(3, [column] 1fr [colgutter] 10px) 
                                       [sidebarstart] 150px [sidebarend] 10px;
                grid-template-rows: 10px repeat(2, [row] 1fr [rowgutter] 10px);
            }
             
            .grid-item {
                background-color: #ddd;
            }
             
            .special-item{
                grid-column: column 2;
                grid-row: row 1;
                background-color: #bbb;
            }
            .item1{
                grid-column: column 1;
                grid-row: row 1;
            }
            .item2{
                grid-column: column 3;
                grid-row: row 1;
            }
            .item3{
                grid-column: column 1;
                grid-row: row 2;
            }
            .item4{
                grid-column: column 2;
                grid-row: row 2;
            }
            .sidebar{
                grid-column: sidebarstart / sidebarend;
                grid-row: 2 / 5;
                background-color: #ccc;
            }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="grid-item special-item"></div>
            <div class="grid-item item1"></div>
            <div class="grid-item item2"></div>
            <div class="grid-item item3"></div>
            <div class="grid-item item4"></div>
            <div class="grid-item sidebar"></div>
        </div>
    </body>
</html>
```

### Области грида. Свойство `grid-template-areas`

В рамках грида мы можем определять области (grid area). Области определятся с помощью двух вертикальных и двух горизонтальных grid-линий, которые собственно и задают занимаемое областью пространство. В этом плане область не эквивалентна одной ячейке грида и может включать несколько ячеек. Области особенно полезны для определения семантических отношений между различными частями макета страницы.

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            *{
                box-sizing: border-box;
            }
            html, body{
                margin:0;
                padding:0;
            }
            .grid-container {
                height:100vh;
                display: grid;
                /* устанавливает, как эти области будут располагаться в ячейках грида: */
                grid-template-areas: "header header"
                                     "sidebar content"
                                     "sidebar content";
                /* Здесь у grid-контейнера определяется два столбца и три строки: */
                grid-template-columns: 150px 1fr;
                grid-template-rows: 100px 1fr 100px;
            }
            /*Для установки области у элементов задается свойство grid-area: */
            .header { grid-area: header; background-color: #bbb; }
            .sidebar { grid-area: sidebar; background-color: #ccc; }
            .content { grid-area: content; background-color: #eee; }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="header"></div>
            <div class="sidebar"></div>
            <div class="content"></div>
        </div>
    </body>
</html>
```
В следующем примере в разметке используется символ точки "." Точка означает, что данная ячейка не будет принадлежать ни одной области и останется незаполненной. Если надо оставить 5 незаполненных ячеек, то указывается пять точек, между которыми ставятся пробелы. В итоге мы получим пять областей, между которыми будут располагаться незаполненные пространства:

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width" />
        <title>Grid Layout в CSS3</title>
        <style>
            *{
                box-sizing: border-box;
            }
            html, body{
                margin:0;
                padding:0;
            }
            .grid-container {
                height:100vh;
                display: grid;
                grid-template-areas: "header header header header header"
                                     ". . . . ."
                                     "menu . content . sidebar"
                                     ". . . . ."
                                     "footer footer footer footer footer";
                grid-template-columns: 130px 5px 1fr 5px 130px;
                grid-template-rows: 90px 5px 1fr 5px 90px;
            }
            .header { grid-area: header; background-color: #bbb; }
            .menu { grid-area: menu; background-color: #ccc; }
            .sidebar { grid-area: sidebar; background-color: #ccc; }
            .content { grid-area: content; background-color: #eee; }
            .footer { grid-area: footer; background-color: #bbb; }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <div class="header"></div>
            <div class="content"></div>
            <div class="menu"></div>
            <div class="sidebar"></div>
            <div class="footer"></div>
        </div>
    </body>
</html>
```