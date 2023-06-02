package vsu.csf.rentyserver.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.core.Authentication;
import vsu.csf.rentyserver.model.dto.error.ApiErrorResponse;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;

import java.util.List;
import java.util.UUID;

@Tag(name = "Операции с чеками")
public interface IReceiptController {

    @Operation(summary = "Получить список своих чеков")
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<ReceiptResponse> getMy(Authentication authentication);

    @Operation(summary = "Получить список своих неоплаченных чеков")
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<ReceiptResponse> getMyUnpaid(Authentication authentication);

    @Operation(summary = "Получить свой чек по идентификатору чека",
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
    ReceiptResponse getMyByReceiptId(@Parameter(name = "receipt_it", description = "Идентификатор чека") UUID receiptId,
                                     Authentication authentication);

    @Operation(summary = "Получить чеки по идентификатору пользователя",
            responses = {
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<ReceiptResponse> getByUserId(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                                      Authentication authentication);

    @Operation(summary = "Получить неоплаченные чеки по идентификатору пользователя",
            responses = {
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    List<ReceiptResponse> getByUserIdUnpaid(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                                            Authentication authentication);


    @Operation(summary = "Получить неоплаченные чеки по идентификатору пользователя",
            responses = {
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    ReceiptResponse getReceiptByUserIdAndReceiptId(@Parameter(name = "user_id", description = "Идентификатор пользователя") Long userId,
                                                   @Parameter(name = "receipt_it", description = "Идентификатор чека") UUID receiptId,
                                                   Authentication authentication);

    @Operation(summary = "Оплатить чек по идентификатору",
            responses = {
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    ReceiptResponse performPay(@Parameter(name = "receipt_it", description = "Идентификатор чека") UUID receiptId,
                               Authentication authentication);

}
