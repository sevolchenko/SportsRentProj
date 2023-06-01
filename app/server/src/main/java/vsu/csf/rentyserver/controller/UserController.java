package vsu.csf.rentyserver.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.UserService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
@Slf4j
public class UserController {

    private final UserService userService;

    @PostMapping("/register")
    public void register(@Valid @RequestBody RegisterRequest request) {
        userService.register(request);
    }

    @GetMapping("/me")
    public UserResponse findMe(Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return userService.findById(user.getUserId());
    }

    @GetMapping("/search")
    public UserResponse findByEmail(@RequestParam("email") String email,
                                    Authentication authentication) {
        log.info("Employee {} searching user by email {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                email);

        return userService.findByEmail(email);
    }

}
