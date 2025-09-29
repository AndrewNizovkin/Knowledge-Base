# SCC Каскадные таблицы стилей

**Селектор** это конструкция, которая показывает к каким тегам будет применено **CSS правило**

```css
strong {
    color: red;
}
```

[Селекторы CSS](https://html5css.ru/cssref/css_selectors.php)

[Свойства CSS](https://html5css.ru/cssref/default.php)

---

Стили для элементов HTML-документа могут быть заданы различным способом:

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
  <link rel="stylesheet" type="text/css" href="styles.css">
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


Если некоторые свойства были определены для одного и того же селектора (элемента) в разных таблицах стилей, будет использовано значение из последней таблицы стилей чтения.

Свойства, определённые для родительского тега, наследуются потомками.

```css
/* выберет все теги p, которые расположены внутри div на первом уровне */
div > p {
    font-style: italic;
}

/* Выберет всех потомков div */
div p {
    font-style: italic;
}

```

### Свойства текста

|свойство|назначение|
|-|-|
|font-size|размер шрифта|
|font-weight|жирность начертания (число, кратное 100 от 100 до 900)|
|font-style|стиль начертания (italic, bold, normal, oblique)|
|color|цвет текста|
|font-family|гарнитура шрифта (serif, sans-serif, arial)|
|line-height|междустрочный интервал|
|text-decoration|подчёркнутый, надчёркнутый, перечёркнутый (underline, overline, line-throught)|
|text-transform|заглавные, строчные (uppercase, lowercase)|
|text-align|выравнивание текста (left, right, center, justify-по ширине)|

### Свойства списков

- list-style-type - тип маркера
    
    - неупорядоченные списки
    
        - disc
    
        - circle
    
        - square
    
    - нумерованные списки
    
        - decimal - арабские
    
        - lower-roman - стр. римские
    
        - upper-roman - загл. римские
    
        - lower-alpha - стр. латинские буквы
    
        - upper-alpha- загл. латинские буквы

- list-style-image - устанавливает любую картинку

    ```css
    list-style-image: url("images/image.png")
    ```

- list-stile-position - положение маркера списка

    - outside - положение снаружи (по умолчанию)
    - inside - внутри

### Цвет в CSS

Цвет можно задать следующими способами:

- в виде 16-ричного кода

    ```css
    color: #000000;
    color: #ffffff;
    color: #ff00ff;
    ```

- в rgb-формате, воспользовавшись функцией rgb(r, g, b)

    ```css
    color: rgb(0, 0, 0);
    ```
- в rgba-формате, задав прозрачность (0.0 - 1.0)

    ```css
    color: rgba(0, 0, 0, 0.5);
    color: rgba(255, 0, 255, 0.2);
    ```
### Свойства фоновых изображений

- backgraund-color - цвет фона

- background-image - фоновое изображение

    ```css
    background-image: url(images/image.jpg);
    ```

- backgraund-repeat - повторение изображения
    
    - no-repeat
    
    - repeat-x

    - repeat-y

- background-position - положение фонового изображения

    - top

    - bottom

    - left

    - right

    - center