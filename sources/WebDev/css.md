# SCC Каскадные таблицы стилей


[Селекторы CSS](https://html5css.ru/cssref/css_selectors.php)

[Свойства CSS](https://html5css.ru/cssref/default.php)

---

Стили для элементов HTML-документа могут быть заданы различным способом. Эти способы имеют следующую иерархию:

- <span style="color:yellow;"><b>Встроенные</b></span>. Для любого элемента в начальном теге:

```html
<p style="background-color:lightblue;color:white;text-align:center;">Hello World</p>

```

- <span style="color:yellow;"><b>Внутренние</b></span>. Для каждой страницы в разделе <head> в секции <style></style>

```html
<head>
    <style>
        p {
            background-color: lightblue;
            color: white;
            text-align: center;
        }
    </style>
</head>

```

- <span style="color:yellow;"><b>Внешние</b></span>. Стили описываются в файлах *.css, которые подключаются в теле заголовка в теге <link>

```html
<head>
  <link rel="stylesheet" href="styles.css">
</head>
```

CSS-файл это текстовый файл, в котором для каждого селектора определяется массив `свойство: значение`

```css
h1 {
    color: blue;
    font-family: verdana;
    font-size: 300%;
}
p  {
    color: red;
    font-family: courier;
    font-size: 160%;
}
```

---

