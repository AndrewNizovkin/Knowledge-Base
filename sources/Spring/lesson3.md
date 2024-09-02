[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5643784/attachment/3e424d1c82e527dbbebf91a5fda8d2c4.pdf)

## Rest API

или представительное состояние передачи, – это архитектурный стиль, используемый для обмена данными в вебе. Он базируется на принципах HTTP и поощряет разработчиков создавать простые, без состояний и предсказуемые веб-сервисы.

REST прост и понятен. Он использует стандартные HTTP-методы, такие как GET,
POST, PUT и DELETE, чтобы представить операции, которые вы можете выполнять с
ресурсами. Это делает его очень интуитивным и простым в использовании, как для
разработчиков, так и для клиентов.


```java
@RequestMapping(value = "/items", method = RequestMethod.GET)
public ResponseEntity<List<Item>> getItems(
@RequestParam(value = "page", defaultValue = "1") int page,
@RequestParam(value = "size", defaultValue = "10") int size) {
  List<Item> items = getItemsFromDatabase(page, size); // это просто пример
  return new ResponseEntity<>(items, HttpStatus.OK);
}
```

```java
@Controller
@RequestMapping("/api")
public class MyController {

// другие обработчики здесь

@ExceptionHandler(ItemNotFoundException.class)
public ResponseEntity<String>
handleItemNotFoundException(ItemNotFoundException ex) {

 return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND);
 
}
}
```
