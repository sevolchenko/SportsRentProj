package vsu.csf.rentyserver.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.data.domain.Sort;
import vsu.csf.rentyserver.model.dto.catalog.request.*;
import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductPreviewResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;
import vsu.csf.rentyserver.model.dto.error.ApiErrorResponse;

import java.util.List;

@Tag(name = "Операции с каталогом товаров")
public interface ICatalogController {

    @Operation(summary = "Получить список всех товаров")
    @ApiResponse(responseCode = "200")
    List<ProductResponse> listAllProducts(
            @Parameter(
                    name = "sort_by",
                    description = "Вариант сортировки",
                    schema = @Schema(implementation = ProductsSorting.class)
            ) ProductsSorting sorting,
            @Parameter(
                    name = "sort_direction",
                    description = "Направление сортировки (по возрастанию / убыванию)",
                    schema = @Schema(implementation = Sort.Direction.class)
            ) Sort.Direction direction,
            @Parameter(
                    name = "search",
                    description = "Поисковой запрос по имени товара"
            ) String search,
            @Parameter(
                    name = "category_filter",
                    description = "Фильтр по родительской категории"
            ) Long categoryId,
            @Parameter(
                    name = "price_min_filter",
                    description = "Фильтр по минимальной цене"
            ) Integer minPrice,
            @Parameter(
                    name = "price_max_filter",
                    description = "Фильтр по максимальной цене"
            ) Integer maxPrice);

    @Operation(summary = "Создать товар",
            responses = {
                    @ApiResponse(
                            responseCode = "409", description = "Данные не прошли проверку"
                    ),
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
    @ApiResponse(responseCode = "200", description = "Товар создан")
    @SecurityRequirement(name = "JWT")
    ProductResponse createProduct(@RequestBody(description = "Данные товара") CreateProductRequest request);

    @Operation(summary = "Получить товар по идентификатору",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    )
            })
    @ApiResponse(responseCode = "200")
    ProductResponse findOneProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId);


    @Operation(summary = "Удалить товар по идентификатору",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Товар удален")
    @SecurityRequirement(name = "JWT")
    ProductResponse deleteOneProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId);

    @Operation(summary = "Получить превью всех товаров")
    @ApiResponse(responseCode = "200")
    List<ProductPreviewResponse> listAllPreviews(
            @Parameter(
                    name = "sort_by",
                    description = "Вариант сортировки",
                    schema = @Schema(implementation = ProductsSorting.class)
            ) ProductsSorting sorting,
            @Parameter(
                    name = "sort_direction",
                    description = "Направление сортировки (по возрастанию / убыванию)",
                    schema = @Schema(implementation = Sort.Direction.class)
            ) Sort.Direction direction,
            @Parameter(
                    name = "search",
                    description = "Поисковой запрос по имени товара"
            ) String search,
            @Parameter(
                    name = "category_filter",
                    description = "Фильтр по родительской категории"
            ) Long categoryId,
            @Parameter(
                    name = "price_min_filter",
                    description = "Фильтр по минимальной цене"
            ) Integer minPrice,
            @Parameter(
                    name = "price_max_filter",
                    description = "Фильтр по максимальной цене"
            ) Integer maxPrice);

    @Operation(summary = "Получить превью товара по идентификатору товара",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Товар удален")
    ProductPreviewResponse findOnePreview(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId);

    @Operation(summary = "Получить размеры товара по идентификатору товара",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    )
            })
    @ApiResponse(responseCode = "200")
    List<SizeResponse> findSizesForProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId);

    @Operation(summary = "Добавить размер товара",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку"
                    ),
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @SecurityRequirement(name = "JWT")
    SizeResponse createSizeForProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId,
                                      @RequestBody(description = "Данные размера") CreateSizeRequest request);

    @Operation(summary = "Изменить количество имеющихся размеров товара",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "409", description = "Данные не прошли проверку"
                    ),
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @SecurityRequirement(name = "JWT")
    SizeResponse changeTotalForProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId,
                                       @RequestBody(description = "Новые данные размера") CreateSizeRequest request);

    @Operation(summary = "Удалить размер товара",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Сущность не найдена"
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200")
    @SecurityRequirement(name = "JWT")
    SizeResponse deleteTotalForProduct(@Parameter(name = "product_id", description = "Идентификатор товара") Long productId,
                                       @RequestBody(description = "Данные размера") DeleteSizeRequest request);

    @Operation(summary = "Получить список всех категорий")
    @ApiResponse(responseCode = "200")
    List<CategoryResponse> getAllCategories();

    @Operation(summary = "Получить категорию по идентификатору")
    CategoryResponse getCategoryById(@Parameter(name = "category_id", description = "Идентификатор категории") Long categoryId);

    @Operation(summary = "Создать категорию",
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
                    ),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Категория создана")
    @SecurityRequirement(name = "JWT")
    CategoryResponse createCategory(CreateCategoryRequest request);

    @Operation(summary = "Удалить категорию",
            responses = {
                    @ApiResponse(
                            content = {
                                    @Content(schema = @Schema(implementation = ApiErrorResponse.class))
                            },
                            responseCode = "404", description = "Ссылка на несуществующую сущность"),
                    @ApiResponse(
                            responseCode = "403", description = "Недостаточно прав для совершения операции"
                    )
            })
    @ApiResponse(responseCode = "200", description = "Категория удалена")
    @SecurityRequirement(name = "JWT")
    CategoryResponse deleteCategory(@Parameter(name = "category_id", description = "Идентификатор категории") Long categoryId);

}
