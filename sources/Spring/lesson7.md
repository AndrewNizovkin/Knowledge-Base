# 7.Spring Security. Работа с JWT. Защита от основных видов атак.

[Методичка](https://gbcdn.mrgcdn.ru/uploads/asset/5643809/attachment/920aa0f1e9de1c9e4ac68ed3ed338d1e.pdf)

https://habr.com/ru/articles/815285/ - **Комбинированная авторизация в Spring Security: Социальные сети и логин через username/password**

`Spring Security` – это мощный и настраиваемый механизм безопасности для приложений Spring, позволяющий интегрировать различные средства аутентификации и авторизации.

`JWT (JSON Web Token)` – это компактное, URL-безопасное средство представления между двумя сторонами. Они обычно используются для передачи данных аутентификации и авторизации.

`Bearer Token` – тип токена авторизации, который предоставляется клиентом при
каждом запросе. Это часто JWT.

`Authorization (аутентификация)` — это процесс проверки личности  пользователя, чтобы определить, имеет ли он доступ к ресурсу в целом. 

`Authorization (Авторизация)` – это распределение прав и возможностей для уже аутентифицированных пользователей. Авторизация основывается на ролях и других характеристиках зарегистрированного пользователя

`OAuth2` – протокол авторизации, который позволяет приложениям получать
ограниченный доступ к аккаунтам пользователя на внешних сервисах.

`CSRF (Cross-Site Request Forgery)` – вид атаки, при которой злоумышленник может
заставить пользователя выполнить нежелательное действие в веб-приложении, в
котором он аутентифицирован.

`CORS (Cross-Origin Resource Sharing)` – механизм, который позволяет разрешить
или запретить веб-страницам выполнение запросов к серверу с другого источника.

`XSS (Cross-Site Scripting)` – вид атаки, при которой злоумышленник может вставить
злонамеренный код в веб-страницы.

`SQL Injection` – вид атаки, при которой злоумышленник может выполнять
произвольные SQL-запросы в базе данных через вводимые пользователем данные.

`Principal` – текущий пользователь или системный процесс, который выполняет
действие в системе.

`Role-Based Access Control (RBAC)` – метод определения доступа на основе ролей
пользователей в системе.

`Filter Chain` – цепочка фильтров в Spring Security, которая обрабатывает входящие
HTTP-запросы для выполнения различных задач безопасности.

`Authentication Provider` – компонент в Spring Security, который определяет, как
пользователи будут аутентифицированы

## Принципы безопасности.

1. `Минимальные привилегии`: Принцип минимальных привилегий говорит о
том, что каждый пользователь (или процесс) должен иметь минимально
необходимые права для выполнения своих функций. Это означает, что
пользователи не должны иметь доступа к функциям или данным, которые они
не нуждаются для выполнения своих задач. Это прямо связано с
авторизацией, о которой мы говорили ранее.

2. `Защита данных`: Данные, особенно чувствительные, такие как личная
информация пользователей, должны быть защищены во все время. Это
может включать в себя шифрование данных, использование безопасных
протоколов передачи данных и обеспечение безопасного хранения данных.

3. `Аудит и мониторинг`: Всегда важно иметь возможность отслеживать и
анализировать действия в вашем приложении. Это может помочь выявить
подозрительную активность и быстро реагировать на возможные угрозы.

4. `Обработка ошибок и исключений`: Неправильная обработка ошибок может
привести к утечке информации, которая может быть использована
злоумышленниками. Важно убедиться, что ваше приложение корректно
обрабатывает ошибки и исключения, не раскрывая лишней информации.

5. `Обновления и патчи`: Уязвимости и ошибки безопасности могут появляться в
любой системе. Поэтому важно регулярно обновлять и применять патчи к
вашему приложению и его зависимостям.

### Spring Security

это фреймворк безопасности для Java-приложений.

Основные компоненты Spring Security - это:

1. Аутентификация: Как мы обсуждали ранее, аутентификация - это процесс
проверки личности пользователя. Spring Security предоставляет широкий
спектр механизмов аутентификации, таких как форма входа, LDAP, OAuth и
другие.

2. Авторизация: После того, как пользователь аутентифицирован, Spring
Security контролирует доступ к различным частям приложения. Это можно
настроить на уровне URL или методов, обеспечивая гибкий и мощный
механизм контроля доступа.

3. Защита от атак: Spring Security также обеспечивает защиту от самых
распространенных типов атак, таких как CSRF (межсайтовая подделка
запроса), XSS (межсайтовый скриптинг) и Session Fixation.

4. Шифрование паролей: Spring Security поддерживает различные механизмы
шифрования паролей, что помогает обеспечить безопасное хранение и
обработку паролей.

### JSON Web Token (JWT)

JWT – это стандарт, который определяет способ безопасной передачи информации
между двумя сторонами в виде JSON-объекта. Эта информация может быть
подтверждена и доверена, потому что она цифрово подписана

В Spring Security JWT обычно используется вместе с OAuth 2.0 для аутентификации и
авторизации. Схема обычно такова:

1. Пользователь аутентифицируется с помощью своих учетных данных.

2. После успешной аутентификации сервер создает JWT, который содержит
уникальные данные пользователя, и отправляет его обратно пользователю.

3. Пользователь сохраняет этот JWT и отправляет его в заголовке Authorization с
каждым последующим запросом.

4. Сервер проверяет JWT в каждом запросе, чтобы аутентифицировать
пользователя и определить его права доступа.

### Настройка Spring Security

Шаг 1: Добавление зависимости:

```xml
<dependency>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

Шаг 2: Создание класса конфигурации безопасности

Этот класс должен быть аннотирован `@EnableWebSecurity` и расширять `WebSecurityConfigurerAdapter`

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
		    .anyRequest()
		    .authenticated()
		    .and()
		    .httpBasic();
	}
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth)throws Exception {
		auth.inMemoryAuthentication()
		    .withUser("user")
		    .password(passwordEncoder()
		    .encode("password"))
		    .roles("USER");
		}
		
		@Bean
		public PasswordEncoder passwordEncoder() {
			return new BCryptPasswordEncoder();
	}
}
```

В этом классе мы говорим Spring Security, что мы хотим аутентифицировать любой
запрос и использовать базовую HTTP аутентификацию. Мы также настраиваем в
памяти аутентификацию с одним пользователем.

### Шаг 3: Тестирование нашей конфигурации безопасности

Для этого мы можем создать простой контроллер, который возвращает какой-нибудь
текст, и попробовать получить доступ к нему.

```java
@RestController
public class HelloController {

	@GetMapping("/hello")
	public String hello() {
		return "Hello, world!";
	}
}
```

Теперь, если вы попытаетесь открыть http://localhost:8080/hello в браузере, вы
должны увидеть диалоговое окно, запрашивающее имя пользователя и пароль.
Если вы введете имя пользователя “user” и пароль “password”, вы должны увидеть
сообщение “Hello, world!

## Виды атак

Некоторые из них:

1. CSRF (межсайтовая подделка запроса): Это атака, при которой
злоумышленник заставляет жертву выполнить нежелательные функции на
веб-сайте, в котором они аутентифицированы. Spring Security предотвращает
атаки CSRF, используя синхронный маркер, который проверяется с каждым
запросом на изменение состояния.

2. XSS (межсайтовый скриптинг): Это атака, при которой злоумышленник
вставляет злонамеренный скрипт в веб-страницу, который затем
выполняется в браузере жертвы. Хотя защита от XSS обычно включает
эскейпинг и проверку входных данных на стороне сервера и клиента, Spring
Security предоставляет дополнительные заголовки безопасности, которые
помогают защитить от определенных видов атак XSS.

3. SQL-инъекции: Это атака, при которой злоумышленник вставляет
злонамеренные SQL-запросы в ввод пользователя, который затем
выполняется в базе данных. В то время как защита от SQL-инъекций в
основном связана с валидацией входных данных и использованием
параметризованных запросов или ORM, Spring Security также помогает
уменьшить риск, обеспечивая хорошие практики аутентификации и
авторизации.

4. Атаки с перехватом сессии (Session Hijacking): Злоумышленник может
попытаться перехватить сессию пользователя и использовать ее для доступа
к системе. Spring Security предоставляет механизмы для управления и
защиты сессий, включая защиту от фиксации сессии и механизмы для
автоматического выхода из системы.

## Обработка HTTP-запроса 

Внутренняя обработка запроса в Spring Security строится на цепочке сервлет-фильтров, которые перехватывают каждый входящий HTTP-запрос ещё до того, как он попадёт в DispatcherServlet и ваши контроллеры.
Ниже — пошаговый разбор архитектуры и жизненного цикла одного HTTP-запроса внутри этой системы.

1. Схема прохождения запроса (Архитектура моста)

Поскольку контейнер сервлетов (Tomcat) не знает о контексте Spring, взаимодействие происходит через три уровня:
1. Контейнер сервлетов (Tomcat): Принимает запрос и запускает стандартную цепочку FilterChain (кодировка, CORS и т.д.).
2. DelegatingFilterProxy: Обычный сервлет-фильтр, зарегистрированный в контейнере под именем springSecurityFilterChain. Он ничего не проверяет сам, а находит в ApplicationContext бин FilterChainProxy и передаёт запрос ему.
3. FilterChainProxy (ядро Spring Security): Специальный бин, который содержит внутри себя одну или несколько цепочек SecurityFilterChain.
	• Он проверяет URL запроса (например, /api/** или /admin/**) и выбирает первую подходящую SecurityFilterChain (соответствующую вашему бину @Bean public SecurityFilterChain filterChain(HttpSecurity http)).
	• По очереди прогоняет запрос через все внутренние фильтры безопасности выбранной цепочки.

2. Порядок ключевых фильтров внутри SecurityFilterChain

Внутри SecurityFilterChain фильтры всегда выстроены в строгом порядке. В стандартной конфигурации веб-приложения запрос проходит через следующие основные этапы:
1. SecurityContextHolderFilter (ранее SecurityContextPersistenceFilter):
	• Читает данные о текущем пользователе из хранилища (например, из HttpSession) и помещает объект SecurityContext (с объектом Authentication) в SecurityContextHolder (обычно привязанный к текущему потоку через ThreadLocal).
	• На обратном пути (после выполнения контроллера) сохраняет изменения контекста и очищает ThreadLocal, чтобы данные не утекли в другой запрос.
2. HeaderWriterFilter:
	• Добавляет в HTTP-ответ защитные заголовки (X-Frame-Options, X-Content-Type-Options, Cache-Control и др.).
3. CsrfFilter:
	• Для небезопасных методов (POST, PUT, DELETE) проверяет наличие и валидность CSRF-токена (если защита не отключена через .csrf(AbstractHttpConfigurer::disable)).
4. LogoutFilter:
	• Проверяет, не является ли запрос выходом из системы (по умолчанию POST /logout). Если да — завершает сессию, очищает SecurityContextHolder и делает редирект.
5. Фильтры аутентификации (срабатывают только при попытке входа или наличии токена):
	• UsernamePasswordAuthenticationFilter — перехватывает отправку формы логина (POST /login), извлекает логин/пароль и запускает процесс аутентификации.
	• BasicAuthenticationFilter — проверяет заголовок Authorization: Basic ....
	• Кастомные фильтры (например, JwtAuthenticationFilter) — обычно встраиваются именно на этом уровне (addFilterBefore), чтобы проверить JWT-токен и заполнить SecurityContextHolder.
6. AnonymousAuthenticationFilter:
	• Если ни один из предыдущих фильтров не установил пользователя в SecurityContextHolder, этот фильтр создаёт специальный объект AnonymousAuthenticationToken (с ролью ROLE_ANONYMOUS), чтобы в системе никогда не было null вместо объекта аутентификации.
7. ExceptionTranslationFilter (критически важный перехватчик):
	• Оборачивает вызов следующих фильтров в блок try-catch и перехватывает два типа исключений:
		• AuthenticationException (пользователь не вошёл в систему) → вызывает AuthenticationEntryPoint (редиректит на страницу /login или возвращает статус 401 Unauthorized).
		• AccessDeniedException (пользователь вошёл, но не хватает прав) → вызывает AccessDeniedHandler (возвращает ошибку 403 Forbidden).
8. AuthorizationFilter (ранее FilterSecurityInterceptor):
	• Последний фильтр в цепочке. Берёт текущего пользователя из SecurityContextHolder, сверяет его роли/права (Authorities) с правилами из конфигурации (requestMatchers("/admin/**").hasRole("ADMIN")) и решает:
		• Разрешить: передаёт управление дальше в DispatcherServlet → контроллер.
		• Запретить: выбрасывает AccessDeniedException, который тут же ловит ExceptionTranslationFilter (пункт 7).

3. Как работает сам процесс аутентификации (когда пользователь логинится)

Когда срабатывает фильтр аутентификации (например, UsernamePasswordAuthenticationFilter), внутри запускается отдельная цепочка компонентов:
1. Фильтр создаёт неаутентифицированный объект UsernamePasswordAuthenticationToken (только логин и пароль) и передаёт его в AuthenticationManager (стандартная реализация — ProviderManager).
2. ProviderManager перебирает зарегистрированные AuthenticationProvider (например, DaoAuthenticationProvider).
3. DaoAuthenticationProvider:
	• Вызывает ваш сервис UserDetailsService.loadUserByUsername(username), чтобы загрузить пользователя и его хеш пароля из БД.
	• Сверяет введённый пароль с хешем через PasswordEncoder (например, BCryptPasswordEncoder).
4. При успехе возвращается заполненный объект Authentication (с флагом authenticated = true и списком прав GrantedAuthority), который фильтр сохраняет в SecurityContextHolder.
Какой аспект работы цепочки вам интереснее разобрать дальше:
• Как правильно встроить кастомный фильтр (например, для JWT-аутентификации) через addFilterBefore / addFilterAfter
• Как настроить несколько независимых SecurityFilterChain (например, одну для REST API с JWT, другую — для админки с формой логина и сессиями)
• Как работает обработка ошибок 401 и 403 (AuthenticationEntryPoint и AccessDeniedHandler)


## Практика

Подключаем в spring.initializir `Spring Security`

### Добавление зависимости для JWT

```java
<dependency>
<groupId>io.jsonwebtoken</groupId>
<artifactId>jjwt</artifactId>
<version>0.9.1</version>
</dependency>
```

### Создание класса конфигурации безопасности

Теперь мы можем добавить наши правила безопасности в класс `SecurityConfig`. Это
делается путем переопределения метода `configure` и указания настроек
безопасности с помощью `HttpSecurity` объекта:

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
	http.csrf()
	.disable() // Отключаем защиту CSRF, так как будем использовать	JWT
	.authorizeRequests()
	.antMatchers("/login")
	.permitAll() 	// Позволяем всем пользователям	доступ к эндпоинту "/login"
	.anyRequest()
	.authenticated() // Все остальные эндпоинты требуют	аутентификации
	.and()
	.addFilter(new JwtAuthenticationFilter(authenticationManager())) 
	// Добавляем наш фильтр аутентификации
	.sessionManagement()
	.sessionCreationPolicy(SessionCreationPolicy.STATELESS); 
	// Не	создаем сессию, так как будем использовать JWT
	}

}
```

### Создание фильтра аутентификации

Как видно из предыдущего шага, мы добавляем фильтр `JwtAuthenticationFilter` в
конвейер безопасности. Этот фильтр будет обрабатывать запросы на эндпоинт
“/login” и создавать JWT для аутентифицированных пользователей.

В этом классе нам нужно переопределить метод `attemptAuthentication` для
обработки учетных данных пользователя и метод `successfulAuthentication` для
создания JWT после успешной аутентификации.

```java
public class JwtAuthenticationFilter 
             extends UsernamePasswordAuthenticationFilter {

	@Override
	protected void successfulAuthentication(HttpServletRequest request,
	               HttpServletResponse response,
	               FilterChain chain,
	               Authentication authResult)	throws IOException, ServletException {
	
		UserDetails principal = (UserDetails) authResult.getPrincipal();

		String token = Jwts.builder()
		                   .setSubject(principal
		                   .getUsername())
		                   .setExpiration(new Date(System.currentTimeMillis() +
		                                         JwtProperties.EXPIRATION_TIME)) 
		                                   // Устанавливаем срок действия токена
		                   .signWith(SignatureAlgorithm.HS512, JwtProperties.SECRET) 
		                   // Подписываем токен нашим серверным секретом
                   		.compact();

		response.addHeader(JwtProperties.HEADER_STRING,
		                   JwtProperties.TOKEN_PREFIX + token); 
		                   // Добавляем токен в заголовок ответа
	}

}
```

`JwtProperties` - это просто класс, содержащий константы, связанные с JWT, такие
как строка заголовка (“Authorization”), префикс токена (“Bearer”), секрет и время
истечения токена.

### Проверка JWT

Теперь, когда у нас есть JWT, мы можем использовать его для аутентификации
пользователей в последующих запросах. Для этого нам нужно создать еще один
фильтр, который будет проверять JWT в заголовках запросов.

В методе `doFilterInternal` нам нужно извлечь JWT из заголовка, проверить его и
установить аутентификацию для текущего контекста безопасности, если токен
действителен.

```java
public class JwtAuthorizationFilter extends BasicAuthenticationFilter {

	public void JwtAuthorizationFilter(AuthenticationManager	authenticationManager) {
		super(authenticationManager);
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request,
	                                HttpServletResponse response,
	                                FilterChain chain) throws	
	                                IOException, ServletException {

	// Здесь будет код для проверки JWT
	}
}
```

После создания `JwtAuthorizationFilter` нам нужно добавить его в нашу конфигурацию
безопасности. Это делается путем добавления фильтра перед фильтром `UsernamePasswordAuthenticationFilter` в нашем классе `SecurityConfig`