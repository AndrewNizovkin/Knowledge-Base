[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5643776/attachment/d0070efffdde65ef31c0900a6368cd84.pdf)

[mvnrepository.com](http://mvnrepository.com) - центральный мавен-репозиторий

Проект настраивается в pom.xml

1. Основная информация: Включает элементы <groupId>, <artifactId>, <version>
и <packaging>. Они определяют уникальный идентификатор вашего проекта,
версию и тип пакета (например, JAR или WAR).
2. Зависимости: Как мы уже обсудили ранее, элемент <dependencies>
используется для указания зависимостей вашего проекта.
3. Репозитории: Элемент `<repositories>` позволяет добавить удаленные
репозитории для поиска артефактов, которые недоступны в центральном
репозитории.
4. Плагины: Внутри элемента `<build>` находится элемент `<plugins>`, который
содержит объявления плагинов, используемых в вашем проекте.
5. Свойства: Элемент `<properties>` позволяет задавать переменные, которые
могут быть использованы для настройки плагинов и других элементов
POM-файла. Например, вы можете задать версию Java, используемую для
компиляции вашего проекта:

```bash
<properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
</properties>

```

6. Профили: Элемент <profiles> позволяет определить различные конфигурации
для разных сред разработки или сценариев сборки. Например, вы можете
создать профиль для разработки с дополнительными плагинами или
настройками и другой профиль для сборки продакшн-версии вашего
приложения.

Для создания простого mvn-проекта:

```bash
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app
-DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

```bash
mvn package # чтобы собрать проект

java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App
# Запуск класса App из пакета com.mycompany.app
```

Добавляем плагин для создания исполняемого jar-файла с зависимостями, чтобы можно было легко запускать приложение:

```bash
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-assembly-plugin</artifactId>
	<version>3.3.0</version>
	<configuration>
		<archive>
			<manifest>
				<mainClass>com.mycompany.app.App</mainClass>
			</manifest>
			</archive>
		<descriptorRefs>
			<descriptorRef>jar-with-dependencies</descriptorRef>
		</descriptorRefs>
		</configuration>
	<executions>
		<execution>
			<id>make-assembly</id>
			<phase>package</phase>
			<goals>
				<goal>single</goal>
			</goals>
			</execution>
		</executions>
</plugin
```

Теперь для создания jar-файла:

```bash
java -jar target/my-app-1.0-SNAPSHOT-jar-with-dependencies.jar
```

### Настройка ресурсов

Для настройки обработки ресурсов, таких как изображения и пр. можно использовать плагин maven-resources-plugin. Добавляем в секцию <plugins>

```bash
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-resources-plugin</artifactId>
	<version>3.2.0</version>
	<configuration>
		<encoding>UTF-8</encoding>
		<resources>
			<resource>
				<directory>src/main/resources</directory>
				<includes>
					<include>**/*.properties</include>
					<include>**/*.xml</include>
				</includes>
		 		</resource>
			</resources>
		</configuration>
	</plugin>
```

### Добавление плагина для создания исполняемого JAR-файла

```bash
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-shade-plugin</artifactId>
	<version>3.2.4</version>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>shade</goal>
			</goals>
			<configuration>
				<transformers>
					<transformer
					implementation="org.apache.maven.plugins.shade.resource.ManifestRe
					sourceTransformer">
					<mainClass>com.example.MainClass</mainClass>
					</transformer>
				</transformers>
			</configuration>
		</execution>
	</executions>
</plugin>
```

`com.example.MainClass` нужно заменить на полное имя своего главного класса. Теперь, после выполнения mvn package, Maven создаст исполняемый jar-файл, который будет содержать все зависимости и может быть запущен с помощью команды `java -jar`

# Gradle

Основные понятия

1. Проект: В Gradle, проект – это базовая единица работы. Проект может
представлять собой библиотеку, приложение или даже набор задач, которые
не связаны с кодом. Gradle-проект обычно содержит файл сборки с именем
build.gradle.
2. Задача (Task): Задача – это атомарная единица работы в Gradle. Задачи могут
выполнять различные операции, такие как компиляция кода, копирование
файлов, создание архивов и т. д. Задачи могут зависеть друг от друга, что
позволяет Gradle определить правильный порядок выполнения.
3. Плагин: Плагины добавляют новые задачи и настройки в ваш проект. Вам
могут быть знакомы плагины, такие как java, groovy, maven-publish и т. д.
Плагины могут быть созданы как самими разработчиками Gradle, так и
сообществом.

### Структура проекта Gradle

```bash
my-gradle-project/
|-- build.gradle
|-- settings.gradle
|-- gradle/
|     |-- wrapper/
|         |-- gradle-wrapper.jar
|         |-- gradle-wrapper.properties
|-- gradlew
|-- gradlew.bat
|-- src/
    |-- main/
    |     |-- java/
    |     |-- resources/
    |-- test/
          |-- java/
          |-- resources/

```

1. build.gradle: Главный файл сборки, где вы определяете все настройки,
плагины, зависимости и задачи для вашего проекта. Этот файл написан на
Groovy или Kotlin DSL (Domain-Specific Language).
2. settings.gradle: Файл настроек, который содержит информацию о
многомодульных проектах и дополнительные настройки. Здесь вы можете
указать имя проекта и включить подпроекты.
3. gradle/wrapper: Директория, содержащая Gradle Wrapper, инструмент,
который позволяет пользователям собирать проект, не устанавливая Gradle
локально. Gradle
Wrapper состоит из двух файлов:
• gradle-wrapper.jar: исполняемый JAR-файл, который запускает сборку.
• gradle-wrapper.properties: файл свойств, который содержит информацию о
версии Gradle и URL для скачивания дистрибутива.
4. gradlew и gradlew.bat: Исполняемые файлы оболочки Gradle Wrapper для
Unix-подобных и Windows-систем соответственно. Эти файлы позволяют
разработчикам запускать Gradle-сборку без предварительной установки Gradle на
своем компьютере.

### Жизненный цикл сборки

Жизненный цикл сборки Gradle представляет собой последовательность фаз,
которые проходит ваш проект при сборке. В отличие от Maven, Gradle не имеет
строгого жизненного цикла с фазами. Вместо этого он предоставляет гибкий
механизм задач, которые могут быть связаны между собой, чтобы создать
желаемую последовательность операций.
Gradle позволяет разработчикам определять свои собственные задачи и
настраивать порядок выполнения. Однако, для удобства, Gradle предоставляет ряд
предопределенных задач, которые упрощают стандартный процесс сборки. Эти
задачи обычно включаются с помощью плагинов

### Стандартные задачи Gradle

1. clean: Удаляет директорию сборки, очищая все ранее созданные артефакты и
временные файлы.
2. compileJava: Компилирует исходный код Java в проекте.
3. processResources: Копирует ресурсы проекта (такие как файлы свойств и
изображения) в директорию сборки.
4. classes: Задача-агрегатор, которая зависит от compileJava и
processResources. Выполняется после завершения обеих предыдущих задач.
5. jar: Создает JAR-файл, содержащий скомпилированные классы и ресурсы
проекта.
6. assemble: Задача-агрегатор, которая зависит от jar и других задач, связанных
с артефактами проекта. Обычно выполняется после завершения задачи jar.
7. compileTestJava: Компилирует исходный код модульных тестов.
8. processTestResources: Копирует ресурсы, используемые во время модульного
тестирования, в директорию сборки.

9. testClasses: Задача-агрегатор, которая зависит от compileTestJava и
processTestResources. Выполняется после завершения обеих предыдущих
задач.
10. test: Запускает модульные тесты и генерирует отчеты о результатах
тестирования. Обычно выполняется после завершения задачи testClasses.
11. check: Задача-агрегатор, которая зависит от test и других задач, связанных с
проверкой качества кода (например, статическим анализом кода или
проверкой стиля). Выполняется после завершения задачи test.
12. build: Задача-агрегатор, которая зависит от assemble и check. Выполняется
после завершения всех связанных задач и является конечной задачей,
связанной со сборкой проекта

### Зависимости

Определяются внутри блока `dependencies` файла `build.gradle` 

```bash
dependencies {
implementation 'com.google.guava:guava:30.1-jre'
}
```

### Конфигурации

Gradle использует конфигурации для группировки зависимостей. Конфигурация —
это именованная коллекция зависимостей, которая может быть использована для
разных целей, таких как компиляция, тестирование или выполнение приложения.
Некоторые распространенные конфигурации включают implementation,
compileOnly, runtimeOnly и testImplementation.

• implementation: Зависимости, необходимые для компиляции и выполнения
приложения.

• compileOnly: Зависимости, необходимые только для компиляции приложения,
но не включаемые в сборку.

• runtimeOnly: Зависимости, необходимые только во время выполнения
приложения.

• testImplementation: Зависимости, необходимые для компиляции и
выполнения модульных тестов.

### Репозитории

репозиторий в Gradle предназначен для хранения зависимостей, необходимых для построения проекта.

Для добавления репозитория в проект, вам нужно определить его в блоке
`repositories` файла сценария сборки `build.gradle`. Вот пример добавления
репозитория Maven Central:

```bash
repositories {
    mavenCentral()
}
```

### Плагины

Плагины могут быть применены в файле сценария сборки `build.gradle` с помощью
метода `apply()`. Вот пример применения плагина Java:

```bash
apply plugin: 'java'

# Новый синтаксис
plugins {
    id 'java'
}
```

### Настройка проекта

Настройка проекта обычно выполняется в файле сценария сборки build.gradle.

```xml
apply plugin: 'java'
group = 'com.example'
version = '1.0.0'
repositories {
    mavenCentral()
}
dependencies {
    implementation 'com.google.guava:guava:30.1-jre'
}
tasks.withType(JavaCompile) {
    options.encoding = 'UTF-8'
}
```

## Создание простого Java-проекта с помощью Gradle

В папке проекта из терминала

```bash
gradle init --type java-application
# создаст структуру каталогов проекта, файл build.gradle со
# стандартной конфигурацией

./gradlew build
# выполнит компиляцию исходного кода, сборку артефактов и
# модульное тестирование. Результат сборки будет помещен в каталог build.

./gradlew run
# Запуск приложения
```

## Использование профилей для разных сборок

В отличие от Maven, Gradle не имеет встроенной поддержки профилей. Однако, вы
можете использовать подобный функционал с помощью конфигураций сценария
сборки и переменных окружения.

Для начала, создайте переменную окружения, которая будет указывать на текущий
профиль сборки. Вам нужно добавить эту переменную в файле `.gradle/gradle.properties`:

```bash
profile=default
# Здесь default - это имя профиля по умолчанию. Можно заменить его на другое
# имя, если хотите использовать другой профиль.
```

### Создание блока профилей

В файле `build.gradle` создайте блок профилей с разными настройками для каждого
профиля. Например:

```bash
ext.profiles = [
	default: {
		applicationName = 'MyAppDefault'
	},
	production: {
		applicationName = 'MyAppProduction'
	},
	development: {
		applicationName = 'MyAppDevelopment'
	}
]
```

Чтобы применить текущий профиль, используйте следующий код в файле `build.gradle`:

```bash
ext.profileConfig = profiles[project.findProperty('profile') ?: 'default']
# Этот код выбирает профиль на основе значения переменной окружения profile.
# Если переменная не задана, используется профиль по умолчанию.
```

Теперь вы можете использовать значения из текущего профиля в вашем сценарии
сборки. Например:

```bash
jar {
	manifest {
		attributes 'Implementation-Title':
profileConfig.applicationName, 'Implementation-Version': version
	}
}
# Этот код устанавливает атрибут Implementation-Title манифеста JAR-файла на
# значение applicationName из текущего профиля
```