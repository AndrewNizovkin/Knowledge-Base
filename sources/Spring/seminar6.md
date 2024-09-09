# Семинар 6. Swagger

Вместо `HttpStatus.OK` можно воспользоваться следующей конструкцией:

```java
    @GetMapping("{id}")
    public ResponseEntity<Book> findById(@PathVariable long id){
        return ResponseEntity.ok().body(bookService.findById(id));
    }
```

Не всегда возвращают тело. Можно вернуть `location`

```java
    @PostMapping
    public ResponseEntity<Book> createBook(@RequestBody Book book){
        Book createdBook = bookService.createBook(book);

        URI location = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(createdBook.getId())
                .toUri();
        return ResponseEntity.created(location).body(createdBook);
    }

```

Можно ничего не возвращать

```java

    @DeleteMapping("{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable long id){
        bookService.deleteById(id);
        return ResponseEntity.ok().build();
    }
```

### Связь один ко многим:

```java
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Table(name = "issue")
@Data
public class Issue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_book", referencedColumnName = "id")
    private Book book;

    @ManyToOne
    @JoinColumn(name = "id_reader")
    private Reader reader;

    @Column(name = "issued_at")
    private LocalDateTime issuedAt;

    @Column(name = "returned_at")
    private LocalDateTime returnedAt;
}
```

### Дополнительный метод в интерфейсе репозитория, возвращающий количество книг на руках у читателя:

```java
@Repository
public interface IssueRepository extends JpaRepository<Issue, Long> {
    long countByReaderAndReturnedAtIsNull(Reader reader);
}
```

```java
@Value не работала, пока не заменил импорт
import lombok.Value; // не  работает
import org.springframework.beans.factory.annotation.Value; // работает
```

```java
@NotNull // аннотация для валидации
```

### Swagger

```xml
<!--Первая зависимость это swagger     -->
<dependency>
	<groupId>org.springdoc</groupId>
	<artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
	<version>2.3.0</version>
</dependency>
<!--Вторая - обеспечивает валидацию объектов, исп аннотации типа `@Valid, @NotNul` -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-validation</artifactId>
</dependency>
<!--Третья подтягивает информацию по файлам, помеченным аннотацией @ConfigurationProperties, @Configuration и сохраняет в файлик
 -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-configuration-processor</artifactId>
</dependency>
```

Для работы Swagger нужно запустить приложение

```java
localhost:8080/swagger-ui/index.html // web-интерфейс

localhost:8080/v3/api-docks // выдаёт описание API
```

Добавление методу класса контроллера следующих аннотаций настраивает Swagger. Добавляет информативности в автоматически генерируемую документацию

```java
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

    @Operation(summary = "get all persons", description = "Загружает всех пользоватлеей, которые есть в системе")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Success"),
            @ApiResponse(responseCode = "400", description = "Bad request"),
            @ApiResponse(responseCode = "401", description = "Unauthorized"),
            @ApiResponse(responseCode = "403", description = "Forbidden"),
            @ApiResponse(responseCode = "404", description = "Not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
        @GetMapping
    public ResponseEntity<List<BookDto>> findAll(){
        return ResponseEntity.status(HttpStatus.OK).body(bookService.findAll());
    }
```

Добавление в тело ДТО класса аннотаций swagger

```java

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(name = "Книга")
public class BookDto {
    @Schema(name = "Идентификатор", minimum = "0")
    private long id;
    @NotNull
    @Schema(name = "Название книги")
    private String name;
}
```

Запуск GUI Swagger: localhost:88080/swagger-ui/index.html

Описание API приложения: localhost:88080/v3/api-docs

[//localhost:8080/group/{id}/student](https://localhost:8080/group/%7Bid%7D/student) 404
[//localhost:8080/student?group=id](https://localhost:8080/student?group=id) 203 not content
//CRUD