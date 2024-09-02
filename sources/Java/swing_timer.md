# Timer

Экземпляр класса Timer из пакета javax.swing генерирует событие ActionEvent через указанный интервал.

```java
Timer(int period, ActionListener ae)
```

Можно зарегистрировать другие обработчики:

```java
void addActionListener(ActionListener al)
```

Некоторые методы класса Timer:

```java
void start()

void stop()

void setRepeats(boolean repeats)
// reapeats: false - один раз
```

Обработка события, генерируемого объектом Timer, происходит в потоке обработки событий, что существенно упрощает код, избавляя от необходимости создания дополнительного потока и использования методов SwingUtilities.invokeLater() и SwingUtilities.invokeAndWait() при обращении к объектам Swing  графического интерфейса.