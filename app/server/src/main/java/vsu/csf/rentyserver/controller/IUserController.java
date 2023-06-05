package vsu.csf.rentyserver.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.core.Authentication;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.dto.error.ApiErrorResponse;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;

@Tag(name = "Операции с пользователями")
public interface IUserController {

    @Operation(summary = "Зарегистрироваться в системе",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку")
            })
    @ApiResponse(responseCode = "200")
    void register(RegisterRequest request);

    @Operation(summary = "Получить свои данные")
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    UserResponse findMe(Authentication authentication);

    @Operation(summary = "Получить данные пользователя по email",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Пользователь не найден"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    UserResponse findByEmail(@Parameter(name = "email", description = "Email пользователя") String email,
                             Authentication authentication);

}
