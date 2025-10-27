## Адаптивный дизайн

### Метатег `viewport`

Вся видимая область на экране браузера описывается понятием **Viewport**. По сути `viewport` представляет область, в которую веб-браузер пытается "впихнуть" веб-страницу. 

Чтобы избежать неприятных ситуаций при просмотре страницы на устройствах с различными размерами экранов и использующих различные браузеры, следует использовать метатег `viewport`, имеющий следущее определение:

```html
<meta name="viewport" content="параметры_метатега">
```

В атрибуте content мета-тега мы можем определить следующие параметры:

|Параметр|Значения|Описание|
|-|-|-|
|width|Принимает целочисленное значение в пикселях или значение `device-width`|Устанавливает ширину области `viewport`|
|height|Принимает целочисленное значение в пикселях или значение `device-height`|Устанавливает высоту области viewport|
|initial-scale|Число с плавающей точкой от 0.1 и выше|Задает коэффициент масштабирования начального размера viewport. Значение 1.0 задает отсутствие масштабирования|
|user-scalable|no/yes|Указывает, может ли пользователь с помощью жестов масштабировать страницу|
|minimum-scale|Число с плавающей точкой от 0.1 и выше|Задает минимальный масштаб размера viewport. Значение 1.0 задает отсутствие масштабирования|
|maximum-scale|Число с плавающей точкой от 0.1 и выше|Задает максимальный масштаб размера viewport. Значение 1.0 задает отсутствие масштабирования|

Таким образом, чтобы веб-браузер в качестве начальной ширины экрана использовал ширину экрана устройства, достаточно в теле заголовка использовать тег:

```html
<meta name="viewport" content="width=device-width">
```

Мы также можем использовать другие параметры, например, запретить пользователю масштабировать размеры страницы:

```html
<meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1.0">
```

### Media Query в CSS3

Чтобы применить стиль только к мобильным устройствам мы можем написать так:

```html
<html>
 <head>
  <title>Адаптивная веб-страница</title>
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" type="text/css" href="desctop.css" />
  <link rel="stylesheet" type="text/css" media="(max-device-width:480px)" href="mobile.css" />
 </head>
 <body>
 ```

 С помощью директивый **`@import`** можно определить один css-файл и импортировать в него стили для определенных устройств:

```css
@import url(desctop.css);
@import url(tablet.css) (min-device-width:481px) and (max-device-width:768);
@import url(mobile.css) (max-device-width:480px);
```

Также можно не разделять стили по файлам, а использовать правила CSS3 Media Query в одном файле css:

```css
body {
    background-color: red;
}
/*Далее остальные стили*/
@media (max-device-width:480px){
    body {
        background-color: blue;
    }
    /*Далее остальные стили*/
}
```

Применяемые функции в CSS3 Media Query:
|функция|параметр|
|-|-|
|aspect-ratio|отношение ширины к высоте области отображения (браузера)|
|device-aspect-ratio|отношение ширины к высоте экрана устройства|
|max-width|максимальная ширина области отображения (браузера)|
|min-width|минимальная ширина|
|max-height|максимальная высота|
|min-height|минимальная высота|
|orientation|ориентация (portrait, landscape)|

Как правило, при определении стилей предпочтение отдается стилям для самых малых экранов - так называемый подход **Mobile First**, хотя это необязательно.

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>Адаптивная веб-страница</title>
         
        <style>
        body {
            background-color: red;
        }
        /* для планшетов и фаблетов */
        @media (min-width: 481px) and (max-width:768px) {
            body {
                background-color: green;
            }
        }
        /* для декстопов */
        @media (min-width:769px) {
            body {
                background-color: blue;
            }
        }
</style>
    </head>
    <body>
        <h2>Адаптивная веб-страница</h2>
    </body>
</html>
```
