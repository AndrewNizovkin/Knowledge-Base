# Семинар 4. Thymeleaf

`xmlns:th="www.thymeleaf.org"` - задаёт пространство имён и позволяет использовать синтаксис th=  

### Пример 1. передача атрибутом в html переменной `name`

```html
  <!-- home-file.html -->  
                                 
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>home page</title>
</head>
<body>
    <h1>Hello, <span th:text="${name}"></span>!</h1>
</body>
</html>
```

```java
@GetMapping("home")
    public String home(@RequestParam(required = false) String name, Model model){
        if (name != null) {
            model.addAttribute("name", name);
        } else {
            model.addAttribute("name", "world");
        }
        return "home-file";
    }
```

или так:

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/ea81ed0a-2b39-4208-a877-05df4447555f/e11316ad-2ce3-4210-a770-1cb932af7551/Untitled.png)

### Пример 2. Список `list`

```html
<!-- list-file.html-->

<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>list page</title>
</head>
<body>
    <ul>
        <li>1</li>
        <li>2</li>
        <li>3</li>
        <li>4</li>
        <li>5</li>
    </ul>

    <ul>
        <li th:each="item: ${list}" th:text="${item}"></li>
    </ul>
</body>
</html>

```

```java
@GetMapping("list/{count}")
    public String list(Model model, @PathVariable int count){
        List<String> list = new ArrayList<>(count);
        for (int i = 0; i < count; i++) {
            list.add("item #" + i);
        }
        model.addAttribute("list", list);
        return "list-file";
    }
```

### Пример 3. Таблица `table`

```html
  <!-- table-file.html -->
  
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>table page</title>
</head>
<body>
    <table>
        <tr>
            <th>First name</th>
            <th>Second name</th>
            <th>Age</th>
        </tr>
        <tr th:each="person: ${table}">
            <td th:text="${person.getFirstName()}"></td>
            <td th:text="${person.getLastName()}"></td>
            <td th:text="${person.getAge()}"></td>
        </tr>
    </table>
</body>
</html>

```

```java
    @GetMapping("table")
    public String table(Model model){
        List<Person> list = new ArrayList<>();
        list.add(new Person("Кирилл", "Иванов", 10));
        list.add(new Person("Семен", "Смирнов", 11));
        list.add(new Person("Павел", "Петечкин", 12));
        model.addAttribute("table", list);
        return "table-file";
    }
```

### [Как отправить данные через POST thymeleaf form без формы ввода данных](https://ru.stackoverflow.com/questions/1487559/%D0%9A%D0%B0%D0%BA-%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D1%8C-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-post-thymeleaf-form-%D0%B1%D0%B5%D0%B7-%D1%84%D0%BE%D1%80%D0%BC%D1%8B-%D0%B2%D0%B2%D0%BE%D0%B4%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85)

```html
<!-- form-file.html -->

<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>table page</title>
</head>
<body>

    <table class="table table-sm table-hover align-middle">
    <thead>
    <tr>
        <th scope="col">сумма(руб.)</th>
        <th scope="col">Проценты(%)</th>
        <th scope="col">Срок(лет)</th>
    </tr>
    </thead>
    <tbody>
    <th:block th:each="viewOffer : ${offers}">
        <form action="#" th:action="@{/service/offerDetails}" th:object="${viewOffer}" method="post">
        <tr>
            <td  th:text="${viewOffer.sum}">сумма</td>
            <td th:text="${viewOffer.percentage}">процент</td>
            <td  th:text="${viewOffer.term}">срок</td>
            <td>
                <div class="d-grid gap-2 d-md-block">
                        <input name="sum" id="sum" th:value="${viewOffer.sum}" type="hidden"/>
                        <input name="percentage" id="percentage" th:value="${viewOffer.percentage}" type="hidden"/>
                        <input name="term" id="term" th:value="${viewOffer.term}" type="hidden"/>
                        <button type="submit" value="Подробнее">Подробнее</button>
                </div>
            </td>
        </tr>
        </form>
    </th:block>
    </tbody>

</body>
</html>

```
В модель добавляем геттеры и сеттеры

```java
@Data
@NoArgsConstructor
public class ViewOffer {
    public int sum;
    public double percentage;
    public int term;
}
```

Метод контроллера:

```java
@PostMapping(value = "/offerDetails")
public String issueCredit(@ModelAttribute ViewOffer viewOffer, Model model) {
    // бизнес-логика
    return "form-file"
}

```


### Использование переменной, объявленной в файле настроек

```bash
# ./resources/application.properties

spring.application.name=spring-boot-lesson-4
server.error.include-message=ALWAYS
application.max-count-book=5
```

```java
import org.springframework.beans.factory.annotation.Value;

@Service
public class MyService {
    @Value("${application.max-count-book:1}") // значение по умолчанию 1
    private int value;
}
```