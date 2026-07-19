## Анимация

Анимация опирается на последовательню смену ключевых кадров (`keyframes`). Каждый ключевой кадр определяет один набор значений для анимируемых свойств. И последовательная смена таких ключевых кадров фактически будет представлять анимацию.

В целом объявление ключевого кадра в CSS3 имеет следующую форму:

```css
@keyframes название_анимации {
    from {
        /* начальные значения свойств CSS */
    }
    to {
        /* конечные значения свойств CSS */
    }
}
```

В случае использования множества промежуточных кадров, применяется следующая форма:

```css
@keyframes backgroundColorAnimation {
    from {
        background-color: red;
    }
    25%{
        background-color: yellow;
    }
    50%{
        background-color: green;
    }
    75%{
        background-color: blue;
    }
    to {
        background-color: violet;
    }
}
```
> Блоки `from` и `to` могут быть опущены.

Для привязки к элементу анимации, нужно в его стиле описать свойства:

```css
animation-name: название_анимации;
animation-duration: длительность_анимации;
```
При подобном определении анимация будет запускаться сразу после загрузки страницы. Однако можно также запускать анимацию по действию пользователя, например с помощью определения стиля для псевдокласса `:hover` и описания в нём вышеуказанных свойств.

Можно применять через запятую несколько анимаций, указав, через запятую для них `animation-duration`

### Завершение анимации

В общем случае после завершения временного интервала, указанного у свойства `animation-duration`, завершается и выполнение анимации. Однако с помощью дополнительных свойств мы можем переопределить это поведение.

- **`animation-iteration-count`** определяет, сколько раз будет повторяться анимация.:

```css
animation-iteration-count: 3;
```
Если необходимо, чтобы анимация запускалась бесконечное количество раз:

```css
animation-iteration-count: infinite;
```

- **`animation-direction: alternate`** определяет противоположное направление анимации при повторе.

- **`animation-fill-mode: forwards`** позволяет в качестве окончательного значения анимируемого свойства установить именно то, которое было в последнем кадре, тогда как по умолчанию, при окончании анимации браузер устанавливает для анимированного элемента стиль, который был бы до применения анимации.

- **`animation-delay`** определяет время задержки анимации

- **`animation-timing-function`** устанавливает функцию плавности

    |animation-timing-function:|результат|
    |-|-|
    |linear|линейная функция плавности, изменение свойства происходит равномерно по времени|
    |ease|функция плавности, при которой анимация ускоряется к середине и замедляется к концу, предоставляя более естественное изменение|
    |ease-in|функция плавности, при которой происходит только ускорение в начале|
    |ease-out|функция плавности, при которой происходит только ускорение в конце анимации|
    |ease-in-out|функция плавности, при которой анимация ускоряется к середине и замедляется к концу, предоставляя более естественное изменение|
    |cubic-bezier|для анимации применяется кубическая функция Безье|

- **`animation`** является сокращенным способом определения выше рассмотренных свойств:

    ```css
    animation: animation-name animation-duration animation-timing-function animation-iteration-count animation-direction animation-delay animation-fill-mode
    ```

## Создание баннера с анимацией

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML-баннер</title>
    <meta charset="utf-8" />
    <style type="text/css">
    @keyframes text1
    {
        10%{opacity: 1;}
        40%{opacity: 0;}
    }  
    @keyframes text2
    {
        30%{opacity: 0;}
        60%{opacity:1;}
    }
    @keyframes banner
    {
        10%{background-color: #008978;}
        40%{background-color: #34495e;}
        80%{background-color: green;}
    }
    .banner
    {
        width: 600px;
        height: 120px;
        background-color: #777;
        margin: 0 auto;
        position: relative;
    }
    .text1,.text2
    {
        position: absolute;
        width: 100%;
        height: 100%;
        line-height: 120px;
        text-align: center;
        font-size: 40px;
        color: #fff;
        opacity: 0;
    }
 
    .text1
    {
        animation : text1 6s infinite;
    }
 
    .text2
    {
        animation : text2 6s infinite;
    }
 
    .animated
    {
        opacity: 0.8;
        position: absolute;
        width: 100%;
        height: 100%;  
        background-color: #34495e;
        animation: banner 6s infinite;
    }
    </style>
</head>
<body>
    <div class="banner">
        <div class="animated">
            <div class="text1">Только в этом месяце</div>
            <div class="text2">Скидки по 20%</div>
        </div>
    </div>
</body>
</html>
```
> Здесь одновременно срабатывают три анимации. Анимация "banner" изменяет цвет фона баннера, а анимации text1 и text2 отображают и скрывают текст с помощью настроек прозрачности. Когда первый текст виден, второй не виден и наоборот. Тем самым мы получаем анимацию текста в баннере.
