package vsu.csf.rentyserver.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.core.Authentication;
import vsu.csf.rentyserver.model.dto.error.ApiErrorResponse;
import vsu.csf.rentyserver.model.dto.rent.request.*;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;

import java.util.List;

@Tag(name = "Операции с арендами")
public interface IRentController {

    @Operation(summary = "Получить список своих аренд")
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<RentResponse> getMy(
            @Parameter(
                    name = "status_filter",
                    description = "Фильтр статуса аренд",
                    schema = @Schema(implementation = RentStatusFilter.class)
            ) RentStatusFilter filter,
            Authentication authentication);

    @Operation(summary = "Получить свою аренду по идентификатору аренды",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    RentResponse getMyRentById(@Parameter(name = "rent_id", description = "Идентификатор аренды") Long rentId,
                               Authentication authentication);

    @Operation(summary = "Начать аренду",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку"),
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Аренда начата")
    @SecurityRequirement(name = "JWT")
    RentResponse start(@RequestBody(description = "Данные аренды") CreateRentRequest request,
                       Authentication authentication);

    @Operation(summary = "Начать несколько аренд",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку"),
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Аренды начаты")
    @SecurityRequirement(name = "JWT")
    List<RentResponse> start(@RequestBody(description = "Данные аренд") CreateRentsBatchRequest request,
                             Authentication authentication);

    @Operation(summary = "Продлить аренду",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку"),
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Аренда продлена")
    @SecurityRequirement(name = "JWT")
    RentResponse prolong(@Parameter(name = "rent_id", description = "Идентификатор аренды") Long rentId,
                         @RequestBody(description = "Новое время завершения") ProlongRentRequest request,
                         Authentication authentication);

    @Operation(summary = "Получить аренды по идентификатору пользователя",
            responses = {
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<RentResponse> get(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                           @Parameter(
                                   name = "status_filter",
                                   description = "Фильтр статуса аренд",
                                   schema = @Schema(implementation = RentStatusFilter.class)
                           ) RentStatusFilter filter,
                           Authentication authentication);

    @Operation(summary = "Получить аренду по идентификатору пользователя и идентификатору аренды",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    RentResponse getById(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                         @Parameter(name = "rent_id", description = "Идентификатор аренды") Long rentId,
                         Authentication authentication);

    @Operation(summary = "Завершить аренду",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Аренда завершена")
    @SecurityRequirement(name = "JWT")
    RentResponse finish(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                        @Parameter(name = "rent_id", description = "Идентификатор аренды") Long rentId,
                        Authentication authentication);

    @Operation(summary = "Завершить несколько аренд",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Аренды завершены")
    @SecurityRequirement(name = "JWT")
    List<RentResponse> finish(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                              @RequestBody(description = "Идентификаторы аренд") FinishRentsBatchRequest request,
                              Authentication authentication);

}
