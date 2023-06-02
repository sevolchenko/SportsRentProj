package vsu.csf.rentyserver.configuration;

import io.swagger.v3.oas.annotations.ExternalDocumentation;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import org.springframework.context.annotation.Configuration;

@OpenAPIDefinition(
        info = @Info(title = "Renty API",
                description = "API взаимодействия с сервером приложения проката спортивного инвентаря Renty",
                contact = @Contact(name = "Sergey Volchenko",
                        email = "se.volchenko@ya.ru")),
        externalDocs = @ExternalDocumentation(description = "GitHub репозиторий проекта",
                url = "https://github.com/sevolchenko/renty")
)
@SecurityScheme(
        name = "JWT",
        description = """
                Чтобы получить токен, воспользуйтесь /auth/login
                Используйте данные { "email": "se.volchenko@ya.ru", "password": "sergey" }
                
                """,
        type = SecuritySchemeType.HTTP,
        bearerFormat = "JWT",
        scheme = "bearer",
        paramName = "Authorization"
)
@Configuration
public class OpenApiConfig {
}
