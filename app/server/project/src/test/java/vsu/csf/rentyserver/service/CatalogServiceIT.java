package vsu.csf.rentyserver.service;

import jakarta.persistence.NoResultException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.IntegrationEnvironment;
import vsu.csf.rentyserver.configuration.JdbcTestConfig;
import vsu.csf.rentyserver.model.dto.request.CreateCategoryRequest;
import vsu.csf.rentyserver.model.dto.request.CreateImageRequest;
import vsu.csf.rentyserver.model.dto.request.CreateProductRequest;
import vsu.csf.rentyserver.model.dto.request.CreateSizeRequest;
import vsu.csf.rentyserver.model.dto.response.ProductResponse;
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

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

@SpringBootTest
@Import(JdbcTestConfig.class)
@RunWith(SpringRunner.class)
public class CatalogServiceIT extends IntegrationEnvironment {

    @Autowired
    private CatalogService catalogService;

    @Autowired
    private ProductsRepository productsRepository;
    @Autowired
    private CategoriesRepository categoriesRepository;

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

        assertThat(response.products(), is(notNullValue()));
        assertThat(response.products().size(), is(equalTo(expected.size())));

        assertThat(response.products().get(0).name(), is(equalTo(product1.getName())));
        assertThat(response.products().get(0).price(), is(equalTo(product1.getPrice())));
        assertThat(response.products().get(0).description(), is(equalTo(product1.getDescription())));

        var categoryResponse = response.products().get(0).category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(response.products(), is(equalTo(productMapper.map(expected))));

    }

    @Transactional
    @Rollback
    @Test
    public void testListAllProductsWithNoProducts() {

        //when
        var response = catalogService.listAllProducts();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.products(), is(empty()));
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

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testFindProductByIdWithProductNotExists() throws NoResultException {
        catalogService.findProductById(5L);
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

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(productsRepository.findById(product.getProductId()), is(Optional.empty()));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testDeleteProductByIdWithProductNotExists() throws NoResultException {
        catalogService.deleteProductById(5L);
    }

    @Transactional
    @Rollback
    @Test
    public void testListAllProjections() {
        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product1 = new Product()
                .setName("1")
                .setDescription("Desc")
                .setPrice(123)
                .setCategory(category);

        product1.setImages(Collections.singletonList(new Image()
                .setImageId(new ImageId().setProduct(product1).setPosition(1))
                .setImgBytes(new byte[]{})));

        Product product2 = new Product()
                .setName("2")
                .setCategory(category);

        List<Product> expected = new ArrayList<>();
        expected.add(product1);
        expected.add(product2);

        productsRepository.saveAndFlush(product1);
        productsRepository.saveAndFlush(product2);

        // when
        var response = catalogService.listAllProjections();

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.size(), is(equalTo(expected.size())));

        assertThat(response.projections(), is(notNullValue()));
        assertThat(response.projections().size(), is(equalTo(expected.size())));

        var projectionResponse = response.projections().get(0);

        assertThat(projectionResponse.name(), is(equalTo(product1.getName())));
        assertThat(projectionResponse.price(), is(equalTo(product1.getPrice())));

        var imageResponse = response.projections().get(0).mainImage();
        assertThat(imageResponse.imgBytes(), is(equalTo(product1.getImages().get(0).getImgBytes())));
        assertThat(imageResponse.position(), is(equalTo(product1.getImages().get(0).getImageId().getPosition())));
        assertThat(imageResponse.productId(), is(equalTo(product1.getImages().get(0).getImageId().getProduct().getProductId())));

        var categoryResponse = response.projections().get(0).category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

    }

    @Transactional
    @Rollback
    @Test
    public void testListAllProjectionsWithNoProducts() {

        //when
        var response = catalogService.listAllProjections();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.projections(), is(empty()));
        assertThat(response.size(), is(equalTo(0)));

    }

    @Transactional
    @Rollback
    @Test
    public void testFindProjectionById() {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setImages(Collections.singletonList(new Image()
                .setImageId(new ImageId().setProduct(product).setPosition(1))
                .setImgBytes(new byte[]{})));

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findProjectionById(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.price(), is(equalTo(product.getPrice())));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testFindProjectionByIdWithProductNotExists() throws NoResultException {
        catalogService.findProjectionById(5L);
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

        assertThat(response.categories(), is(notNullValue()));
        assertThat(response.categories().size(), is(equalTo(expected.size())));

        assertThat(response.categories().get(0).name(), is(equalTo(category1.getName())));
        assertThat(response.categories().get(1).name(), is(equalTo(category2.getName())));

    }

    @Transactional
    @Rollback
    @Test
    public void testListAllCategoriesWithNoCategories() {

        //when
        var response = catalogService.listAllCategories();

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.categories(), is(empty()));
        assertThat(response.size(), is(equalTo(0)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindCategoryById() {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        // when
        var response = catalogService.findCategoryById(category.getCategoryId());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(response.name(), is(equalTo(category.getName())));

    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testFindCategoryByIdWithCategoryNotExists() throws NoResultException {
        catalogService.findCategoryById(5L);
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

        assertThat(categoriesRepository.findById(category.getCategoryId()), is(Optional.empty()));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testDeleteCategoryByIdWithCategoryNotExists() throws NoResultException {
        catalogService.deleteCategoryById(5L);
    }

    @Transactional
    @Rollback
    @Test
    public void testFindSizesByProductId() {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setSizes(Collections.singletonList(new Size()
                .setSizeId(new SizeId().setProduct(product).setName("1"))
                .setTotal(1)));

        productsRepository.saveAndFlush(product);

        // when
        var response = catalogService.findSizes(product.getProductId());

        // then
        assertThat(response, is(notNullValue()));

        assertThat(response.size(), is(equalTo(product.getSizes().size())));
        assertThat(response.sizes(), is(notNullValue()));
        assertThat(response.sizes().size(), is(equalTo(product.getSizes().size())));
        assertThat(response.sizes().get(0).sizeName(), is(equalTo(product.getSizes().get(0).getSizeId().getName())));
        assertThat(response.sizes().get(0).total(), is(equalTo(product.getSizes().get(0).getTotal())));

    }

    @Transactional
    @Rollback
    @Test
    public void testFindSizesByProductIdWithNoSizes() {
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
        assertThat(response.sizes(), is(empty()));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testFindSizesByIdWithProductNotExists() throws NoResultException {
        catalogService.findSizes(5L);
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateCategory() {

        // given
        Category parentCategory = new Category()
                .setName("a");
        categoriesRepository.saveAndFlush(parentCategory);

        Category category = new Category()
                .setParentCategory(parentCategory)
                .setName("l");

        // when
        var response = catalogService.createCategory(new CreateCategoryRequest(parentCategory.getCategoryId(), "l"));

        //then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(category.getName())));

        assertThat(categoriesRepository.findById(response.categoryId()), is(notNullValue()));

    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testCreateCategoryWithParentCategoryNotExists() throws NoResultException {
        catalogService.createCategory(new CreateCategoryRequest(1L, "l"));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateProduct() {
        // given
        Category category = new Category()
                .setName("a");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("a")
                .setDescription("b")
                .setPrice(1)
                .setCategory(category);
        product.setImages(Collections.singletonList(new Image()
                .setImageId(new ImageId().setProduct(product).setPosition(1))
                .setImgBytes(new byte[]{1})));

        // when
        var response = catalogService.createProduct(new CreateProductRequest("a", "b", 1, category.getCategoryId(),
                Collections.singletonList(new CreateImageRequest(1, new byte[]{1}))));

        //then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.description(), is(equalTo(product.getDescription())));
        assertThat(response.price(), is(equalTo(product.getPrice())));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(productsRepository.findById(response.productId()), is(notNullValue()));

    }

    @Transactional
    @Rollback
    @Test(expected = IllegalArgumentException.class)
    public void testCreateProductWithCategoryNotExists() throws IllegalArgumentException {
        catalogService.createProduct(new CreateProductRequest("a", "b", 1, 1L,
                Collections.singletonList(new CreateImageRequest(1, new byte[]{1}))));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testAddSizeForProductWithProductNotExist() throws NoResultException {
        catalogService.addSizeToProduct(1L, new CreateSizeRequest("f", 1));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testAddSizeForProductWithSizeAlreadyExists() throws NoResultException {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setSizes(Collections.singletonList(new Size()
                .setSizeId(new SizeId().setProduct(product).setName("f"))
                .setTotal(1)));

        productsRepository.saveAndFlush(product);

        //when
        catalogService.addSizeToProduct(product.getProductId(), new CreateSizeRequest("f", 1));
    }

    @Transactional
    @Rollback
    @Test(expected = NoResultException.class)
    public void testCreateCategoryWithCategoryAlreadyExists() throws NoResultException {
        Category parentCategory = new Category().setName("parent category");
        categoriesRepository.saveAndFlush(parentCategory);

        Category category = new Category()
                .setName("Category")
                .setParentCategory(parentCategory);
        categoriesRepository.saveAndFlush(category);

        //when
        catalogService.createCategory(new CreateCategoryRequest(parentCategory.getCategoryId(), "Category"));
    }

    @Transactional
    @Rollback
    @Test
    public void testCreateProductWithProductAlreadyExists() {
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

        //then
        assertThat(response, is(notNullValue()));

        assertThat(response.name(), is(equalTo(product.getName())));
        assertThat(response.description(), is(equalTo(product.getDescription())));
        assertThat(response.price(), is(equalTo(product.getPrice())));

        var categoryResponse = response.category();
        assertThat(categoryResponse, is(notNullValue()));

        assertThat(categoryResponse.categoryId(), is(equalTo(category.getCategoryId())));
        assertThat(categoryResponse.name(), is(equalTo(category.getName())));

        assertThat(productsRepository.findById(response.productId()), is(notNullValue()));

        }


    @Transactional
    @Rollback
    @Test
    public void testSetSizeForProduct() {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setSizes(Collections.singletonList(new Size()
                .setSizeId(new SizeId().setProduct(product).setName("f"))
                .setTotal(1)));

        productsRepository.saveAndFlush(product);

        //when
        var response = catalogService.setSizeForProduct(product.getProductId(), new CreateSizeRequest("f", 2));

        //then
        assertThat(response, is(notNullValue()));
        assertThat(response.total(), is(equalTo(product.getSizes().get(0).getTotal())));
    }

    @Transactional
    @Rollback
    @Test
    public void testDeleteSizeForProduct() {
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setCategory(category);

        product.setSizes(Collections.singletonList(new Size()
                .setSizeId(new SizeId().setProduct(product).setName("f"))
                .setTotal(1)));

        productsRepository.saveAndFlush(product);

        //when
        var response = catalogService.deleteSizeForProduct(product.getProductId(), "f");

        //then
        assertThat(response, is(notNullValue()));
        assertThat(response.sizeName(), is(equalTo(product.getName())));
    }
}

