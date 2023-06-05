package vsu.csf.rentyserver.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.IntegrationEnvironment;
import vsu.csf.rentyserver.exception.AlreadyRegisteredUserException;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.entity.*;
import vsu.csf.rentyserver.model.mapping.UserMapper;
import vsu.csf.rentyserver.repository.AppUsersRepository;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThrows;

@SpringBootTest
@ActiveProfiles("test")
@RunWith(SpringRunner.class)
public class UserServiceITest extends IntegrationEnvironment {

    @Autowired
    private UserService userService;

    @Autowired
    private AppUsersRepository appUsersRepository;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
    @Rollback
    @Test
    public void testRegister() {
        // given
        String email = "boris@mail.ru";
        String name = "Баранов Тимур Михайлович";
        String password = "0000";

        // when
        userService.register(new RegisterRequest(email, name, password));

        // then
        var user = appUsersRepository.findByEmail(email).orElse(null);
        assertThat(user, is(notNullValue()));
        assertThat(user.getName(), is(equalTo(name)));
        assertThat(passwordEncoder.matches(password, user.getPassword()), is(true));
        assertThat(user.getEmail(), is(equalTo(email)));
    }

    @Transactional
    @Rollback
    @Test
    public void testRegisterWithUserAlreadyExists() {
        // given
        AppUser user = new AppUser()
                .setName("Курочкин Андрей Валерьевич")
                .setEmail("begemotic2300@gmail.com")
                .setPassword("1111");
        appUsersRepository.saveAndFlush(user);

        // when
        var ex = assertThrows(AlreadyRegisteredUserException.class, () ->
                userService.register(new RegisterRequest(user.getEmail(), user.getName(), "1")));

        // then
        assertThat(ex.getMessage(), is(equalTo("User already registered: %s".formatted(user.getEmail()))));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindById() {
        // given
        AppUser user = new AppUser()
                .setName("Гольцов Михаил Степанович")
                .setEmail("princess2004@gmail.com")
                .setPassword("2222");
        appUsersRepository.saveAndFlush(user);

        // when
        var response = userService.findById(user.getUserId());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response, is(equalTo(userMapper.map(user))));
        assertThat(response.email(), is(equalTo(user.getEmail())));
        assertThat(response.name(), is(equalTo(user.getName())));
        assertThat(response.userId(), is(equalTo(user.getUserId())));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindByIdWithUserNotExists() {
        // given
        Long id = 5L;

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                userService.findById(id));

        // then
        assertThat(ex.getVarName(), is(equalTo("user")));
        assertThat(ex.getClazz(), is(equalTo(AppUser.class)));
        assertThat(ex.getEntityId(), is(equalTo(id)));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindByName() {
        // given
        AppUser user = new AppUser()
                .setName("Прохорова Галина Викторовна")
                .setEmail("progv@gmail.com")
                .setPassword("1111");
        appUsersRepository.saveAndFlush(user);

        // when
        var response = userService.findByEmail(user.getEmail());

        // then
        assertThat(response, is(notNullValue()));
        assertThat(response, is(equalTo(userMapper.map(user))));
        assertThat(response.email(), is(equalTo(user.getEmail())));
        assertThat(response.name(), is(equalTo(user.getName())));
        assertThat(response.userId(), is(equalTo(user.getUserId())));
    }

    @Transactional
    @Rollback
    @Test
    public void testFindByEmailWithUserNotExists() {
        // given
        String email = "opretikul@gmail.com";

        // when
        var ex = assertThrows(NoSuchElementException.class, () ->
                userService.findByEmail(email));

        // then
        assertThat(ex.getVarName(), is(equalTo("email")));
        assertThat(ex.getClazz(), is(equalTo(AppUser.class)));
        assertThat(ex.getEntityId(), is(equalTo(email)));
    }
}
