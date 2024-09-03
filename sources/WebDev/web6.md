# React

Самый простой вариант использования react на сайте - вставка следующих ссылок в заголовок (<head>…</head>) файла index.html:

[Ссылки на CDN для вставки react  в тело сайта](https://ru.legacy.reactjs.org/docs/cdn-links.html)

[Ссылка для использования babel](https://babeljs.io/docs/babel-standalone)

В тег `<script>` нужно включить параметр: 

`<script type="text/babel">`

Например:

`<script src=”js/index.js” type="text/babel"></script>` - строка перед `</body>`

В файле index.html внутри `<body>`:

`<div id=”app”></div>`

В файле index.js обращаемся методу render объекта ReactDOM:

```jsx
ReactDOM.render(<h1>Hello</h1>, document.getElementById(”app”))
```

или

```jsx
ReactDOM.render(

<div>

	<h1>Hello,</h1>

	<h1>World!</h1>

</div>

, document.getElementById(”app”))
```

---

Объектная модель документа (Document Object Model, DOM) — это интерфейс, который рассматривает HTML- или XML-документы в виде древовидных структур, каждый узел которых является объектом документа. DOM, кроме того, предоставляет набор методов для выполнения запросов к дереву документа, для изменения его структуры и для выполнения с ним некоторых других действий.

---

Если рассматривать ситуацию в общих чертах, то оказывается, что DOM-документ включает в себя иерархию узлов. У каждого узла может быть родитель и (или) потомок.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <!-- Page Body -->
    <h2><font color="#3AC1EF">My Page</font></h2>
    <p id="content">Thank you for visiting my web page!</p>
  </body>
</html>
```

### Т**ипы узлов**

Как различать узлы разных типов? Ответ кроется в интерфейсе DOM, который носит имя

[Node](https://developer.mozilla.org/en-US/docs/Web/API/Node)

. В частности — речь идёт о свойстве

```
Node.nodeType
```

Это свойство может иметь одно из следующих значений, представляющих тип узла:

- Node.ELEMENT_NODE
- Node.ATTRIBUTE_NODE
- Node.TEXT_NODE
- Node.CDATA_SECTION_NODE
- Node.PROCESSING_INSTRUCTION_NODE
- Node.COMMENT_NODE
- Node.DOCUMENT_NODE
- Node.DOCUMENT_TYPE_NODE
- Node.DOCUMENT_FRAGMENT_NODE
- Node.NOTATION_NODE

---

### Node

(или более формально Node.js) - **кроссплатформенная среда исполнения с открытым исходным кодом**, которая позволяет разработчикам создавать всевозможные серверные инструменты и приложения используя язык JavaScript. Среда исполнения предназначена для использования вне контекста браузера (т.е. выполняется непосредственно на компьютере или на серверной ОС).

После установки node, проверяем версию:

```bash
node --version
```

Другой (более профессиональный) вариант использования React это установка с помощью пакетного менеджера npm:

```bash
npm i react
npm i react-dom
```

В результате в папке проекта появятся два файла 

- package-lock.json

- package.json

и папка:

- node_modules

Теперь в проекте установлен react и react-dom

---

### Простой компонент

React-компоненты реализуют метод `render()`, который принимает входные данные и возвращает что-то для вывода. В этом примере используется XML-подобный синтаксис под названием JSX. Входные данные, передаваемые в компонент, доступны в `render()` через `this.props`.

**JSX необязателен для работы с React.** Попробуйте [Babel REPL](https://babeljs.io/repl/#?presets=react&code_lz=MYewdgzgLgBApgGzgWzmWBeGAeAFgRgD4AJRBEAGhgHcQAnBAEwEJsB6AwgbgChRJY_KAEMAlmDh0YWRiGABXVOgB0AczhQAokiVQAQgE8AkowAUAcjogQUcwEpeAJTjDgUACIB5ALLK6aRklTRBQ0KCohMQk6Bx4gA), чтобы увидеть JavaScript-код, полученный на этапе компиляции JSX.

**ИНТЕРАКТИВНЫЙ JSX-РЕДАКТОР[x]  JSX?**

```jsx
class HelloMessage extends React.Component {
  render() {
    return (
      <div>
        Привет, {this.props.name}
      </div>);
  }
}

root.render(<HelloMessage name="Саша" />);
```

**РЕЗУЛЬТАТ**

Привет, Саша

---

### Компонент с состоянием

Помимо входных данных (доступных через `this.props`), компонент поддерживает внутренние данные состояния (доступные через `this.state`). Когда данные состояния компонента изменятся, React ещё раз вызовет `render()` и обновит отрендеренную разметку.

```jsx
class Timer extends React.Component {
  constructor(props) {
    super(props);
    this.state = { seconds: 0 };
  }

  tick() {
    this.setState(state => ({
      seconds: state.seconds + 1
    }));
  }

  componentDidMount() {
    this.interval = setInterval(() => this.tick(), 1000);
  }
}
```

### Шаг 1: Установка NPM в Ubuntu

Мы начинаем установку **React JS** с установки **npm** – это сокращение от **node package manager**. Первое **node package manager** это инструмент командной строки, используемый для взаимодействия с пакетами Javascript, который позволяет пользователям устанавливать, обновлять и управлять инструментами и библиотеками Javascript.

```bash
sudo apt install npm
npm —version
```

Во время установки **npm** также устанавливается и **node.js,** вы можете проверить версию с помощью команды:

```bash
node —version
```

### Шаг 2: Установка утилиты create-react-app

**create-react-app** — это утилита которая позволяет настроить все инструменты, необходимые для создания приложения **React**. Это экономит вам много времени устанавливая все с нуля.

Чтобы установить инструмент, выполните следующую команду **npm**:

```bash
sudo npm -g install create-react-app
create-react-app —version
```

### Шаг 3: Создайте И Запустите Свое Первое Приложение в React

После того как нам удало установить React, пришло время создать приложение в ReactJS. Скажу честно, дело это довольно простое. Сейчас мы расскажем как создать React приложение под названием setiwik-app. Делается это следующим образом.

```bash
create-react-app setiwik-app
```

https://developer.mozilla.org/ru/docs/Web/JavaScript/Language_overview

https://codepen.io/gaearon/pen/oWWQNa?editors=0010

https://ru.legacy.reactjs.org/tutorial/tutorial.html

https://ru.legacy.reactjs.org/docs/create-a-new-react-app.html