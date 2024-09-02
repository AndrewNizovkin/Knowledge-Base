# Обрамление.

### Обрамление.

Каждое обрамление является экземпляром класса, реализующего интерфейс javax.swing.border.Border.

Как правило, для создания обрамления (Border) используются фабричные методы класса javax.swing.BorderFactory.

```java
// обрамление из обычных линий:
static Border createLineBorder(Color lineColor)
static Border createLineBorder(Color lineColor, int Width)

// рельефная рамка:
static Border createEtchedBorder()

// пустая рамка, формирующая зазор между компонентами:
static Border createEmptyBorder(int topWidth, int leftWidth,int bottomWidth, int rightWidth)

// Example:
jlabMyLabel.setBorder(BorderFactory.createEtchedBorder();

```