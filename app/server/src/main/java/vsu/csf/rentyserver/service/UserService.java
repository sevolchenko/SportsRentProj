package vsu.csf.rentyserver.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.exception.AlreadyRegisteredUserException;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.model.entity.AppUser;
import vsu.csf.rentyserver.model.mapping.UserMapper;
import vsu.csf.rentyserver.repository.AppUsersRepository;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserService {

    private final AppUsersRepository usersRepository;
    private final PasswordEncoder passwordEncoder;

    private final UserMapper userMapper;

    public void register(RegisterRequest request) {
        log.info("Register user {} called", request);

        if (usersRepository.findByEmail(request.email()).orElse(null) != null) {
            throw new AlreadyRegisteredUserException(request.email());
        }

        var user = new AppUser()
                .setEmail(request.email())
                .setName(request.name())
                .setPassword(passwordEncoder.encode(request.password()));

        usersRepository.save(user);

    }

    @Transactional(readOnly = true)
    public UserResponse findById(Long userId) {
        log.info("Find user by id {} called", userId);

        var user = usersRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("user", AppUser.class, userId));

        return userMapper.map(user);
    }

    @Transactional(readOnly = true)
    public UserResponse findByEmail(String email) {
        log.info("Find user by email {} called", email);

        var user = usersRepository.findByEmail(email)
                .orElseThrow(() -> new NoSuchElementException("email", AppUser.class, email));

        return userMapper.map(user);
    }

}
