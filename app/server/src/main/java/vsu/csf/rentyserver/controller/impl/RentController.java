package vsu.csf.rentyserver.controller.impl;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.controller.IRentController;
import vsu.csf.rentyserver.model.dto.rent.request.*;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.RentService;

import java.util.List;

@RestController
@RequestMapping("/rents")
@RequiredArgsConstructor
@Slf4j
public class RentController implements IRentController {

    private final RentService rentService;

    @GetMapping("/my")
    public List<RentResponse> getMy(@RequestParam(name = "status_filter", required = false, defaultValue = "ALL")
                                    RentStatusFilter filter,
                                    Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.getAll(user.getUserId(), filter);
    }

    @GetMapping("/my/{rent_id}")
    public RentResponse getMyRentById(@PathVariable("rent_id") Long rentId,
                                      Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!rentService.owns(user.getUserId(), rentId)) {
            throw new AccessDeniedException("It's not your rent");
        }

        return rentService.getOne(rentId);
    }

    @PostMapping("/my/start")
    public RentResponse start(@Valid @RequestBody CreateRentRequest request,
                              Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.create(user.getUserId(), request);
    }

    @PostMapping("/my/start/batch")
    public List<RentResponse> start(@Valid @RequestBody CreateRentsBatchRequest request,
                                    Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return rentService.create(user.getUserId(), request);
    }

    @PatchMapping("/my/{rent_id}/prolong")
    public RentResponse prolong(@PathVariable("rent_id") Long rentId,
                                @Valid @RequestBody ProlongRentRequest request,
                                Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!rentService.owns(user.getUserId(), rentId)) {
            throw new AccessDeniedException("It's not your rent");
        }

        return rentService.prolong(rentId, request);
    }

    @GetMapping("/{user_id}")
    public List<RentResponse> get(@PathVariable("user_id") Long userId,
                                  @RequestParam(name = "status_filter", required = false, defaultValue = "ALL")
                                  RentStatusFilter filter,
                                  Authentication authentication) {
        log.info("Employee {} requests all rents for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                userId);

        return rentService.getAll(userId, filter);
    }

    @GetMapping("/{user_id}/{rent_id}")
    public RentResponse getById(@PathVariable("user_id") Long userId,
                                @PathVariable("rent_id") Long rentId,
                                Authentication authentication) {
        log.info("Employee {} requests for rent {} for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                rentId,
                userId);

        if (!rentService.owns(userId, rentId)) {
            throw new AccessDeniedException("It's not %d user's rent"
                    .formatted(userId));
        }

        return rentService.getOne(rentId);
    }

    @PatchMapping("/{user_id}/{rent_id}/finish")
    public RentResponse finish(@PathVariable("user_id") Long userId,
                               @PathVariable("rent_id") Long rentId,
                               Authentication authentication) {
        if (!rentService.owns(userId, rentId)) {
            throw new AccessDeniedException("It's not %d user's rent"
                    .formatted(userId));
        }

        var employee = (SecurityUser) authentication.getPrincipal();

        return rentService.finish(userId, employee.getUserId(), rentId);
    }

    @PatchMapping("/{user_id}/finish/batch")
    public List<RentResponse> finish(@PathVariable("user_id") Long userId,
                                     @Valid @RequestBody FinishRentsBatchRequest request,
                                     Authentication authentication) {

        request.rentIds().forEach((rentId) -> {
            if (!rentService.owns(userId, rentId)) {
                throw new AccessDeniedException("It's not %d user's rent"
                        .formatted(userId));
            }
        });

        var employee = (SecurityUser) authentication.getPrincipal();

        return rentService.finish(userId, employee.getUserId(), request.rentIds());
    }

}
