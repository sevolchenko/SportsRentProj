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
import vsu.csf.rentyserver.model.entity.*;
import vsu.csf.rentyserver.model.entity.id.ImageId;
import vsu.csf.rentyserver.model.entity.id.SizeId;
import vsu.csf.rentyserver.model.mapping.CategoryMapper;
import vsu.csf.rentyserver.model.mapping.ProductMapper;
import vsu.csf.rentyserver.model.mapping.RentMapper;
import vsu.csf.rentyserver.model.mapping.SizeMapper;
import vsu.csf.rentyserver.repository.*;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
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
public class RentServiceIT extends IntegrationEnvironment {

    @Autowired
    private RentService rentService;

    @Autowired
    private RentEventsRepository rentEventsRepository;

    @Autowired
    private AppUsersRepository appUsersRepository;

    @Autowired
    private CategoriesRepository categoriesRepository;

    @Autowired
    private RentMapper rentMapper;

    @Transactional
    @Rollback
    @Test
    public void testGetAll() {
        // given
        AppUser user = new AppUser()
                .setName("Джов Кириллович")
                .setEmail("begemotic2300@gmail.com")
                .setPassword("1111");
        appUsersRepository.saveAndFlush(user);

        Category category = new Category()
                .setName("category");

        categoriesRepository.saveAndFlush(category);

        Product product = new Product()
                .setName("product")
                .setDescription("description")
                .setPrice(123)
                .setCategory(category);

        RentEvent rentEvent = new RentEvent()
                .setUser(user)
                .setProduct(product)
                .setStartTime(OffsetDateTime.now())
                .setEndTime(OffsetDateTime.);

        // when

        // then

    }

    @Transactional
    @Rollback
    @Test
    public void testGetAllWithNoRents() {

    }

    @Transactional
    @Rollback
    @Test
    public void testGetAllWithUserNotExists() {

    }

}
