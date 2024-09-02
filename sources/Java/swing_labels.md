# Метки.

Метки могут содержать текст или изображение, или и то и другое.

```java
JLabel(String str, Icon icon, int horAlign)
```

В последнем случае, картинка располагается на “ведущем крае”. Взаимное расположение изменяется методами:

```java
void setVerticalTextPosition(int loc)
void setHorizontalTextPosition(int loc)
```

Для вертикального или горизонтального позиционирования ис`пользуются константы:

```java
SwingConstants.Top
SwingConstans.Left
....
// или аналогичные
Jlabel.Top
Jlabel.left
....
```

Получить изображение проще всего используя класс ImageIcon, который реализует интерфейс Icon:

```java
ImageIcon(string filename)
// filename - изображение в поддерживаемом Java формате
// например png, gif, jpeg
```

Для того, чтобы отобразить мнемоническое обозначение в составе метки, нужно для метки вызвать метод:

```java
void setDisplayedMnemonic(int ch)
// ch - символ, выполняющий функции командной клавиши
// напр: 'e'. Будет подчёркнут первый 'e' в строке метки
```

После этого надо связать метку с компонентом, который будет получать фокус ввода при нажатии командной клавиши (в комбинации с <Alt>:

```java
void setLabelFor(Component comp)
// comp - ссылка на компонент
```

При необходимости, можно указать явным образом индекс символа:

```java
void setDisplayedMnemonicIndex(int idx) 
                   throws IllegalArgumentException
```

Для использования HTML-кода в метке(или в других компонентах), нужно, чтобы её текст начинался с <html>. Одним из преимуществ такого подхода является возможность создания многострочных меток:

```java
JLabel jlabel = new JLabel("<html>Top<br>Bottom");
```
