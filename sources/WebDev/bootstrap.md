# Bootstrap

### Базовая структура сетки Bootstrap-4

```html
<!-- Control the column width, and how they should appear on different devices -->
<div class="row">
  <div class="col-*-*"></div>
  <div class="col-*-*"></div>
</div>
<div class="row">
  <div class="col-*-*"></div>
  <div class="col-*-*"></div>
  <div class="col-*-*"></div>
</div>

<!-- Or let Bootstrap automatically handle the layout -->
<div class="row">
  <div class="col"></div>
  <div class="col"></div>
  <div class="col"></div>
</div>
```
Нужное количество столбцов определяется `.col-*-*`, где

- первая `*` предсталяет отзывчивость: `sm`, `md`, `lg`, `xl`

- вторая `*` представляет число, которое должно добавить до 12 для каждой строки.

Система Grid Bootstrap 4 имеет пять классов:

- `.col-` (дополнительные малые устройства-ширина экрана менее 576пкс)

- `.col-sm-` (малые устройства-ширина экрана равна или больше, чем 576пкс)

- `.col-md-` (средние устройства-ширина экрана, равная или превышающая 768px)

- `.col-lg-` (большие устройства-ширина экрана равна или больше, чем 992пкс)

- `.col-xl-` (XLarge устройства-ширина экрана, равная или превышающая 1200px)

Приведенные выше классы можно комбинировать для создания более динамичных и гибких макетов.

> Каждый класс масштабируется вверх, так что если нужно установить одинаковую ширину `sm` и `md`, вы только должны указать `sm`.

### [Полный список классов Bootstrap-4](https://html5css.ru/bootstrap4/bootstrap_ref_all_classes.php)
