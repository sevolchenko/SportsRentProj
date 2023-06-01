package vsu.csf.rentyserver.controller.impl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vsu.csf.rentyserver.controller.IAuthController;
import vsu.csf.rentyserver.model.dto.user.request.LoginRequest;
import vsu.csf.rentyserver.model.dto.auth.response.LoginResponse;
import vsu.csf.rentyserver.service.AuthService;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Slf4j
public class AuthController implements IAuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest loginRequest) {
        log.info("Login by user email {} called", loginRequest.email());

        return authService.login(loginRequest);
    }

    @PostMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        log.info("Logout by token {} called", request.getHeader("Authorization"));

        SecurityContextLogoutHandler securityContextLogoutHandler = new SecurityContextLogoutHandler();
        securityContextLogoutHandler.logout(request, response, null);
    }

}
