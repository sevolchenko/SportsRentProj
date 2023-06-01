package vsu.csf.rentyserver.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.util.StreamUtils;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.IntegrationEnvironment;
import vsu.csf.rentyserver.exception.DuplicateElementException;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.catalog.request.*;
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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThrows;

@SpringBootTest
@ActiveProfiles("test")
@RunWith(SpringRunner.class)
public class CatalogServiceIT extends IntegrationEnvironment {

    @Autowired
    private CatalogService catalogService;
    @Autowired
    private ProductsRepository productsRepository;
    @Autowired
    private CategoriesRepository categoriesRepository;
    @Autowired
    private SizesRepository sizesRepository;

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private SizeMapper sizeMapper;
    @Autowired
    private CategoryMapper categoryMapper;

    // TODO: 13.05.2023
    // Нужно протестировать весь класс CatalogService.class
    // Тесты пишутся на каждый метод класса
    // Тест должен "прогонять" все возможные варианты выполнения метода
    // (нужно написать отдельные тесты на каждый вариант)
    // Каждый тест должен иметь аннотации @Transactional @Rollback @Test
    // Название теста: test*название_метода*with*начальные_условия*

    @Transactional
    @Rollback
    @Test
    public void testListAllProducts() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product1 = new Product()
                .setName("1")
                .setDescription("Desc")
                .setPrice(123)
                .setCategory(category);

        Product product2 = new Product()
                .setName("2")
                .setCategory(category);

        List<Product> expected = new ArrayList<>();
        expected.add(product1);
        expected.add(product2);

        productsRepository.saveAndFlush(product1);
        productsRepository.saveAndFlush(product2);

        // when
        var response = catalogService.listAllProducts();

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response.get(0).name(), is(equalTo(product1.getName())));
        assertThat(response.get(0).price(), is(equalTo(product1.getPrice())));
        assertThat(response.get(0).description(), is(equalTo(product1.getDescription())));

        var categoryResponse = response.get(0).category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(response, is(equalTo(productMapper.map(expected))));
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllProductsWithNoProducts() {
        // given

        // when
        var response = catalogService.listAllProducts();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response, is(empty()));
        assertThat(response.size(), is(equalTo(0)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindProductById() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findProductById(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.description(), is(equalTo(product.getDescription())));
        assertThat(response.price(), is(equalTo(product.getPrice())));
        assertThat(response, is(equalTo(productMapper.map(product))));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindProductByIdWithProductNotExists() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.findProductById(productId));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testDeleteProductById() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);
        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.deleteProductById(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.description(), is(equalTo(product.getDescription())));
        assertThat(response.price(), is(equalTo(product.getPrice())));
        assertThat(response, is(equalTo(productMapper.map(product))));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(productsRepository.findById(product.getProductId()), is(Optional.empty()));
    }

    @Transactional
    @Rollback
    @Test
    public void testDeleteProductByIdWithProductNotExists() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.deleteProductById(productId));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllPreviews() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product1 = new Product()
                .setName("1")
                .setDescription("Desc")
                .setPrice(123)
                .setCategory(category);

        product1.setImages(List.of(new Image()
                .setImageId(new ImageId().setProduct(product1).setPosition(1))
                .setImgBytes(new byte[]{1})));

        Product product2 = new Product()
                .setName("2")
                .setCategory(category);

        List<Product> expected = new ArrayList<>();
        expected.add(product1);
        expected.add(product2);

        productsRepository.saveAndFlush(product1);
        productsRepository.saveAndFlush(product2);

        // when
        var response = catalogService.listAllProductsPreviews();

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(expected.size())));
        StreamUtils.zip(response.stream(), productMapper.mapToPreview(expected).stream(),
                (res, prod) -> {
                    assertThat(res.productId(), is(equalTo(prod.productId())));
                    assertThat(res.name(), is(equalTo(prod.name())));
                    assertThat(res.price(), is(equalTo(prod.price())));
                    assertThat(res.busyNow(), is(equalTo(prod.busyNow())));
                    assertThat(res.category(), is(equalTo(prod.category())));
                    assertThat(res.mainImage().position(), is(equalTo(prod.mainImage().position())));
                    assertThat(res.mainImage().productId(), is(equalTo(prod.mainImage().productId())));
                    return null;
                });

        var PreviewResponse = response.get(0);

        assertThat(PreviewResponse.name(), is(equalTo(product1.getName())));
        assertThat(PreviewResponse.price(), is(equalTo(product1.getPrice())));

        var imageResponse = response.get(0).mainImage();
        assertThat(imageResponse.imgBytes(), is(equalTo(product1.getImages().get(0).getImgBytes())));
        assertThat(imageResponse.position(), is(equalTo(product1.getImages().get(0).getImageId().getPosition())));
        assertThat(imageResponse.productId(), is(equalTo(product1.getImages().get(0).getImageId().getProduct().getProductId())));

        var categoryResponse = response.get(0).category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllPreviewsWithNoProducts() {
        // given

        // when
        var response = catalogService.listAllProductsPreviews();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response, is(empty()));
        assertThat(response.size(), is(equalTo(0)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindPreviewById() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setImages(List.of(new Image()
                .setImageId(new ImageId().setProduct(product).setPosition(1))
                .setImgBytes(new byte[]{1})));

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findProductPreviewById(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));

        var proj = productMapper.mapToPreview(product);

        assertThat(response.productId(), is(equalTo(proj.productId())));
        assertThat(response.name(), is(equalTo(proj.name())));
        assertThat(response.price(), is(equalTo(proj.price())));
        assertThat(response.busyNow(), is(equalTo(proj.busyNow())));
        assertThat(response.category(), is(equalTo(proj.category())));
        assertThat(response.mainImage().position(), is(equalTo(proj.mainImage().position())));
        assertThat(response.mainImage().productId(), is(equalTo(proj.mainImage().productId())));


        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindPreviewByIdWithProductNotExists() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.findProductPreviewById(productId));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllCategories() {
        // given
        Category category1 = new Category()
                .setName("Category1");

        Category category2 = new Category()
                .setName("Category2")
                .setParentCategory(category1);

        List<Category> expected = new ArrayList<>();
        expected.add(category1);
        expected.add(category2);

        categoriesRepository.saveAndFlush(category1);
        categoriesRepository.saveAndFlush(category2);

        // when
        var response = catalogService.listAllCategories();

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response.get(0).name(), is(equalTo(category1.getName())));
        assertThat(response.get(1).name(), is(equalTo(category2.getName())));

        assertThat(response, is(equalTo(categoryMapper.map(expected))));
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllCategoriesWithNoCategories() {
        // given

        // when
        var response = catalogService.listAllCategories();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response, is(empty()));
        assertThat(response.size(), is(equalTo(0)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindCategoryById() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        // when
        var response = catalogService.findCategoryById(category.getCategoryId());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(response.name(), is(equalTo(category.getName())));
        assertThat(response, is(equalTo(categoryMapper.map(category))));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindCategoryByIdWithCategoryNotExists() {
        // given
        Long categoryId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.findCategoryById(categoryId));

        // then
        assertThat(ex.getVarName(), is(equalTo("category")));
        assertThat(ex.getClazz(), is(equalTo(Category.class)));
        assertThat(ex.getEntityId(), is(equalTo(categoryId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testDeleteCategoryById() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        // when
        var response = catalogService.deleteCategoryById(category.getCategoryId());

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(category.getName())));
        assertThat(response.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(response, is(equalTo(categoryMapper.map(category))));

        assertThat(categoriesRepository.findById(category.getCategoryId()), is(Optional.empty()));
    }

    @Transactional
    @Rollback
    @Test
    public void testDeleteCategoryByIdWithCategoryNotExists() {
        // given
        Long categoryId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.deleteCategoryById(categoryId));

        // then
        assertThat(ex.getVarName(), is(equalTo("category")));
        assertThat(ex.getClazz(), is(equalTo(Category.class)));
        assertThat(ex.getEntityId(), is(equalTo(categoryId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindSizesByProductId() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setSizes(List.of(new Size()
                .setSizeId(new SizeId().setProduct(product).setName("1"))
                .setTotal(1), new Size()
                .setSizeId(new SizeId().setProduct(product).setName("2"))
                .setTotal(1)));

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findSizes(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(product.getSizes().size())));
        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(product.getSizes().size())));
        assertThat(response.get(0).sizeName(), is(equalTo(product.getSizes().get(0).getSizeId().getName())));
        assertThat(response.get(0).total(), is(equalTo(product.getSizes().get(0).getTotal())));
        assertThat(response, is(equalTo(sizeMapper.map(product.getSizes()))));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindSizesByProductIdWithNoSizes() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findSizes(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.size(), is(equalTo(0)));
        assertThat(response, is(empty()));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindSizesByIdWithProductNotExists() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.findSizes(productId));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateCategory() {
        // given
        Category parentCategory = new Category()
                .setName("a");
        categoriesRepository.saveAndFlush(parentCategory);

        String name = "l";

        // when
        var response = catalogService.createCategory(new CreateCategoryRequest(parentCategory.getCategoryId(), name));

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(name)));

        assertThat(categoriesRepository.findById(response.categoryId()), is(not(Optional.empty())));

    }

    @Transactional
    @Rollback
    @Test
    public void testCreateCategoryWithParentCategoryNotExists() {
        // given
        Long parentCategoryId = 5L;
        String name = "l";

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.createCategory(new CreateCategoryRequest(parentCategoryId, name)));

        // then
        assertThat(ex.getVarName(), is(equalTo("parentCategory")));
        assertThat(ex.getClazz(), is(equalTo(Category.class)));
        assertThat(ex.getEntityId(), is(equalTo(parentCategoryId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateCategoryWithCategoryAlreadyExists() {
        // given
        Category parentCategory = new Category()
                .setName("parent category");
        categoriesRepository.saveAndFlush(parentCategory);
        Category category = new Category()
                .setName("category");
        categoriesRepository.saveAndFlush(category);

        // when
        var ex = assertThrows(DuplicateElementException.class, () ->
                catalogService.createCategory(new CreateCategoryRequest(parentCategory.getCategoryId(), category.getName())));

        // then
        assertThat(ex.getVarName(), is(equalTo("category")));
        assertThat(ex.getClazz(), is(equalTo(Category.class)));
        assertThat(ex.getEntityId(), is(equalTo(category.getCategoryId())));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateProduct() {
        // given
        Category category = new Category()
                .setName("a");
        categoriesRepository.saveAndFlush(category);

        String name = "a";
        String description = "b";
        Integer price = 1;

        // when
        var response = catalogService.createProduct(new CreateProductRequest(name, description, price, category.getCategoryId(),
                List.of(new CreateImageRequest(1, new byte[]{1}))));

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(name)));
        assertThat(response.description(), is(equalTo(description)));
        assertThat(response.price(), is(equalTo(price)));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(productsRepository.findById(response.productId()), is(not(Optional.empty())));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateProductWithCategoryNotExists() {
        // given
        Long categoryId = 5L;
        String name = "a";
        String description = "b";
        Integer price = 1;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.createProduct(new CreateProductRequest(name, description, price, categoryId,
                        List.of(new CreateImageRequest(1, new byte[]{1})))));

        // then
        assertThat(ex.getVarName(), is(equalTo("category")));
        assertThat(ex.getClazz(), is(equalTo(Category.class)));
        assertThat(ex.getEntityId(), is(equalTo(categoryId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testAddSizeToProduct() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        Size size1 = new Size()
                .setSizeId(new SizeId()
                        .setName("1")
                        .setProduct(product))
                .setTotal(1);

        Size size2 = new Size()
                .setSizeId(new SizeId()
                        .setName("2")
                        .setProduct(product))
                .setTotal(1);
        product.setSizes(List.of(size1, size2));

        productsRepository.saveAndFlush(product);

        String sizeName = "3";
        Integer total = 2;

        // when
        var response = catalogService.addSizeToProduct(product.getProductId(), new CreateSizeRequest(sizeName, total));
        sizesRepository.flush();
        productsRepository.flush();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.productId(), is(equalTo(product.getProductId())));
        assertThat(response.sizeName(), is(equalTo(sizeName)));
        assertThat(response.total(), is(equalTo(total)));
    }

    @Transactional
    @Rollback
    @Test
    public void testAddSizeWithProductNotExist() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.addSizeToProduct(productId, new CreateSizeRequest("a", 2)));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));

        // TODO: 17.05.2023  
    }

    @Transactional
    @Rollback
    @Test
    public void testAddSizeForProductWithSizeAlreadyExists() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        Size size1 = new Size()
                .setSizeId(new SizeId()
                        .setName("1")
                        .setProduct(product))
                .setTotal(1);

        Size size2 = new Size()
                .setSizeId(new SizeId()
                        .setName("2")
                        .setProduct(product))
                .setTotal(1);
        product.setSizes(List.of(size1, size2));

        productsRepository.saveAndFlush(product);

        // when
        var ex = assertThrows(DuplicateElementException.class, () ->
                catalogService.addSizeToProduct(product.getProductId(), new CreateSizeRequest(size1.getSizeId().getName(), size1.getTotal())));

        // then
        assertThat(ex.getVarName(), is(equalTo("size")));
        assertThat(ex.getClazz(), is(equalTo(Size.class)));
        assertThat(ex.getEntityId(), is(equalTo(size1.getSizeId())));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateProductWithProductAlreadyExists() {
        // given
        Category category = new Category().setName("category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("a")
                .setDescription("b")
                .setPrice(1)
                .setCategory(category);
        product.setImages(Collections.singletonList(new Image()
                .setImageId(new ImageId().setProduct(product).setPosition(1))
                .setImgBytes(new byte[]{1})));
        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.createProduct(new CreateProductRequest("a", "b", 1, category.getCategoryId(),
                Collections.singletonList(new CreateImageRequest(1, new byte[]{1}))));

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.description(), is(equalTo(product.getDescription())));
        assertThat(response.price(), is(equalTo(product.getPrice())));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));
    }


    @Transactional
    @Rollback
    @Test
    public void testSetSizeForProduct() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        Size size1 = new Size()
                .setSizeId(new SizeId()
                        .setName("1")
                        .setProduct(product))
                .setTotal(1);

        Size size2 = new Size()
                .setSizeId(new SizeId()
                        .setName("2")
                        .setProduct(product))
                .setTotal(1);
        product.setSizes(List.of(size1, size2));

        productsRepository.saveAndFlush(product);

        Integer total = 5;
        // when
        var response = catalogService.setSizeForProduct(product.getProductId(), new CreateSizeRequest(size1.getSizeId().getName(), total));

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.productId(), is(equalTo(product.getProductId())));
        assertThat(response.sizeName(), is(equalTo(size1.getSizeId().getName())));
        assertThat(response.total(), is(equalTo(total)));
        assertThat(productsRepository.findById(product.getProductId()).get().getSizes().get(0).getTotal(), is(equalTo(total)));
        assertThat(sizesRepository.findById(size1.getSizeId()).get().getTotal(), is(equalTo(total)));
    }

    @Transactional
    @Rollback
    @Test
    public void testSetSizeWithProductNotExist() {
        // given
        Long productId = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.setSizeForProduct(productId, new CreateSizeRequest("a", 2)));

        // then
        assertThat(ex.getVarName(), is(equalTo("product")));
        assertThat(ex.getClazz(), is(equalTo(Product.class)));
        assertThat(ex.getEntityId(), is(equalTo(productId)));
    }

    @Transactional
    @Rollback
    @Test
    public void testSetSizeWithSizeNotExist() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);
        productsRepository.saveAndFlush(product);

        String sizeName = "3";
        Integer total = 2;
        var sizeId = new SizeId()
                .setProduct(product)
                .setName(sizeName);

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                catalogService.setSizeForProduct(product.getProductId(), new CreateSizeRequest(sizeName, total)));

        // then
        assertThat(ex.getVarName(), is(equalTo("size")));
        assertThat(ex.getClazz(), is(equalTo(Size.class)));
        assertThat(ex.getEntityId(), is(equalTo(sizeId)));
    }


    @Transactional
    @Rollback
    @Test
    public void testDeleteSizeForProduct() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        Size size1 = new Size()
                .setSizeId(new SizeId()
                        .setName("1")
                        .setProduct(product))
                .setTotal(1);

        Size size2 = new Size()
                .setSizeId(new SizeId()
                        .setName("2")
                        .setProduct(product))
                .setTotal(1);
        product.setSizes(List.of(size1, size2));

        productsRepository.saveAndFlush(product);

        //when
        var response = catalogService.deleteSizeForProduct(product.getProductId(), new DeleteSizeRequest(size1.getSizeId().getName()));

        //then
        assertThat(response, is(notNullValue()));
        assertThat(response.sizeName(), is(equalTo(size1.getSizeId().getName())));
        assertThat(response.productId(), is(equalTo(product.getProductId())));
        assertThat(response.total(), is(equalTo(size1.getTotal())));
        assertThat(sizesRepository.findById(size1.getSizeId()), is(Optional.empty()));
    }
}

