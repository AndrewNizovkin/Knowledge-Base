# Добавление компонента на экран из Java кода при инициализации экрана

> Добавим колонку с кнопкой просмотра прикреплённых файлов в таблицу задач. 

1. В код контроллера добавим (`Gentrate Handler`) обработчик события `InitEvent`

2. Инжектируем в контроллер `DataGrid` (`Inject > tasksDataGrid`)

3. Используем метод `AddComponentColumn()` чтобы добавить колонку, элементами которой являются компоненты. 

Метод принимает лябду, в теле которой будет создаватья элемент с некоторой логикой.

4. Компонент создаётся с помощью фабрики `UiComponents`, которую тоже нужно инжектировать в контроллер.

5. Инжектируем в контейнер бин `Downloader` для использования его для действия, при возникновении события `ClickEvent`. Для загрузки содержимого файла.

```java
public class TaskListView extends StandardListView<Task> {
    @ViewComponent
    private DataGrid<Task> tasksDataGrid;
    @Autowired
    private UiComponents uiComponents;
    @Autowired
    private Downloader downloader;

    @Subscribe
    public void onInit(final InitEvent event) {
        tasksDataGrid.addComponentColumn(attachment -> {
            Button button = uiComponents.create(Button.class);
            button.setText("Attachment");
            button.setThemeName("tertiary-inline");
            if (attachment.getAttachment() == null) {
                button.setEnabled(false);
            }
            button.addClickListener(clickEvent -> {
                downloader.download(attachment.getAttachment());
            });
            return button;
        });
    }
}
```









