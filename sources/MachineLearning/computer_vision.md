# Компьютерное зрение

> Изображения в цифровом виде представляются в виде матриц

>  Каждый пиксель матрицы цветного изображения содержит несколько значений

> Значения пикселя зависят от пространства цветов RGB, HSV, HSL

> Сжатие изображений может быть с потерями в качестве и без потерь

> В случае сжатия с потерями размер цветного изображения может уменьшиться в 10–20 раз

> Фильтрация изображений осуществляется с помощью свёрточной операции


## Цифровое представление изображений

1. Растр — описание изображения на уровне точек (пикселей), размер изображения ограничен  числом пикселей

2. Вектор — описание изображения на уровне фигур и их свойств, размер изображения может быть произвольным

### Растровое изображение

> Каждый пиксель изображения кодируется одним или несколькими значениями (каналами)

> Стандартный диапазон значений в каждом канале: 0...255 (один байт или 8 бит)

> Для представления чёрно-белого изображения достаточного одного канала (передача  яркости пикселя)

> Цветные изображения, как правило, содержат 3 канала

**RGB**

RGB — Red Green Blue:

наиболее распространённое представление цветного изображения выбор основных цветов  обусловлен восприятием цвета сетчаткой глаза

3 канала

**CMYK**

CMYK — Cyan Magenta Yellow Black:

4 канала

в основном используется в полиграфии

цветовой охват меньше, чем в RGB

**HSV**

HSV — Hue Saturation Value:

Hue — цветовой тон

Saturation — насыщенность цвета

Value — интенсивность

> Возможно преобразование RGB -> HSV

**HSL**

HSL — Hue Saturation Lightness:

Hue — цветовой тон

Saturation — насыщенность цвета

Lightness — яркость

> Возможно преобразование RGB -> HSL

### Сжатие

- С потерей качества (*.jpg)

- Без потери качества (*.png). Изображение анализируется и индексируется по уникальным цветам. 


### Фильтрация изображений

- **Свертка (convolution)** – это операция вычисления нового значения выбранного пикселя, учитывающая значения окружающих его пикселей. Для вычисления значения используется матрица, называемая ядром свертки. Обычно ядро свертки является квадратной матрицей n*n, где n — нечетное, однако ничто не мешает сделать матрицу прямоугольной. Во время вычисления нового значения выбранного пикселя ядро свертки как бы «прикладывается» своим центром (именно тут важна нечетность размера матрицы) к данному пикселю. Окружающие пиксели так же накрываются ядром. Далее высчитывается сумма, где слагаемыми являются произведения значений пикселей на значения ячейки ядра, накрывшей данный пиксель. Сумма делится на сумму всех элементов ядра свертки. Полученное значение как раз и является новым значением выбранного пикселя. Если применить свертку к каждому пикселю изображения, то в результате получится некий эффект, зависящий от выбранного ядра свертки.

Применение различных вариантов ядра свёртки определяет фильтры:

- Размытие (blur)

- Выделение границ (sharpen)

- Удаление шума (denoise)

**Фильтр Гаусса** усредняет значение пикселя и размывает изображение

**Оператор Лапласа** вычисляет производную и выделяет грани на изображении

**Медианный филтр** позволяет убрать шум на изображении

> Если фильтр обладает свойством сепарабельности, то время вычисления свёртки можно сократить с К*К до 2К (если ядро фильтра можно представить в виде разложения на  вертикальную и горизонтальную составляющие: K=vhT, то есть представить матрицу ядра свёртки в виде произведения вертикальной матрицы в один столбец на горизонтальную матрицу в ощну строку)

> Бинаризация изображений (преобразование в чёрно-белый) осуществляется сравнением значения в точке с заданным порогом

> Для бинаризованных изображений доступны морфологические преобразования и преобразование Distance Transform

## Анализ главных компонент в задачах CV

### PCA — principal components analysis

PCA (principal components analysis) — анализ главных компонент:

- изображение можно представить в виде вектора длины HxW

- большая размерность данных (число пикселей) затрудняет их обработку

- чтобы сократить размерность, применяется метод PCA

### Гистограммы цветов

- Не зависят от изменения масштаба изображения

- Устойчивы к повороту и перспективным искажениям

- В цветовых пространствах HSV и HSL менее чувствительны к изменению яркости

```
cv2.calcHist (images, channels, mask, histSize, ranges) → hist
```

- `images` — набор входных изображений для оценки гистограммы

- `channels` — каналы, по которым оцениваются гистограммы

- `mask` — маска, которая ограничивает область оценки гистограммы

- `histSize` — массив размеров гистограмм по каждому измерению

- `ranges` — диапазоны значений каждого измерения

### Гистограммы градиентов (HOG)

- Не чувствительны к изменению цвета

- Устойчивы к изменению яркости

- Устойчивы к изменению масштаба

1. В каждой точке оцениваем составляющие градиента по осям x и y

2. Определяем направление и длину вектора градиента

3. Оцениваем гистограмму градиентов

4. Полученные гистограммы нормализуют таким образом, чтобы вектор признаков был  единичной длины

- Как правило, гистограмму градиентов строят для диапазона углов 0...180

- При оценке гистограммы градиентов учитываются угол и длина вектора

- Чем больше длина вектора, тем больший вклад вносится в соответствующую ячейку  гистограммы

```
cv2.Sobel(src, ddepth, dx, dy[, dst[, ksize]]) → dst
```

- `src` — входное изображение

- `ddepth` — тип данных для вычисления производной, например, cv2.CV_64F

- `dx/dy` — порядок производной по осям, как правило, 0 или 1

- `dst`— выходное изображение

- `ksize` — размер ядра фильтра 1, 3, 5, или 7

```
cv2.cartToPolar(x, y) → magnitude, angle
```

- `x,y` — векторы с координатами x и y

- `magnitude` — длины векторов

- `angle` — соответствующие углы

### Характерные точки

- Точка, обладающая уникальными свойствами

- Положение точки на изображении однозначно определяется по её свойствам (дескриптору)

- Дескриптор точки вычисляется на основе её окружения

- Дескриптор характерной точки инвариантен к изменениям изображения (освещённость, поворот, масштабирование)

**Поиск характерной точки на изображении**

Как понять что выбранная область содержит характерную точку:

область вокруг характерной точки должна сильно варьироваться

в области характерной точки небольшой сдвиг изображения должен приводить к  существенному различию с исходным изображением

- Характерные точки выделяются большими значениями автокорреляционной матрицы

## Нейронные сети

- Нейронные сети — это обучаемые функции, причём они являются универсальными  аппроксиматорами (могут приблизить любую непрерывную функцию)

- Нейронные сети склонны к переобучению: чрезмерному подстраиванию под обучающую выборку

- Чтобы избежать переобучения, применяют техники dropout и batch normalization