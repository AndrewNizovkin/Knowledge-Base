# Семинар 7.Spring Security.

## Шаг 1. Создаём UserDetailService

`UserDetailsService` - класс, который будет обрабатывать запросы и возвращать сущность `UserDetails` , с которой будет работать Spring Security. Он будет искать в репозитории запись по логину

`CustomUserDetailService` если мы реализуем этот интерфейс, то спринг будет  использовать именно его и реализовать поведение в нём  

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

`UserDetails` - объект SpringSecurity, который несёт информацию о пользователе

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

`User`  - одна из реализаций `UserDetails`

`SimpleGrantedAuthority` Класс, который хранит в себе роль персонажа

`UsernameNotFoundException` - исключение из Spring Security

## Шаг 2. Создаём класс для сравнения паролей

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

Создаём файл конфигурации и в нем методы, возвращающие наши бины

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
                        .requestMatchers("user/**").hasAnyAuthority("user", "admin") // любой из
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

Использование `oauth2` 

Сервер авторизации **Keycloak**

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