# Работа со стилями и классами CSS

Как правило, существует два способа задания стилей для элемента:

Создать класс в CSS и использовать его: `<div class="...">`

Писать стили непосредственно в атрибуте style: `<div style="...">`.

JavaScript может менять и классы, и свойство `style`.

Свойство `elem.style` – это объект, который соответствует тому, что написано в атрибуте `"style"`.

```js
background  => elem.style.background
top         => elem.style.top
opacity     => elem.style.opacity
```

Для свойств из нескольких слов используется camelCase:

```js
background-color  => elem.style.backgroundColor
z-index           => elem.style.zIndex
border-left-width => elem.style.borderLeftWidth
```

```js
// Пример. Использование свойства style

let top = /* сложные расчёты */;
let left = /* сложные расчёты */;

elem.style.left = left; // например, '123px', значение вычисляется во время работы скрипта
elem.style.top = top; // например, '456px'
```

```js
// Пример перезапись и добавление новых свойств через свойство cssText
let top = /* сложные расчёты */;
let left = /* сложные расчёты */;

// полная перезапись стилей elem, используем =
elem.style.cssText = `
  top: ${top};
  left: ${left};
`;

// добавление новых стилей к существующим стилям elem, используем +=
elem.style.cssText += `
  top: ${top};
  left: ${left};
`;

// если элементу уже заданы стили, которые мы хотим добавить (+=),
// они будут перезаписаны на новые.
```

### className и classList

Свойство "className": elem.className соответствует атрибуту "class".

```html
<body class="main page">
  <script>
    alert(document.body.className); // main page
  </script>
</body>
```
Если мы присваиваем что-то `elem.className`, то это заменяет всю строку с классами. Иногда это то, что нам нужно, но часто мы хотим добавить/удалить один класс.

Для этого есть другое свойство: `elem.classList`.

`elem.classList` – это специальный объект с методами для добавления/удаления одного класса.

```html
<body class="main page">
  <script>
    // добавление класса
    document.body.classList.add('article');

    alert(document.body.className); // main page article
  </script>
</body>
```

Методы classList:

- `elem.classList.add/remove("class")` – добавить/удалить класс.

- `elem.classList.toggle("class")` – добавить класс, если его нет, иначе удалить.

- `elem.classList.contains("class")` – проверка наличия класса, возвращает true/false.

Кроме того, `classList` является перебираемым, поэтому можно перечислить все классы при помощи `for..of`:

```html
<body class="main page">
  <script>
    for (let name of document.body.classList) {
      alert(name); // main, затем page
    }
  </script>
</body>
```