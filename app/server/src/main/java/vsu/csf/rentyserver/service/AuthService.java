package vsu.csf.rentyserver.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.exception.AlreadyRegisteredUserException;
import vsu.csf.rentyserver.model.dto.auth.request.LoginRequest;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.dto.auth.response.LoginResponse;
import vsu.csf.rentyserver.model.entity.AppUser;
import vsu.csf.rentyserver.repository.AppUsersRepository;
import vsu.csf.rentyserver.security.JwtTokenProvider;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthService {

    private final AppUsersRepository usersRepository;

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;

    public LoginResponse login(LoginRequest loginRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.email(), loginRequest.password()));

        AppUser user = usersRepository.findByEmail(loginRequest.email())
                .orElseThrow(() -> new UsernameNotFoundException(
                        "User %s doest`n exists".formatted(loginRequest.email())));

        String token = jwtTokenProvider.createToken(loginRequest.email(), user.getRole().name());

        return new LoginResponse(user.getUserId(), user.getRole().name(), token);
    }

    public void register(RegisterRequest request) {

        if (usersRepository.findByEmail(request.email()).orElse(null) != null) {
            throw new AlreadyRegisteredUserException(request.email());
        }

        var user = new AppUser()
                .setEmail(request.email())
                .setName(request.name())
                .setPassword(passwordEncoder.encode(request.password()));

        usersRepository.save(user);

    }

}
