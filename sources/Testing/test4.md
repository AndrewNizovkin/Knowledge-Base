# Урок 4. Зависимости в тестах.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5493194/attachment/d23669d9b2537ef348588c82c7449d74.pdf)

---

Юнит-тест — это автоматизированный тест, который проверяет правильность
работы юнит-единицы кода, проводит тестирование быстро и изолирован от
другого кода.

Dummy (фиктивный объект или объект-заглушка) — самый простой тип заглушки.
Это объект, который передаётся для удовлетворения конструктора. В самом
dummy-объекте ничего не будет реализовано.
Обычно такая заглушка используется для заполнения списков параметров, просто
передается тестируемой системе в качестве аргумента (или атрибута аргумента). В
большинстве случаев вместо неё можно использовать значения ‘‘null’’.

Stub (заглушки) — одни из самых популярных видов тестовых заглушек.
Stub-обьекты немного сложнее, чем dummy: они предоставляют готовые ответы на
наши вызовы, в них по-прежнему нет логики, но они возвращают
предопределённое значение. Это готовые ответы на вызовы, сделанные во время
теста, обычно вообще не реагируя ни на что, кроме того, что запрограммировано
для теста.

Mock (имитация) помогает эмулировать и проверять выходные взаимодействия —
то есть вызовы, совершаемые тестируемой системой к её зависимостям для
изменения их состояния. Они могут выдавать исключение, если получают вызов,
которого не ожидают.

Spy (шпионы) — это заглушки, которые также записывают некоторую информацию,
основанную на том, как они были вызваны.
Test spy (тестовый шпион) используется для тестов взаимодействия. Основная
функция — запись данных и вызовов, поступающих из тестируемого объекта, для
последующей проверки корректности вызова зависимого объекта. Он позволяет
проверить логику именно нашего тестируемого объекта без проверок зависимых
объектов.

Fake (подделка) — это тестовая заглушка, задача которой очень похожа на стаб:
предоставить простые и быстрые ответы клиенту, который его потребляет.
Основное отличие в том, что фейк использует простую и легковесную рабочую
реализацию под капотом.

💡 Такое разнообразие может показаться слишком сложным, но на деле все
разновидности можно разделить на два типа: моки и стабы. Их чаще всего
используют на практике, а остальные типы заглушек можно рассматривать
как их подтипы, так как различия между ними незначительны.