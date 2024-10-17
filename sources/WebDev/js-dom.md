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

