package vsu.csf.rentyserver.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.model.dto.request.CreateCategoryRequest;
import vsu.csf.rentyserver.model.dto.request.CreateProductRequest;
import vsu.csf.rentyserver.model.dto.request.CreateSizeRequest;
import vsu.csf.rentyserver.model.dto.response.CategoryResponse;
import vsu.csf.rentyserver.model.dto.response.ProductProjectionResponse;
import vsu.csf.rentyserver.model.dto.response.ProductResponse;
import vsu.csf.rentyserver.model.dto.response.SizeResponse;
import vsu.csf.rentyserver.model.dto.response.list.CategoryListResponse;
import vsu.csf.rentyserver.model.dto.response.list.ProductListResponse;
import vsu.csf.rentyserver.model.dto.response.list.ProductProjectionListResponse;
import vsu.csf.rentyserver.model.dto.response.list.SizeListResponse;
import vsu.csf.rentyserver.service.CatalogService;

@RestController
@RequestMapping("/catalog")
@RequiredArgsConstructor
public class CatalogController {

    private final CatalogService catalogService;

    @GetMapping("/products")
    ProductListResponse listAllProducts() {
        return catalogService.listAllProducts();
    }

    @PostMapping("/products")
    ProductResponse createProduct(@RequestBody CreateProductRequest request) {
        return catalogService.createProduct(request);
    }

    @GetMapping("/products/{product_id}")
    ProductResponse findOneProduct(@PathVariable("product_id") Long productId) {
        return catalogService.findProductById(productId);
    }

    @DeleteMapping("/products/{product_id}")
    ProductResponse deleteOneProduct(@PathVariable("product_id") Long productId) {
        return catalogService.deleteProductById(productId);
    }


    @GetMapping("/products/projections")
    ProductProjectionListResponse listAllProjections() {
        return catalogService.listAllProjections();
    }

    @GetMapping("/products/projections/{product_id}")
    ProductProjectionResponse findOneProjection(@PathVariable("product_id") Long productId) {
        return catalogService.findProjectionById(productId);
    }


    // TODO: 12.05.2023 "at_time"
    @GetMapping("/products/{product_id}/sizes")
    SizeListResponse findSizesForProduct(@PathVariable("product_id") Long productId) {
        return catalogService.findSizes(productId);
    }

    @PostMapping("/products/{product_id}/sizes")
    SizeResponse createSizeForProduct(@PathVariable("product_id") Long productId,
                                      @RequestBody CreateSizeRequest request) {
        return catalogService.addSizeToProduct(productId, request);
    }

    @PatchMapping("/products/{product_id}/sizes")
    SizeResponse changeTotalForProduct(@PathVariable("product_id") Long productId,
                                      @RequestBody CreateSizeRequest request) {
        return catalogService.setSizeForProduct(productId, request);
    }

    @DeleteMapping("/products/{product_id}/sizes")
    SizeResponse deleteTotalForProduct(@PathVariable("product_id") Long productId,
                                       @RequestBody String sizeName) {
        return catalogService.deleteSizeForProduct(productId, sizeName);
    }


    @GetMapping("/categories")
    CategoryListResponse getAllCategories() {
        return catalogService.listAllCategories();
    }

    @GetMapping("/categories/{category_id}")
    CategoryResponse getCategoryById(@PathVariable("category_id") Long categoryId) {
        return catalogService.findCategoryById(categoryId);
    }

    @PostMapping("/categories")
    CategoryResponse createCategory(@RequestBody CreateCategoryRequest request) {
        return catalogService.createCategory(request);
    }

    @DeleteMapping("/categories/{category_id}")
    CategoryResponse deleteCategory(@PathVariable("category_id") Long categoryId) {
        return catalogService.deleteCategoryById(categoryId);
    }

}
