package vsu.csf.rentyserver.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.model.dto.auth.request.RegisterRequest;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.UserService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
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

    @GetMapping("/find")
    public UserResponse findByEmail(@RequestParam("email") String email) {
        return userService.findByEmail(email);
    }

}
