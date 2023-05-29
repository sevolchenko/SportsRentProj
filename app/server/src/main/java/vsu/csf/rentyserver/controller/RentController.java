package vsu.csf.rentyserver.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.model.dto.rent.request.CreateRentRequest;
import vsu.csf.rentyserver.model.dto.rent.request.ProlongRentRequest;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.RentService;

import java.util.List;

@RestController
@RequestMapping("/rents")
@RequiredArgsConstructor
public class RentController {

    private final RentService rentService;

    @GetMapping("/my")
    List<RentResponse> getMy(Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.getAll(user.getUserId());
    }

    @GetMapping("/my/ongoing")
    List<RentResponse> getMyOngoing(Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.getOngoing(user.getUserId());
    }

    @GetMapping("/my/{rent_id}")
    RentResponse getById(@PathVariable("rent_id") Long rentId,
                         Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!rentService.owns(user.getUserId(), rentId)) {
            throw new AccessDeniedException("It's not your rent");
        }

        return rentService.getOne(rentId);
    }

    @PostMapping("/my")
    List<RentResponse> create(@Valid @RequestBody List<CreateRentRequest> request,
                              Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.create(user.getUserId(), request);
    }

    @PatchMapping("/my/{rent_id}")
    RentResponse prolong(@PathVariable("rent_id") Long rentId,
                         @Valid @RequestBody ProlongRentRequest request,
                         Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!rentService.owns(user.getUserId(), rentId)) {
            throw new AccessDeniedException("It's not your rent");
        }

        return rentService.prolong(rentId, request);
    }

}
