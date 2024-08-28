

# Установка java, IntellijIdea

**java —version - проверка установленной версии.** 

Установите последнюю версию Java Runtime Environment (JRE):

`sudo apt install default-jre`

Или Java Development Kit (OpenJDK), которая уже включает в себя JRE:

`sudo apt install default-jdk`

Установите нужную версию OpenJDK:

`sudo apt install openjdk-8-jdk`

---

На одном сервере может быть установлено несколько версий Java. Рассмотрим, как сделать нужную вам версию версией по умолчанию:
1. Посмотрите установленные версии:

`update-alternatives --config java`

Введите номер версии, которую вы хотите сделать версией по умолчанию, и нажмите **Enter**.

---

Для работы некоторых программ на java нужно установить переменную окружения **java_home**. для этого:

Определите, в какой директории установлена версия java, которая используется по умолчанию:

`sudo update-alternatives --config java`

Откройте файл:

`sudo nano /etc/environment`

Добавьте в файл строку, содержащую путь до папки `bin`:

`JAVA_HOME="ваш_путь"`

После сохранения перезагрузите файл:

`source /etc/environment`

Проверьте результат. Для этого выполните команду:

`echo $JAVA_HOME`

---

# IntellijIdea

### Установка из Snap-пакета

Для установки свободной редакции (Community Edition):

`sudo snap install intellij-idea-community --classic --edge`

---

Для установки платной редакции (Ultimate Edition) необходимо выполнить команду:

`sudo snap install intellij-idea-ultimate --classic --edge`

После завершения загрузки пакета программа будет доступна из главного меню: