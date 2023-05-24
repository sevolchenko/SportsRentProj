package vsu.csf.rentyserver.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.exception.DuplicateElementException;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateCategoryRequest;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateProductRequest;
import vsu.csf.rentyserver.model.dto.catalog.request.CreateSizeRequest;
import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductPreviewResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;
import vsu.csf.rentyserver.model.entity.Category;
import vsu.csf.rentyserver.model.entity.Image;
import vsu.csf.rentyserver.model.entity.Product;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.id.ImageId;
import vsu.csf.rentyserver.model.entity.id.SizeId;
import vsu.csf.rentyserver.model.mapping.CategoryMapper;
import vsu.csf.rentyserver.model.mapping.ProductMapper;
import vsu.csf.rentyserver.model.mapping.SizeMapper;
import vsu.csf.rentyserver.repository.CategoriesRepository;
import vsu.csf.rentyserver.repository.ProductsRepository;
import vsu.csf.rentyserver.repository.SizesRepository;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class CatalogService {

    private final ProductsRepository productsRepository;
    private final CategoriesRepository categoriesRepository;
    private final SizesRepository sizesRepository;

    private final ProductMapper productMapper;
    private final SizeMapper sizeMapper;
    private final CategoryMapper categoryMapper;

    @Transactional(readOnly = true)
    public List<ProductResponse> listAllProducts() {
        log.info("List all products called");

        var products = productsRepository.findAll();

        return productMapper.map(products);
    }

    @Transactional(readOnly = true)
    public ProductResponse findProductById(Long productId) {
        log.info("Find product by id {} called", productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        return productMapper.map(product);
    }

    public ProductResponse createProduct(CreateProductRequest request) {
        log.info("Create product {} called", request);

        var category = categoriesRepository.findById(request.categoryId())
                .orElseThrow(() -> new NoSuchElementException("category", Category.class, request.categoryId()));

        var product = new Product();

        product.setName(request.name())
                .setDescription(request.description())
                .setPrice(request.price())
                .setCategory(category)
                .setImages(request.images().stream()
                        .map((img) -> new Image()
                                .setImageId(new ImageId()
                                        .setProduct(product)
                                        .setPosition(img.position()))
                                .setImgBytes(img.imgBytes()))
                        .toList());

        var saved = productsRepository.save(product);

        return productMapper.map(saved);
    }

    public ProductResponse deleteProductById(Long productId) {
        log.info("Delete product by id {} called", productId);

        var deleted = productsRepository.removeProductByProductIdEquals(productId);

        if (deleted.isEmpty()) {
            throw new NoSuchElementException("product", Product.class, productId);
        }

        return productMapper.map(deleted.get(0));
    }


    @Transactional(readOnly = true)
    public List<ProductPreviewResponse> listAllProductsPreviews() {
        log.info("List all products projections called");

        var products = productsRepository.findAll();

        return productMapper.mapToPreview(products);
    }

    @Transactional(readOnly = true)
    public ProductPreviewResponse findProductPreviewById(Long productId) {
        log.info("Find product projection by id {} called", productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        return productMapper.mapToPreview(product);
    }


    @Transactional(readOnly = true)
    public List<SizeResponse> findSizes(Long productId) {
        log.info("Find product sizes by id {} called", productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        return sizeMapper.map(product.getSizes());
    }

    public SizeResponse addSizeToProduct(Long productId, CreateSizeRequest request) {
        log.info("Add size {} to product id {} called", request, productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        var sizeId = new SizeId()
                .setProduct(product)
                .setName(request.sizeName());

        if (sizesRepository.existsById(sizeId)) {
            throw new DuplicateElementException("size", Size.class, sizeId);
        }

        var size = new Size()
                .setSizeId(sizeId)
                .setTotal(request.total());

        var saved = sizesRepository.save(size);

        return sizeMapper.map(saved);
    }

    public SizeResponse setSizeForProduct(Long productId, CreateSizeRequest request) {
        log.info("Set size {} to product id {} called", request, productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        var sizeId = new SizeId()
                .setProduct(product)
                .setName(request.sizeName());

        var size = sizesRepository.findById(sizeId)
                .orElseThrow(() -> new NoSuchElementException("size", Size.class, sizeId));

        size.setTotal(request.total());

        var saved = sizesRepository.save(size);

        return sizeMapper.map(saved);
    }

    public SizeResponse deleteSizeForProduct(Long productId, String sizeName) {
        log.info("Delete size {} to product id {} called", sizeName, productId);

        var product = productsRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("product", Product.class, productId));

        var sizeId = new SizeId()
                .setProduct(product)
                .setName(sizeName);

        var deleted = sizesRepository.removeSizeBySizeIdEquals(sizeId);

        if (deleted.isEmpty()) {
            throw new NoSuchElementException("size", Size.class, sizeId);
        }

        return sizeMapper.map(deleted.get(0));
    }


    @Transactional(readOnly = true)
    public List<CategoryResponse> listAllCategories() {
        log.info("List all categories called");

        var categories = categoriesRepository.findAll();

        return categoryMapper.map(categories);
    }

    @Transactional(readOnly = true)
    public CategoryResponse findCategoryById(Long categoryId) {
        log.info("Find category by id {} called", categoryId);

        var category = categoriesRepository.findById(categoryId)
                .orElseThrow(() -> new NoSuchElementException("category", Category.class, categoryId));

        return categoryMapper.map(category);
    }

    public CategoryResponse createCategory(CreateCategoryRequest request) {
        log.info("Create category {} called", request);

        var parentCategory = categoriesRepository.findById(request.parentCategoryId())
                .orElseThrow(() -> new NoSuchElementException("parentCategory", Category.class, request.parentCategoryId()));

        var duplicateCategory = categoriesRepository.findByName(request.name());
        if (duplicateCategory != null) {
            throw new DuplicateElementException("category", Category.class, duplicateCategory.getCategoryId());
        }
        var category = new Category()
                .setParentCategory(parentCategory)
                .setName(request.name());

        var saved = categoriesRepository.save(category);

        return categoryMapper.map(saved);
    }

    public CategoryResponse deleteCategoryById(Long categoryId) {
        log.info("Delete category by id {} called", categoryId);

        var deleted = categoriesRepository.removeCategoryByCategoryIdEquals(categoryId);

        if (deleted.isEmpty()) {
            throw new NoSuchElementException("category", Category.class, categoryId);
        }

        return categoryMapper.map(deleted.get(0));
    }

}
