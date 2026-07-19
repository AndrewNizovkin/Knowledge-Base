# DOM (Document Object Model)

Все операции с DOM начинаются с объекта `document`. Это главная «точка входа» в DOM. Из него мы можем получить доступ к любому узлу.

Получив DOM-узел, мы можем перейти к его ближайшим соседям используя навигационные ссылки.

### Основные наборы ссылок

Есть два основных набора ссылок:

Для всех узлов: 

- `parentNode`

- `childNodes`

- `firstChild` 

- `lastChild`

- `previousSibling`

 - `nextSibling`

Только для узлов-элементов:

-  `parentElement`

-  `children`

- `firstElementChild`

- `lastElementChild`

- `previousElementSibling`

- `nextElementSibling`

Некоторые виды DOM-элементов, например таблицы, предоставляют дополнительные ссылки и коллекции для доступа к своему содержимому.

Коллекция `childNodes` содержит список всех детей, включая текстовые узлы и узлы-комментарии.

```html
<html>
<body>
  <div>Начало</div>

  <ul>
    <li>Информация</li>
  </ul>

  <div>Конец</div>

  <script>
    for (let i = 0; i < document.body.childNodes.length; i++) {
      alert( document.body.childNodes[i] ); // Text, DIV, Text, UL, ..., SCRIPT
    }
  </script>
  ...какой-то HTML-код...
</body>
</html>
```

Свойства `firstChild` и `lastChild` обеспечивают быстрый доступ к первому и последнему дочернему элементу.

```js
elem.childNodes[0] === elem.firstChild
elem.childNodes[elem.childNodes.length - 1] === elem.lastChild

```

Для проверки наличия дочерних узлов существует также специальная функция `elem.hasChildNodes()`

Для перебора коллекции `childNodes` мы можем использовать for..of:

```js
for (let node of document.body.childNodes) {
  alert(node); // покажет все узлы из коллекции
}
```

Методы массивов не будут работать с `childNodes`, но при необоходимости её можно в него преобразовать:

```js
alert( Array.from(document.body.childNodes).filter ); // сделали массив
```
## Поиск

Есть 6 основных методов поиска элементов в DOM:

- `querySelector`

- `querySelectorAll`

- `getElementById`

- `getElementsByName`

- `getElementsByTagName`

- `getElementsByClassName`


### getElement*

Если у элемента есть атрибут id, то мы можем получить его вызовом `document.getElementById(id)`, где бы он ни находился.

Метод `getElementById` можно вызвать только для объекта `document`. Он осуществляет поиск по id по всему документу.

```html
<div id="elem">
  <div id="elem-content">Element</div>
</div>

<script>
  // получить элемент
  let elem = document.getElementById('elem');

  // сделать его фон красным
  elem.style.background = 'red';
</script>
```

Также есть глобальная переменная с именем, указанным в id:

```html
<div id="elem">
  <div id="elem-content">Элемент</div>
</div>

<script>
  // elem - ссылка на элемент с id="elem"
  elem.style.background = 'red';

  // внутри id="elem-content" есть дефис, так что такой id не может служить именем переменной
  // ...но мы можем обратиться к нему через квадратные скобки: window['elem-content']
</script>
```
*В реальной жизни лучше использовать document.getElementById.*

### HTML-атрибуты

Когда у элемента есть `id` или другой стандартный атрибут, создаётся соответствующее свойство. Но этого не происходит, если атрибут нестандартный.

```html
<body id="test" something="non-standard">
  <script>
    alert(document.body.id); // test
    // нестандартный атрибут не преобразуется в свойство
    alert(document.body.something); // undefined
  </script>
</body>
```

Кроме того, все атрибуты доступны с помощью следующих методов:

- `elem.hasAttribute(name)` – проверяет наличие атрибута.

- `elem.getAttribute(name)` – получает значение атрибута.

- `elem.setAttribute(name, value)` – устанавливает значение атрибута.

- `elem.removeAttribute(name)` – удаляет атрибут.

Иногда нестандартные атрибуты используются для передачи пользовательских данных из HTML в JavaScript, или чтобы «помечать» HTML-элементы для JavaScript.

Чтобы избежать конфликтов, существуют атрибуты вида `data-*`.

Все атрибуты, начинающиеся с префикса «data-», зарезервированы для использования программистами. Они доступны в свойстве `dataset`.

```html
<body data-about="Elephants">
<script>
  alert(document.body.dataset.about); // Elephants
</script>
```
Атрибуты, состоящие из нескольких слов, к примеру `data-order-state`, становятся свойствами, записанными с помощью верблюжьей нотации: `dataset.orderState`.

### Поиск: querySelectorAll

Самый универсальный метод поиска – это `elem.querySelectorAll(css)`, он возвращает все элементы внутри elem, удовлетворяющие данному CSS-селектору.

Следующий запрос получает все элементы `<li>`, которые являются последними потомками в `<ul>`:

```html
<ul>
  <li>Этот</li>
  <li>тест</li>
</ul>
<ul>
  <li>полностью</li>
  <li>пройден</li>
</ul>
<script>
  let elements = document.querySelectorAll('ul > li:last-child');

  for (let elem of elements) {
    alert(elem.innerHTML); // "тест", "пройден"
  }
</script>
```

### Поиск: querySelector

Метод `elem.querySelector(css)` возвращает первый элемент, соответствующий данному CSS-селектору.

### matches

Метод elem.matches(css) ничего не ищет, а проверяет, удовлетворяет ли elem CSS-селектору, и возвращает true или false.

## Содержимое элемента

### innerHTML: содержимое элемента

войство innerHTML позволяет получить HTML-содержимое элемента в виде строки.

Мы также можем изменять его. Это один из самых мощных способов менять содержимое на странице.

```html
<body>
  <p>Параграф</p>
  <div>DIV</div>

  <script>
    alert( document.body.innerHTML ); // читаем текущее содержимое
    document.body.innerHTML = 'Новый BODY!'; // заменяем содержимое
  </script>

</body>
```

> Если innerHTML вставляет в документ тег `<script>` – он становится частью HTML, но не запускается.

### outerHTML: HTML элемента целиком

Свойство outerHTML содержит HTML элемента целиком. Это как innerHTML плюс сам элемент.

```html
<div id="elem">Привет <b>Мир</b></div>

<script>
  alert(elem.outerHTML); // <div id="elem">Привет <b>Мир</b></div>
</script>
```

> **ОСТОРОЖНО**: в отличие от innerHTML, запись в outerHTML не изменяет элемент. Вместо этого элемент заменяется целиком во внешнем контексте.
Мы можем писать в elem.outerHTML, но надо иметь в виду, что это не меняет элемент, в который мы пишем. Вместо этого создаётся новый HTML на его месте. Мы можем получить ссылки на новые элементы, обратившись к DOM.

### nodeValue/data: содержимое текстового узла

Свойство `innerHTML` есть только у узлов-элементов.

У других типов узлов, в частности, у текстовых, есть свои аналоги: свойства `nodeValue` и `data`. Эти свойства очень похожи при использовании, есть лишь небольшие различия в спецификации. 

```html
<body>
  Привет
  <!-- Комментарий -->
  <script>
    let text = document.body.firstChild;
    alert(text.data); // Привет

    let comment = text.nextSibling;
    alert(comment.data); // Комментарий
  </script>
</body>
```

### textContent: просто текст

Свойство textContent предоставляет доступ к тексту внутри элемента за вычетом всех <тегов>.

```html
<div id="news">
  <h1>Срочно в номер!</h1>
  <p>Марсиане атаковали человечество!</p>
</div>

<script>
  // Срочно в номер! Марсиане атаковали человечество!
  alert(news.textContent);
</script>
```

### Свойство «hidden»

```html
<div>Оба тега DIV внизу невидимы</div>

<div hidden>С атрибутом "hidden"</div>

<div id="elem">С назначенным JavaScript свойством "hidden"</div>

<script>
  elem.hidden = true;
</script>
```

Технически, hidden работает так же, как style="display:none". Но его применение проще.

Мигающий элемент:

```html
<div id="elem">Мигающий элемент</div>

<script>
  setInterval(() => elem.hidden = !elem.hidden, 1000);
</script>
```

## Атрибуты и свойства

У HTML-атрибутов есть следующие особенности:

- Их имена регистронезависимы (id то же самое, что и ID).

- Их значения всегда являются строками.

DOM-свойства, в отличие от HTML-атрибутов, не всегда являются строками. Они могут иметь логический тип или быть объектами


Когда браузер загружает страницу, он «читает» (также говорят: «парсит») HTML и генерирует из него DOM-объекты. Для узлов-элементов большинство стандартных HTML-атрибутов автоматически становятся свойствами DOM-объектов. 

Стандартные атрибуты описаны в спецификации для соответствующего класса элемента.

Для нестандартных, не описанных в спецификации, атрибутов не будет соответствующих DOM-свойств. Такие атрибуты доступны с помощью следующих методов:

```js
elem.hasAttribute(name) // проверяет наличие атрибута.

elem.getAttribute(name) // получает значение атрибута.

elem.setAttribute(name, value) // устанавливает значение атрибута.

elem.removeAttribute(name) // удаляет атрибут
```

**С пользовательскими атрибутами могут возникнуть проблемы.** 
Что если мы используем нестандартный атрибут для наших целей, а позже он появится в стандарте и будет выполнять какую-то функцию? Язык HTML живой, он растёт, появляется больше атрибутов, чтобы удовлетворить потребности разработчиков. В этом случае могут возникнуть неожиданные эффекты.

Чтобы избежать конфликтов, существуют атрибуты вида `data-*`.

Все атрибуты, начинающиеся с префикса «data-», зарезервированы для использования программистами. Они доступны в свойстве `dataset`.

Например, если у elem есть атрибут `"data-about"`, то обратиться к нему можно как `elem.dataset.about`.

```html
<body data-about="Elephants">
<script>
  alert(document.body.dataset.about); // Elephants
</script>
```

Атрибуты, состоящие из нескольких слов, к примеру `data-order-state`, становятся свойствами, записанными с помощью верблюжьей нотации: `dataset.orderState`.

**Использование `data-*` атрибутов – валидный, безопасный способ передачи пользовательских данных.**

## Изменение документа

Модификации DOM – это ключ к созданию «живых» страниц.

### Создание элемента

DOM-узел можно создать двумя методами:

```js
let div = document.createElement('div'); // Создаёт новый элемент с заданным тегом:

let textNode = document.createTextNode('А вот и я'); // Создаёт новый текстовый узел с заданным текстом:

```

### Методы вставки

```js
node.append(...nodes or strings) // добавляет узлы или строки в конец node,

node.prepend(...nodes or strings) // вставляет узлы или строки в начало node,

node.before(...nodes or strings) // вставляет узлы или строки до node,

node.after(...nodes or strings) // вставляет узлы или строки после node,

node.replaceWith(...nodes or strings) // заменяет node заданными узлами или строками.
```

Пример:

```html
<ol id="ol">
  <li>0</li>
  <li>1</li>
  <li>2</li>
</ol>

<script>
  ol.before('before'); // вставить строку "before" перед <ol>
  ol.after('after'); // вставить строку "after" после <ol>

  let liFirst = document.createElement('li');
  liFirst.innerHTML = 'prepend';
  ol.prepend(liFirst); // вставить liFirst в начало <ol>

  let liLast = document.createElement('li');
  liLast.innerHTML = 'append';
  ol.append(liLast); // вставить liLast в конец <ol>
</script>
```
Можно вставлять несколько узлов и текстовых фрагментов за один вызов.

```html
<div id="div"></div>
<script>
  div.before('<p>Привет</p>', document.createElement('hr'));
</script>
```

### insertAdjacentHTML/Text/Element

Если мы хотим вставить HTML именно «как html», со всеми тегами и прочим, как делает это elem.innerHTML, С этим может помочь другой, довольно универсальный метод: `elem.insertAdjacentHTML(where, html)`.

Первый параметр – это специальное слово, указывающее, куда по отношению к elem производить вставку. Значение должно быть одним из следующих:

`"beforebegin"` – вставить html непосредственно перед elem,

`"afterbegin"` – вставить html в начало elem,

`"beforeend"` – вставить html в конец elem,

`"afterend"` – вставить html непосредственно после elem.

Второй параметр – это HTML-строка, которая будет вставлена именно «как HTML».

### DocumentFragment

`DocumentFragment` является специальным DOM-узлом, который служит обёрткой для передачи списков узлов.

Мы можем добавить к нему другие узлы, но когда мы вставляем его куда-то, он «исчезает», вместо него вставляется его содержимое.

Например, `getListContent` ниже генерирует фрагмент с элементами `<li>`, которые позже вставляются в `<ul>`:

```html
<ul id="ul"></ul>

<script>
function getListContent() {
  let fragment = new DocumentFragment();

  for(let i=1; i<=3; i++) {
    let li = document.createElement('li');
    li.append(i);
    fragment.append(li);
  }

  return fragment;
}

ul.append(getListContent()); // (*)
</script>
```

`DocumentFragment` редко используется. Зачем добавлять элементы в специальный вид узла, если вместо этого мы можем вернуть массив узлов? Переписанный пример:

```html
<ul id="ul"></ul>

<script>
function getListContent() {
  let result = [];

  for(let i=1; i<=3; i++) {
    let li = document.createElement('li');
    li.append(i);
    result.push(li);
  }

  return result;
}

ul.append(...getListContent()); // append + оператор "..." = друзья!
</script>
```

## Позиционирование элемента  и его координаты

Любая точка на странице имеет координаты:

Относительно окна браузера – `elem.getBoundingClientRect()`.

Относительно документа – `elem.getBoundingClientRect()` плюс текущая прокрутка страницы.

Координаты в контексте окна подходят для использования с `position:fixed`, а координаты относительно документа – для использования с `position:absolute`.

Каждая из систем координат имеет свои преимущества и недостатки. Иногда будет лучше применить одну, а иногда – другую, как это и происходит с позиционированием в CSS, где мы выбираем между absolute и fixed.

### Размеры и прокрутка

У элементов есть следующие геометрические свойства (метрики):

- `offsetParent` – ближайший CSS-позиционированный родитель или ближайший td, th, table, body.

- `offsetLeft/offsetTop` – позиция в пикселях верхнего левого угла относительно offsetParent.

- `offsetWidth/offsetHeight` – «внешняя» ширина/высота элемента, включая рамки.

- `clientLeft/clientTop` – расстояние от верхнего левого внешнего угла до внутренного. Для операционных систем с ориентацией слева-направо эти свойства равны ширинам левой/верхней рамки. Если язык ОС таков, что ориентация справа налево, так что вертикальная полоса прокрутки находится не справа, а слева, то clientLeft включает в своё значение её ширину.

- `clientWidth/clientHeight` – ширина/высота содержимого вместе с внутренними отступами padding, но без полосы прокрутки.

- `scrollWidth/scrollHeight` – ширина/высота содержимого, аналогично clientWidth/Height, но учитывают прокрученную, невидимую область элемента.

- `scrollLeft/scrollTop` – ширина/высота прокрученной сверху части элемента, считается от верхнего левого угла.

> Все свойства доступны только для чтения, кроме scrollLeft/scrollTop, изменение которых заставляет браузер прокручивать элемент.

Размеры:

Ширина/высота видимой части документа (ширина/высота области содержимого): `document.documentElement.clientWidth/Height`

Ширина/высота всего документа со всей прокручиваемой областью страницы:

```js
let scrollHeight = Math.max(
  document.body.scrollHeight, document.documentElement.scrollHeight,
  document.body.offsetHeight, document.documentElement.offsetHeight,
  document.body.clientHeight, document.documentElement.clientHeight
);
```
Прокрутка:

Прокрутку окна можно получить так: `window.pageYOffset/pageXOffset`.

Изменить текущую прокрутку:

`window.scrollTo(pageX,pageY)` – абсолютные координаты,

`window.scrollBy(x,y)` – прокрутка относительно текущего места,

`elem.scrollIntoView(top)` – прокрутить страницу так, чтобы сделать elem видимым (выровнять относительно верхней/нижней части окна).
