# Fetch

```js
let promise = fetch(url, [options])
```
- `url` – URL для отправки запроса.

- `options` – дополнительные параметры: метод, заголовки и так далее.

Без `options` это простой GET-запрос, скачивающий содержимое по адресу `url`.

Браузер сразу же начинает запрос и возвращает промис, который внешний код использует для получения результата.

Процесс получения ответа обычно происходит в два этапа.

**Во-первых**, promise выполняется с объектом встроенного класса `Response` в качестве результата, как только сервер пришлёт заголовки ответа.

На этом этапе мы можем проверить статус HTTP-запроса и определить, выполнился ли он успешно, а также посмотреть заголовки, но пока без тела ответа.

Промис завершается с ошибкой, если `fetch` не смог выполнить HTTP-запрос, например при ошибке сети или если нет такого сайта. HTTP-статусы 404 и 500 не являются ошибкой.

Мы можем увидеть HTTP-статус в свойствах ответа:

- `status` – код статуса HTTP-запроса, например 200.

- `ok` – логическое значение: будет true, если код HTTP-статуса в диапазоне 200-299.

```js
let response = await fetch(url);

if (response.ok) { // если HTTP-статус в диапазоне 200-299
  // получаем тело ответа (см. про этот метод ниже)
  let json = await response.json();
} else {
  alert("Ошибка HTTP: " + response.status);
}
```

**Во-вторых**, для получения тела ответа нам нужно использовать дополнительный вызов метода.

`Response` предоставляет несколько методов, основанных на промисах, для доступа к телу ответа в различных форматах:

|метод|назначение|
|-|-|
|response.text()|читает ответ и возвращает как обычный текст|
|response.json()|декодирует ответ в формате JSON|
|response.formData()|возвращает ответ как объект `FormData`|
|response.blob()|возвращает объект как `Blob` (бинарные данные с типом)|
|response.arrayBuffer()|возвращает ответ как `ArrayBuffer` (низкоуровневое представление бинарных данных)|
|response.body|это объект `ReadableStream`, с помощью которого можно считывать тело запроса по частям|

Например, получим JSON-объект с последними коммитами из репозитория на GitHub:

```js
let url = 'https://api.github.com/repos/javascript-tutorial/en.javascript.info/commits';
let response = await fetch(url);

let commits = await response.json(); // читаем ответ в формате JSON

alert(commits[0].author.login);
```

То же самое без `await`, с использованием промисов:

```js
fetch('https://api.github.com/repos/javascript-tutorial/en.javascript.info/commits')
  .then(response => response.json())
  .then(commits => alert(commits[0].author.login));
```

> Мы можем выбрать только один метод чтения ответа.Если мы уже получили ответ с `response.text()`, тогда `response.json()` не сработает, так как данные уже были обработаны.

### Заголовки запроса

Для установки заголовка запроса в `fetch` мы можем использовать опцию `headers`. Она содержит объект с исходящими заголовками, например:

```js
let response = fetch(protectedUrl, {
  headers: {
    Authentication: 'secret'
  }
});
```

### POST-запросы

Для отправки POST-запроса или запроса с другим методом, нам необходимо использовать `fetch` параметры:

- `method` – HTTP метод, например POST

- `body` – тело запроса, одно из списка:

    - строка (например, в формате JSON)

    - объект `FormData` для отправки данных как `form/multipart`

    - `Blob/BufferSource` для отправки бинарных данных

    - `URLSearchParams` для отправки данных в кодировке `x-www-form-urlencoded`

Чаще всего используется JSON.

Например, этот код отправляет объект user как JSON:

```js
let user = {
  name: 'John',
  surname: 'Smith'
};

let response = await fetch('/article/fetch/post/user', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json;charset=utf-8'
  },
  body: JSON.stringify(user)
});

let result = await response.json();
alert(result.message);
```
Заметим, что так как тело запроса `body` – строка, то заголовок `Content-Type` по умолчанию будет `text/plain;charset=UTF-8`.

Но, так как мы посылаем JSON, то используем параметр `headers` для отправки вместо этого `application/json`, правильный Content-Type для JSON.
