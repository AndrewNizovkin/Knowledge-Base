# Поток обработки (диспетчеризации) событий.

Swing-программа запускается в *потоке обработки(диспетчеризации) событий* :

```java
public static void main(String args[]) {
    SwingUtilities.invokeLater(new Runnable() {
        public void run() {
            new SwingDemo();
            }
        });
}
```

Для обращения к элементам графического интерфейса из кода, выполняющегося не в потоке обработки событий, нужно этот код поместить в метод run() объекта Runnable и выполнить один из статических методов класса SwingUtilities:

```java
static void invokeLater(Runnable obj)
// сразу возвращает управление

static void invokeAndWait(Runnable obj)
    throws InterruptedException, InvocationException
// возвращает после выполнения метода obj.run() 
```