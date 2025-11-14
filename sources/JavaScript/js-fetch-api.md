# Fetch

```js
let url = 'https://netologi-api-marvel.herokuapp';

fetch(url)
.then(response => response.json())
.then(json => console.log(json))
// Извлекает данные из URL-адреса, который возвращает данные в формате JSON, а затем выводит их в консоль
```

### Минимальный шаблон функции для работы с API

```js
async function fetchData() {
    try {
    const res = await fetch(‘jsfree-les-3-api.onrender.com...characters’);
    if (!res.ok) throw new Error(HTTP ${res.status});
    const data = await res.json();
    return data;
    } catch (error) {
    console.error(‘Ошибка при загрузке данных:’, error);
    }
}
```