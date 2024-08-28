# Семинар 9.Spring Cloud. Eureca

https://habr.com/ru/companies/ruvds/articles/732648/


**RestTemplate** — это *синхронный* клиент для выполнения HTTP-запросов, он предоставляет простой API с шаблонным методом поверх базовых HTTP-библиотек, таких как `HttpURLConnection` (JDK), `HttpComponents` (Apache) и другими.

## Spring WebFlux

является частью Spring 5 и обеспечивает поддержку реактивного программирования для веб-приложений.

### WebClient

это неблокирующий, реактивный клиент для выполнения HTTP-запросов, часть Spring WebFlux.

https://habr.com/ru/companies/otus/articles/541404/

https://docs.spring.io/spring-framework/reference/web/webflux-webclient.html

Spring Web Flux включает в себя клиент для выполнения HTTP-запросов. WebClient имеет функциональный, свободно работающий API, основанный на Reactor, см. Reactive Libraries, который позволяет создавать декларативную асинхронную логику без необходимости работать с потоками или параллелизмом. 

```java
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-webflux</artifactId>
        </dependency>

```

Он полностью неблокирующий, поддерживает потоковую передачу и использует те же кодеки, которые также используются для кодирования и декодирования содержимого запросов и ответов на стороне сервера.

### **Подготовка запроса с помощью Spring WebClient**

WebClient поддерживает методы: `get()`, `post()`, `put()`, `patch()`, `delete()`, `options()` и `head()`.

Также можно указать следующие параметры:

- Переменные пути (`path variables`) и параметры запроса с помощью метода `uri()`.
- Заголовки запроса с помощью метода `headers()`.
- Куки с помощью метода `cookies()`.

После указания параметров можно выполнить запрос с помощью `retrieve()` или `exchange()`. Далее мы преобразуем результат в Mono с помощью `bodyToMono()` или во Flux с помощью `bodyToFlux()`.

```java
@Component
public class BookProvider {

    private final WebClient webClient;

    public BookProvider(EurekaClient eurekaClient,
                        ReactorLoadBalancerExchangeFilterFunction loadBalancerExchangeFilterFunction) {
        webClient = WebClient.builder()
                .filter(loadBalancerExchangeFilterFunction)
                .build();
    }

/**
* получает результат Get запроса в виде
* экземпляра класса Book.Dto
*/
    public BookDto getRandomBookDto() {
        return webClient.get()
                .uri("http://book-service/book/random")
                .retrieve()
                .bodyToMono(BookDto.class)
                .block();
    }
}

```

```yaml
spring:
  application:
    name: book-service
server:
  port: 8581
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka
```