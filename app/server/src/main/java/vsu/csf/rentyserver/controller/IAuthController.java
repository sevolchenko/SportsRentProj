package vsu.csf.rentyserver.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vsu.csf.rentyserver.model.dto.auth.response.LoginResponse;
import vsu.csf.rentyserver.model.dto.error.ApiErrorResponse;
import vsu.csf.rentyserver.model.dto.user.request.LoginRequest;

@Tag(name = "Аутентификация пользователей")
public interface IAuthController {

    @Operation(summary = "Войти в систему",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "401", description = "Неверные учетные данные пользователя"
                    )
            })
    @ApiResponse(responseCode = "200")
    LoginResponse login(@RequestBody(description = "Электронная почта и пароль пользователя")
                        LoginRequest loginRequest);

    @Operation(summary = "Выйти из системы")
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    void logout(HttpServletRequest request, HttpServletResponse response);

}
