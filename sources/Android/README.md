# Android

Android-приложение состоит из четырёх компонентов. Каждый компонент — это точка входа, через которую система или пользователь может получить доступ.

- `Активность (activity)` — элементы интерактивного пользовательского интерфейса.Одна активность задействует другую и передаёт информацию о том, что намерен делать пользователь, через класс Intent (намерения). Активности подобны веб-страницам, а намерения — ссылкам между ними. Запуск приложения — это активность Main.

- `Намерения (intents)` — это сообщения на платформе Android. Намерение состоит из действия, которое нужно выполнить (просмотр, редактирование, набор номера и т.п.) и данных. 

- `Действие (action)` — это комбинация операций, которые нужно выполнить
при получении намерения, и данных, над которыми нужно выполнить указанные
операции. Например, данными могут быть параметры контакта в адресной книге.
Намерения используются для запуска деятельностей и коммуникации между раз-
ными частями системы Android. Приложение может либо передавать, либо получать
намерения.

- `Сервис (service)` — универсальная точка входа для поддержания работы приложения в фоновом режиме.*Этот компонент выполняет длительные операции или работу для удалённых процессов без визуального интерфейса.*

- `Широковещательный приемник (broadcast receiver)` транслирует нескольким участникам намерения из приложения.

- `Поставщик содержимого (content provider)` управляет общим набором данных приложения из файловой системы, базы данных SQLite, интернета или другого хранилища.

Мэшап (mashup) — это объединение нескольких служб в одном приложении. На- пример, с помощью мэшапа, созданного с использованием камеры и службы иден- тификации местоположения, можно получить снимок и вставить в него точные гео- графические координаты камеры в момент съемки. Комбинируя разные службы и библиотеки, можно создавать самые разнообразные приложения.

Видовое окно — базовый элемент пользовательского интерфейса, представляющий собой прямоугольную область на экране, предназначенную для рисования и обработ- ки событий. Фактически видовые окна являются такими же элементами управления, как и виджеты, но, в отличие от последних, они “нагружены” многими функциями. 

Ниже приведен ряд примеров видовых окон:

- ContextMenu (Контекстное меню);
- Menu (Меню);
- View (Вид);
- SurfaceView (Поверхность рисования).

Виджет — это элемент управления, выполняющий определенную функцию. Например, такой виджет, как флажок, определяет одно из двух возможных состояний некоторого параметра. Представляйте себе виджеты как элементы управления на экране, с которыми взаимодействует пользователь. Ниже приведены примеры вид- жетов:

- Button (Кнопка);
- CheckBox (Флажок);
- DatePicker (Инструмент выбора даты);
- DigitalClock (Цифровые часы);
- Gallery (Галерея изображений);
- FrameLayout (Компоновка фрейма);
- ImageView (Рамка изображения);
- RelativeLayout (Относительная компоновка);
- PopupWindow (Всплывающее окно).

http://developer.android.com/reference/android/widget/package-summary.html - ссылка на другие виджеты

Класс AsyncTask платформы Android позволяет выполнять многие операции од-
новременно, избавляя от необходимости управлять отдельными потоками вручную.
При запуске нового процесса с помощью класса AsyncTask выполняется автомати-
ческая очистка системы, а результаты возвращаются объекту, запустившему данный
процесс. Это позволяет реализовать чистую модель асинхронных вызовов.