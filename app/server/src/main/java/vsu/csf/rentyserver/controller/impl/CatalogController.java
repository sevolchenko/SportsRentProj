package vsu.csf.rentyserver.controller.impl;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.controller.ICatalogController;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateCategoryRequest;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateProductRequest;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateSizeRequest;
import vsu.csf.rentyserver.model.dto.catalog.request.DeleteSizeRequest;
import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductPreviewResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;
import vsu.csf.rentyserver.service.CatalogService;

import java.util.List;

@RestController
@RequestMapping("/catalog")
@RequiredArgsConstructor
public class CatalogController implements ICatalogController {

    private final CatalogService catalogService;

    @GetMapping("/products")
    public List<ProductResponse> listAllProducts() {
        return catalogService.listAllProducts();
    }

    @PostMapping("/products")
    public ProductResponse createProduct(@Valid @RequestBody CreateProductRequest request) {
        return catalogService.createProduct(request);
    }

    @GetMapping("/products/{product_id}")
    public ProductResponse findOneProduct(@PathVariable("product_id") Long productId) {
        return catalogService.findProductById(productId);
    }

    @DeleteMapping("/products/{product_id}")
    public ProductResponse deleteOneProduct(@PathVariable("product_id") Long productId) {
        return catalogService.deleteProductById(productId);
    }


    @GetMapping("/products/previews")
    public List<ProductPreviewResponse> listAllPreviews() {
        return catalogService.listAllProductsPreviews();
    }

    @GetMapping("/products/previews/{product_id}")
    public ProductPreviewResponse findOnePreview(@PathVariable("product_id") Long productId) {
        return catalogService.findProductPreviewById(productId);
    }


    // TODO: 12.05.2023 "at_time"
    @GetMapping("/products/{product_id}/sizes")
    public List<SizeResponse> findSizesForProduct(@PathVariable("product_id") Long productId) {
        return catalogService.findSizes(productId);
    }

    @PostMapping("/products/{product_id}/sizes")
    public SizeResponse createSizeForProduct(@PathVariable("product_id") Long productId,
                                      @Valid @RequestBody CreateSizeRequest request) {
        return catalogService.addSizeToProduct(productId, request);
    }

    @PatchMapping("/products/{product_id}/sizes")
    public SizeResponse changeTotalForProduct(@PathVariable("product_id") Long productId,
                                       @Valid @RequestBody CreateSizeRequest request) {
        return catalogService.setSizeForProduct(productId, request);
    }

    @DeleteMapping("/products/{product_id}/sizes")
    public SizeResponse deleteTotalForProduct(@PathVariable("product_id") Long productId,
                                       @RequestBody DeleteSizeRequest request) {
        return catalogService.deleteSizeForProduct(productId, request);
    }


    @GetMapping("/categories")
    public List<CategoryResponse> getAllCategories() {
        return catalogService.listAllCategories();
    }

    @GetMapping("/categories/{category_id}")
    public CategoryResponse getCategoryById(@PathVariable("category_id") Long categoryId) {
        return catalogService.findCategoryById(categoryId);
    }

    @PostMapping("/categories")
    public CategoryResponse createCategory(@Valid @RequestBody CreateCategoryRequest request) {
        return catalogService.createCategory(request);
    }

    @DeleteMapping("/categories/{category_id}")
    public CategoryResponse deleteCategory(@PathVariable("category_id") Long categoryId) {
        return catalogService.deleteCategoryById(categoryId);
    }

}
