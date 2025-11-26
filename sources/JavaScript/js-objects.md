# Объекты в JavaScript

Объект может быть создан с помощью фигурных скобок `{…}` с необязательным списком свойств. Свойство – это пара «ключ: значение», где ключ – это строка (также называемая «именем свойства»), а значение может быть чем угодно.

```js
let user = new Object(); // синтаксис "конструктор объекта"
let user = {};  // синтаксис "литерал объекта"

```

## Свойства

### Флаги свойств

Свойство объекта может быть либо свойством-аксессором (с методами get/set), либо свойством-данным (со значением value).

Помимо значения `value`, свойства объекта имеют три специальных атрибута (так называемые «флаги»).

- `writable` – если `true`, свойство можно изменить, иначе оно только для чтения.

- `enumerable` – если `true`, свойство перечисляется в циклах, в противном случае циклы его игнорируют.

- `configurable` – если `true`, свойство можно удалить, а эти атрибуты можно изменять, иначе этого делать нельзя.

- `get` – функция без аргументов, которая сработает при чтении свойства,

- `set` – функция, принимающая один аргумент, вызываемая при присвоении свойства,

### `Object.getOwnPropertyDescriptor` 

позволяет получить полную информацию о свойстве.

```js
let descriptor = Object.getOwnPropertyDescriptor(obj, propertyName);
```

Пример:

```js
let user = {
  name: "John"
};

let descriptor = Object.getOwnPropertyDescriptor(user, 'name');

alert( JSON.stringify(descriptor, null, 2 ) );
/* дескриптор свойства:
{
  "value": "John",
  "writable": true,
  "enumerable": true,
  "configurable": true
}
*/
```

### `Object.defineProperty()` 

определяет новое или изменяет существующее свойство объекта и возвращает этот объект.

```js
Object.defineProperty(obj, prop, descriptor)
```

Пример:

```js
let user = {};

Object.defineProperty(user, "name", {
  value: "John",
  writable: true
});

let descriptor = Object.getOwnPropertyDescriptor(user, 'name');

alert( JSON.stringify(descriptor, null, 2 ) );
/*
{
  "value": "John",
  "writable": true,
  "enumerable": false,
  "configurable": false
}
```
> При попытке указать и `get/set`, и `value` в одном дескрипторе будет ошибка:
Пример:

```js
let user = {
  name: "John",
  surname: "Smith"
};

Object.defineProperty(user, 'fullName', {
  get() {
    return `${this.name} ${this.surname}`;
  },

  set(value) {
    [this.name, this.surname] = value.split(" ");
  }
});

alert(user.fullName); // John Smith

for(let key in user) alert(key); // name, surname
```

### Object.defineProperties

позволяет определять множество свойств сразу.

```js
Object.defineProperties(obj, {
  prop1: descriptor1,
  prop2: descriptor2
});
```


### Опциональная цепочка

Опциональная цепочка `?`. останавливает вычисление и возвращает `undefined`, 
если значение перед `?`. равно `undefined` или `null`.

Это помогает избегать ошибок при обращении к несуществующему свойоству объекта.

Вот безопасный способ получить доступ к user.address.street, используя ?.:

```js
let user = {}; // пользователь без адреса

alert( user?.address?.street ); // undefined (без ошибки)
```

## Прототипы, наследование

В JavaScript объекты имеют специальное скрытое свойство [[Prototype]] (так оно названо в спецификации), которое либо равно null, либо ссылается на другой объект. Этот объект называется «прототип».

Свойство [[Prototype]] является внутренним и скрытым, но есть много способов задать его.

Одним из них является использование __proto__, например так:


```js
let animal = {
  eats: true
};

let rabbit = {
  jumps: true
};

rabbit.__proto__ = animal; // (*)

// теперь мы можем найти оба свойства в rabbit:
alert( rabbit.eats ); // true (**)
alert( rabbit.jumps ); // true
```

Цепочка прототипов может быть длиннее:

```js
let animal = {
  eats: true,
  walk() {
    alert("Animal walk");
  }
};

let rabbit = {
  jumps: true,
  __proto__: animal
};

let longEar = {
  earLength: 10,
  __proto__: rabbit
};

// walk взят из цепочки прототипов
longEar.walk(); // Animal walk
alert(longEar.jumps); // true (из rabbit)

```

Свойство __proto__ немного устарело, оно существует по историческим причинам. Современный JavaScript предполагает, что мы должны использовать функции Object.getPrototypeOf/Object.setPrototypeOf вместо того, чтобы получать/устанавливать прототип.

- `Object.create(proto[, descriptors])` – создаёт пустой объект со свойством [[Prototype]], указанным как `proto`, и необязательными дескрипторами свойств `descriptors`. Формат дескрипторов такой-же как в `Object.defineProperties`

- `Object.getPrototypeOf(obj)` – возвращает свойство [[Prototype]] объекта obj.

- `Object.setPrototypeOf(obj, proto)` – устанавливает свойство [[Prototype]] объекта obj как proto.

Следующий вызов создаёт точную копию объекта `obj`, включая все свойства: перечисляемые и неперечисляемые, геттеры/сеттеры для свойств – и всё это с правильным свойством `[[Prototype]]`.

```js
let clone = Object.create(Object.getPrototypeOf(obj), Object.getOwnPropertyDescriptors(obj));
```

Ещё методы для работы с объектом:

|метод|назначение|
|-|-|
|Object.keys(obj) / Object.values(obj) / Object.entries(obj)|возвращают массив всех перечисляемых собственных строковых ключей/значений/пар ключ-значение.|
|Object.getOwnPropertySymbols(obj)|возвращает массив всех собственных символьных ключей.|
|Object.getOwnPropertyNames(obj)|возвращает массив всех собственных строковых ключей.|
|Reflect.ownKeys(obj)|возвращает массив всех собственных ключей.|
|obj.hasOwnProperty(key)|возвращает true, если у obj есть собственное (не унаследованное) свойство с именем key.|









## Примеси

 _**примесь**_ – это класс, методы которого предназначены для использования в других классах, причём без наследования от примеси.

Простейший способ реализовать примесь в JavaScript – это создать объект с полезными методами, которые затем могут быть легко добавлены в прототип любого класса:

```js
// примесь
let sayHiMixin = {
  sayHi() {
    alert(`Привет, ${this.name}`);
  },
  sayBye() {
    alert(`Пока, ${this.name}`);
  }
};

// использование:
class User {
  constructor(name) {
    this.name = name;
  }
}

// копируем методы
Object.assign(User.prototype, sayHiMixin);

// теперь User может сказать Привет
new User("Вася").sayHi(); // Привет, Вася!

```


### JSON

> JSON (JavaScript Object Notation) – это общий формат для представления значений и объектов.

JavaScript предоставляет методы:

- **`JSON.stringify`** для преобразования объектов (и примитивов) в JSON.

  ```js
  let json = JSON.stringify(value[, replacer, space])
  ```
  - `value` Значение для кодирования.

  - `replacer` Массив свойств для кодирования или функция соответствия `function(key, value)`.
  
  - `space` Дополнительное пространство (отступы), используемое для форматирования.

- **`JSON.parse`** для преобразования JSON обратно в объект.

  ```js
  let value = JSON.parse(str[, reviver]);
  ```

  - `str` JSON для преобразования в объект.

  - `reviver` Необязательная функция, которая будет вызываться для каждой пары (ключ, значение) и может преобразовывать значение.

```js
let student = {
  name: 'John',
  age: 30,
  isAdmin: false,
  courses: ['html', 'css', 'js'],
  wife: null
};

let json = JSON.stringify(student);

alert(typeof json); // мы получили строку!
// Полученная строка json называется JSON-форматированным или сериализованным объектом. 

alert(json);
```

Объект в формате JSON имеет несколько важных отличий от объектного литерала:

- Строки используют двойные кавычки. Никаких одинарных кавычек или обратных кавычек в JSON. Так 'John' становится "John".

- Имена свойств объекта также заключаются в двойные кавычки. Это обязательно. Так age:30 становится "age":30.

JSON является независимой от языка спецификацией для данных, поэтому JSON.stringify пропускает некоторые специфические свойства объектов JavaScript.

А именно:

- Свойства-функции (методы).

- Символьные ключи и значения.

- Свойства, содержащие `undefined`.