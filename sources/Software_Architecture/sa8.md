# Урок 11. Сервис-ориентированные архитектуры.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/4728771/attachment/e459ef4b455b1f6e79305159a6482286.pdf)

### Монолитное приложение

однослойное программное приложение, в
котором пользовательский интерфейс и коды доступа к данным объединены в
одну программу с одной платформы. Монолитное приложение является
автономным и независимым от других вычислительных приложений. Философия
дизайна заключается в том, что приложение отвечает не только за конкретную
задачу, но и может выполнять каждый шаг, необходимый для выполнения
определенной функции.

## Архитектуры независимых компонентов

Программные системы архитектура которых состоит из независимо
работающих компонентов, общающихся друг с другом – называются
распределёнными

### Распределённая система

это система, для которой отношения
местоположений элементов (или групп элементов) играют существенную роль с
точки зрения функционирования системы, а следовательно, и с точки зрения
анализа и синтеза системы

Монолитные:

- Многослойная архитектура

- Конвейерная архитектура

- Микроядерная архитектура
Распределенные:

- Событийно-ориентированная архитектура

- Сервис-ориентированная архитектура

- Архитектура микросервисов

### Архитектура SOA
SOA - представляет собой набор архитектурных принципов и
архитектурный стиль проектирования программного обеспечения, не зависящих
от технологий и продуктов, в котором бизнес-системы и ИТ-системы
разрабатываются с точки зрения сервисов, доступных через интерфейс, а также
результатов действий этих сервисов.

SOA - это общекорпоративный подход к разработке программного
обеспечения для компонентов приложений, который использует преимущества
многократно используемых программных компонентов или сервисов (служб).
Служба - это логическое представление набора действий, порождающих
заданные результаты; служба является автономной, может состоять из других
служб, при этом потребители данной службы не обязаны знать ее внутреннюю
структуру.

Реестр сервисов представляет собой каталог сервисов, доступных в
системе SOA. Он содержит физическое месторасположение сервисов, версии и
их срок действия, а также другую полезную информацию

Задача Микросервисного подхода - это создание приложения в виде
набора небольших автономных сервисов, нужных бизнесу, а также - это
архитектурный стиль разработки, который позволяет создавать приложения в
виде набора небольших автономных сервисов, разработанных для бизнес-сферы.
Что может быть выражено с помощью Закона Конвея.

### Закон Конвея

**«Организации проектируют системы, которые копируют структуру коммуникаций в этой организации».**

### Service Mesh

это способ управления тем, как различные части приложения обмениваются данными друг с другом. В отличие от других систем управления этим взаимодействием, Service Mesh представляет собой специальный инфраструктурный слой, встроенный прямо в приложение. Этот видимый инфраструктурный слой может документировать, насколько хорошо
(или плохо) взаимодействуют различные части приложения, поэтому становится
проще оптимизировать взаимодействие и избежать простоев по мере роста
приложения.

Service Mesh - это конфигурируемый инфраструктурный уровень с низкой
задержкой, предназначенный для обработки большого объема сетевого
межпроцессного взаимодействии между сервисами инфраструктуры
приложений с использованием интерфейсов прикладного программирования
(API). Service Mesh обеспечивает быстрое, надежное и безопасное
взаимодействие между контейнерными и часто эфемерными сервисами
инфраструктуры приложений. Service Mesh обеспечивает критически важные
возможности, включая обнаружение сервисов, балансировку нагрузки,
маршрутизацию, шифрование, наблюдаемость, отслеживаемость,
аутентификацию и авторизацию, а также поддержку схемы "выключатель"
(Circuit Breaker).

Service Mesh обычно реализуется путем предоставления экземпляра
прокси-сервера, называемого sidecar, для каждого экземпляра сервиса.
Прокси-серверы обрабатывают межсервисные коммуникации, мониторинг и
вопросы безопасности - в общем, все, что можно абстрагировать от отдельных
сервисов. Таким образом, разработчики могут заниматься разработкой,
поддержкой и обслуживанием кода приложения в сервисах; операционные
команды могут обслуживать сетку сервисов и запускать приложения.

Независимость реализации (гетерогенность)

Сервисы могут быть реализованы на различных языках программирования, с
использованием различных технологий.

### Событийно-ориентированная архитектура (Event Driven Architecture – EDA )

это интеграционная модель программных систем, построенная на публикации,
захвате, обработке и хранении (или персистенции) событий. В частности, когда приложение или сервис выполняет действие или претерпевает изменение, о котором может захотеть узнать другое приложение или сервис, оно публикует
событие - запись этого действия или изменения, - которое другое приложение
или сервис может использовать и обрабатывать для выполнения одного или
нескольких действий в свою очередь.

### Space-Based Architecture - SBA

Архитектура на основе распределения и масштабирования или
пространственная архитектура (Space-Based Architecture - SBA) - это архитектура
распределенных вычислений для достижения линейной масштабируемости
высокопроизводительных приложений, основанных на состоянии, с
использованием парадигмы пространства кортежей (объектов в пространстве
разделяемой памяти). SBA минимизирует факторы, ограничивающие
масштабирование приложений.

В этом архитектурном шаблоне есть два основных компонента: блок
обработки (Процессоры - Processing unit - PU) и виртуализированное
промежуточное ПО (VM)

### Вертикальное масштабирование (Scale up)

увеличение производительности каждого компонента системы с целью повышения общей производительности. Масштабируемость в этом контексте означает возможность заменять в существующей вычислительной системе компоненты более мощными и быстрыми по мере роста требований и развития технологий

Архитектуры без разделения ресурсов
Архитектуры без разделения ресурсов (shared-nothing architectures),
известные под названием горизонтального масштабирования (horizontal scaling, scaling out). При этом подходе каждый компьютер или виртуальная машина, на которой работает база данных, называется узлом (node). Все узлы используют свои CPU, память и диски независимо друг от друга. Согласование узлов выполняется на уровне программного обеспечения с помощью обычной сети.

### Горизонтальное масштабирование (Scale out)

разбиение системы на
более мелкие структурные компоненты и разнесение их по отдельным
физическим машинам (или их группам), и (или) увеличение количества серверов,
параллельно выполняющих одну и ту же функцию. Масштабируемость в этом
контексте означает возможность добавлять к системе новые узлы, серверы для
увеличения общей производительности. Этот способ масштабирования может
требовать внесения изменений в программы, чтобы программы могли в полной
мере пользоваться возросшим количеством ресурсов.

### Балансировщик нагрузки (Load Balancer)

сервис, помогающий серверам
эффективно перемещать данные, оптимизирующий использование ресурсов
доставки приложений и предотвращающий перегрузки. Он управляет потоком
информации между локальным или облачным хранилищем и конечным
устройством пользователя.

### Распределенное хранилище данных

это компьютерная сеть, в которой
информация хранится более чем на одном узле, часто реплицируемым образом.
Обычно он специально используется для обозначения либо распределенной базы
данных, в которой пользователи хранят информацию на нескольких узлах, либо
компьютерной сети, в которой пользователи хранят информацию на нескольких
узлах одноранговой сети

Разделение данных в СУБД называют – `фрагментирование`,
`сегментирование`, `партиционирование` или `шардинг`.

`Шардирование/Секционирование/Партиционирование` - разбиение
большой базы данных на небольшие подмножества, называемые секциями
(partitions), в результате чего разным узлам можно поставить в соответствие
различные секции/шарды (это называется «шардинг»).

`Репликация (от лат. replico -повторяю)` — это синхронное или асинхронное
копирование данных между несколькими серверами с главного сервера БД на
одном или нескольких зависимых серверах. Ведущие сервера называют
мастерами (master), а ведомые сервера — слэйвами (slave). Мастера
используются для изменения данных, а слэйвы — для считывания.

Узлы, в которых хранятся копии БД, называются - репликами.

Стили взаимодействия это способы описания взаимодействия между
клиентами и сервисами, не привязанные к конкретным технологиям.

## Архитектура развёртывания

Архитектуры развёртывания существенно разнятся, но в целом, ярусы
начинаются с develpment (DEV) и заканчиваются production (PROD).
Распространённой 4-х ярусной архитектурой является каскад ярусов:

- deployment

- testing

- model

- production 

(DEV, TEST, MODL, PROD) c деплоем софта на каждом
ярусе по очереди.

Трассировка представляет собой весь путь запроса или действия,
проходящий через все узлы распределенной системы. Трассировка позволяет
составлять профиль и наблюдать за системами, особенно за контейнерными
приложениями, бессерверными архитектурами или архитектурой
микросервисов. Анализируя данные трассировки, вы и ваша команда можете
измерить общее состояние системы, определить узкие места, быстрее выявлять
и устранять проблемы, а также определить приоритетные области для
оптимизации и улучшений.