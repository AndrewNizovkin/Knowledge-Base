# Рекурсия

### Умножение числа `a` на `b`

```java
public int recursiveMultiplication(int a, int b) {
    if(b == 1) {
        return a;
    } else {
        return a + recursiveMultiplication(a, b - 1);
    }
}

```

