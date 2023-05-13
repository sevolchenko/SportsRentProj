package vsu.csf.rentyserver.service;

import jakarta.persistence.NoResultException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

@Service
@Transactional
@RequiredArgsConstructor
public class CatalogService {

    private final ProductsRepository productsRepository;
    private final CategoriesRepository categoriesRepository;

    private final ProductMapper productMapper;
    private final SizeMapper sizeMapper;
    private final CategoryMapper categoryMapper;

    @Transactional(readOnly = true)
    public ProductListResponse listAllProducts() {

        var products = productsRepository.findAll();

        return productMapper.fromList(products);
    }

    @Transactional(readOnly = true)
    public ProductResponse findProductById(Long productId) {

        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        return productMapper.map(product);
    }

    public ProductResponse createProduct(CreateProductRequest request) {

        var category = categoriesRepository.findById(request.categoryId())
                .orElseThrow(IllegalArgumentException::new);

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

        var deleted = productsRepository.removeProductByProductIdEquals(productId);

        if (deleted.isEmpty()) {
            throw new NoResultException();
        }

        return productMapper.map(deleted.get(0));
    }


    @Transactional(readOnly = true)
    public ProductProjectionListResponse listAllProjections() {

        var products = productsRepository.findAll();

        return productMapper.fromListToProjection(products);
    }

    @Transactional(readOnly = true)
    public ProductProjectionResponse findProjectionById(Long productId) {

        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        return productMapper.mapToProjection(product);
    }


    @Transactional(readOnly = true)
    public SizeListResponse findSizes(Long productId) {
        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        return sizeMapper.fromList(product.getSizes());
    }

    public SizeResponse addSizeToProduct(Long productId, CreateSizeRequest request) {
        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        var size = new Size()
                .setSizeId(new SizeId()
                        .setProduct(product)
                        .setName(request.sizeName()))
                .setTotal(request.total());

        product.getSizes().add(size);

        return sizeMapper.map(size);
    }

    public SizeResponse setSizeForProduct(Long productId, CreateSizeRequest request) {
        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        var sizeId = new SizeId()
                .setProduct(product)
                .setName(request.sizeName());

        var size = product.getSizes().stream()
                .filter((sz) -> sizeId.equals(sz.getSizeId()))
                .findFirst().orElseThrow(NoResultException::new)
                .setTotal(request.total());

        return sizeMapper.map(size);
    }

    public SizeResponse deleteSizeForProduct(Long productId, String sizeName) {
        var product = productsRepository.findById(productId)
                .orElseThrow(NoResultException::new);

        var sizeId = new SizeId()
                .setProduct(product)
                .setName(sizeName);

        var size = product.getSizes().stream()
                .filter((sz) -> sizeId.equals(sz.getSizeId()))
                .findFirst().orElseThrow(NoResultException::new);

        product.getSizes().remove(size);

        return sizeMapper.map(size);
    }


    @Transactional(readOnly = true)
    public CategoryListResponse listAllCategories() {

        var categories = categoriesRepository.findAll();

        return categoryMapper.fromList(categories);
    }

    @Transactional(readOnly = true)
    public CategoryResponse findCategoryById(Long categoryId) {

        var category = categoriesRepository.findById(categoryId)
                .orElseThrow(NoResultException::new);

        return categoryMapper.map(category);
    }

    public CategoryResponse createCategory(CreateCategoryRequest request) {

        var parentCategory = categoriesRepository.findById(request.parentCategoryId())
                .orElseThrow(NoResultException::new);

        var category = new Category()
                .setParentCategory(parentCategory)
                .setName(request.name());

        var saved = categoriesRepository.save(category);

        return categoryMapper.map(saved);
    }

    public CategoryResponse deleteCategoryById(Long categoryId) {

        var deleted = categoriesRepository.removeCategoryByCategoryIdEquals(categoryId);

        if (deleted.isEmpty()) {
            throw new NoResultException();
        }

        return categoryMapper.map(deleted.get(0));
    }

}
