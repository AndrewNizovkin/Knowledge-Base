# Семинар 7.Spring Security.

[Ссылка на видео](https://gbcdn.mrgcdn.ru/uploads/record/324862/attachment/c0c1ee9347046d6392750a7bbef6705c.mp4)

Spring Security, при запуске приложения, предлагает поведение по умолчанию, при котором отображается форма аутентификации для ввода логина и пароля, при этом генерируя рандомный пароль, выводимый в лог. 

Чтобы изменить это поведение создаём пакет `security`

## Шаг 1. Создаём UserDetailService

`UserDetailsService` - интерфейс из пакета `springframwork.security`, который будет обрабатывать запросы и возвращать сущность `UserDetails` , с которой будет работать Spring Security. Он будет искать в репозитории запись по логину

 если мы реализуем этот интерфейс, то спринг будет  использовать именно его и реализовать поведение в нём  

CustomUserDetailService.java - класс, который обрабатывать запросы 
```java
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import ru.gb.springlesson7.model.Person;
import ru.gb.springlesson7.repository.PersonRepository;

import java.util.List;

@Component
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

    private final PersonRepository repository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("ищем " + username);
        Person person = repository.findByLogin(username).orElseThrow(() ->
                new UsernameNotFoundException("Пользователь " + username + " не найден"));
        System.out.println("нашли " + person);
        return new User(person.getLogin(), person.getPassword(), List.of(
                new SimpleGrantedAuthority(person.getRole())
        ));
    }
}
```

`UserDetails` - интерфейс SpringSecurity, который несёт информацию о пользователе, который подключается

```java
public interface UserDetails extends Serializable {
Collection<? extends GrantedAuthority> getAuthorities():

String getPassword();

String getUsername();

boolean isAccountNonExpired();

boolean isAccountNonLocked();

boolean isCredentialsNonExpired();

boolean isEnabled();

}
```

`User`  - одна из реализаций `UserDetails` В коде используется конструктор, в который передаётся логин, пароль и список ролей. В него мы передаём данные, полученные из нашей базы данных пользователей (persons)

`SimpleGrantedAuthority` Класс, который хранит в себе роль персонажа

`UsernameNotFoundException` - исключение из Spring Security

## Шаг 2. Создаём класс для сравнения паролей

Для сравнения паролей, полученных от пользователя и из базы данных, нужно создать класс, наследующий интерфейс `PasswordEncoder`

В методе `encode` шифруется (или нет как в нашем случае) принимаемый пароль. Метод `matches` сравниваем зашифрованный пароль с паролем из базы

```java
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CustomPasswordEncoder implements PasswordEncoder {
    @Override
    public String encode(CharSequence rawPassword) {
        //шифруем данные
        return String.valueOf(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return encode(rawPassword).equals(encodedPassword);
    }
}
```

## Шаг 3. Создаём конфигурацию Spring Security

Для управления доступом нужно создать файл конфигурации и в нем методы, возвращающие нужные нам бины

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Configuration
public class SecurityConfiguration {

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) 
                                                      throws Exception{
// ----это для oauth2
/*
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(source -> {
            Map<String, Object> claim = source.getClaim("realm_access");
            List<String> roles = (List<String>) claim.get("roles");
            return roles.stream()
                    .map(SimpleGrantedAuthority::new)
                    .collect(Collectors.toList());
        });
*/        

        return httpSecurity
                .authorizeHttpRequests(registry -> registry
                        .requestMatchers("user/**").hasAnyAuthority("user", "admin") // любой из массива
                        .requestMatchers("admin/**").hasAuthority("admin") 
                        .requestMatchers("auth/**").authenticated() // для аутентифицированных
                        .requestMatchers("any/**").permitAll() // для всех
                        .anyRequest().denyAll() // в остальных случаях запретить
                )
                .formLogin(Customizer.withDefaults()) // это добавить вместо oauth2
                .csrf(AbstractHttpConfigurer::disable) // отключает защиту от CSRF-атак

//                .oauth2ResourceServer(configurer -> configurer
//                        .jwt(Customizer.withDefaults()))

/*
                .oauth2ResourceServer(configurer -> configurer
                        .jwt(jwtConfigurer -> jwtConfigurer
                                .jwtAuthenticationConverter(converter)))
*/
                .build();
    }
}
```

### Oauth2 Authorization Framework

протокол авторизации, который позволяет приложениям получать ограниченный доступ к аккаунтам пользователя на внешних сервисах.

В Oauth2 определены четыре роли:

- `resource owner` - хозяин ресурса

- `resource server` - сервер, предоставляющий ресурс

- `client` - приложение, которое делает запрос

- `autorization server` - сервер авторизации

### Сервер авторизации **Keycloak**

https://www.keycloak.org/guides

[keycloack.org/guides](http://keycloack.org/guides) → Downloads    1:10 запуск в Docker

Keycloak работает на 8080, поэтому в конфигурации меняем порт и добавляем настройки для `oauth2` 

```yaml
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://localhost:8080/realms/master
  application:
    name: spring-boot-lesson-7
server:
  port: 8180
```

Postman. Отправка Post запроса с ключом `_csrf`

... смотри семинар