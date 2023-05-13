package vsu.csf.rentyserver.service;

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
import vsu.csf.rentyserver.model.entity.Category;
import vsu.csf.rentyserver.model.entity.Product;
import vsu.csf.rentyserver.model.mapping.CategoryMapper;
import vsu.csf.rentyserver.model.mapping.ProductMapper;
import vsu.csf.rentyserver.model.mapping.SizeMapper;
import vsu.csf.rentyserver.repository.CategoriesRepository;
import vsu.csf.rentyserver.repository.ProductsRepository;

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
    public void testDeleteProductByIdWithProductExists() {

        // given
        Category category = new Category().setName("Category");
        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("Liuz")
                .setDescription("Desc")
                .setPrice(123)
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

    }

}
