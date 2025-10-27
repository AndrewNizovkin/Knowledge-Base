## [Создание простейшего макета](https://metanit.com/web/html5/8.8.php)

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <!-- <link href="styles.css" rel="stylesheet"> -->
        <title>Блочная верстка в HTML5</title>
      <style>
        * {
    box-sizing: border-box;
}
html, body, div, span, h1, h2, h3, h4, h5, h6, p, a, ul, li{
                 
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    vertical-align: baseline;
}
body {
    font-family: Verdana, Arial, sans-serif;    
    background-color: #f7f7f7;
}
#header{ 
    background-color: #f4f4f4;
}
#header h1 {
    font-size: 24px;
    text-transform: uppercase;
    font-weight: bold;
    padding: 30px 30px 30px 10px;
    clear: both;
}
#nav {
    background-color: #eee;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
#nav li {
    float: left;
    list-style: none;   
}
#nav a {
    display: block;
    color: black;
    padding: 10px 25px;
    text-decoration: none;
    border-right: 1px solid #ccc;
}
#nav li:last-child a {
    border-right: none; 
}
#nav a:hover {
    font-weight: bold;
}
#nav:after {
    content: " ";
    display: table;
    clear: both;
}
.wrapper{
    background-color: #f7f7f7;
}
.aside h2 {
    font-size: 0.95em;
    margin-top: 15px;
}
.aside h3 {
    font-size: 0.85em;
    margin-top: 10px;
}
.aside p, .aside li {
    font-size: .75em;
    margin-top: 10px;   
}
.aside li{ 
    list-style-type: none;
}
#sidebar1 {
    float: left;
    width: 20%; 
    padding: 0 10px 0 20px;
}
#sidebar2 {
    float: right;
    width: 20%; 
    padding: 0 20px 0 10px;
}
#article{
    background-color: #fafafa;
    border-left: 1px solid #ccc;
    border-right: 1px solid #ccc;
    margin-left: 20%;
    margin-right: 20%;
    padding: 15px;
    width: 60%;
}
#article:after{
    clear:both;
    display:table;
    content:'';
}
#article h2{
    font-size: 1.3em;
    margin-bottom:15px;
}
#article p{
    line-height: 150%;
    margin-bottom: 15px;
}
#footer{ 
    border-top: 1px solid #ccc;
    font-size: .8em;    
    text-align: center;
    padding: 10px 10px 30px 10px;
}
#nav ul, #header h1, .wrapper, #footer p {
    max-width: 1200px;
    margin: 0 auto; 
}
.wrapper, #nav, #header, #footer{
    min-width: 768px;
}
      </style>
    </head>
    <body>
        <div id="header">
            <h1>MySyte.com - Сайт о Lorem Ipsum</h1>
            <div id="nav">
                <ul>
                    <li><a href="#">Главная</a></li>
                    <li><a href="#">Блог</a></li>
                    <li><a href="#">Форум</a></li>
                    <li><a href="#">Контакты</a></li>
                    <li><a href="#">О сайте</a></li>
                </ul>
            </div>
        </div>
        <div class="wrapper">
            <div id="sidebar1" class="aside">
                <h2>The standard Lorem Ipsum passage</h2>
                <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt 
                ut labore et dolore magna aliqua..."</p>
                </div>
            <div id="sidebar2" class="aside">
                <h2>1914 translation by H. Rackham</h2>
                <p>It is a long established fact that a reader will be distracted by the readable 
                content of a page when looking at its layout.</p>
                <h3>Options</h3>
                <ul>
                    <li>Item1</li>
                    <li>Item2</li>
                    <li>Item3</li>
                </ul>
            </div>
            <div id="article">
                <h2>What is Lorem Ipsum?</h2>
                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry...</p>
                <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of 
                classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, 
                a Latin professor at Hampden-Sydney College in Virginia...</p>
            </div>
        </div>
        <div id="footer">
            <p>Contacts: admin@mysyte.com</p>
            <p>Copyright © MySyte.com, 2016</p>
        </div>
    </body>
</html>
```
