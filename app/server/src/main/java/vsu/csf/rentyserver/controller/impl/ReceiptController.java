package vsu.csf.rentyserver.controller.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.controller.IReceiptController;
import vsu.csf.rentyserver.model.dto.receipt.request.ReceiptStatusFilter;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.ReceiptService;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/receipts")
@Slf4j
@RequiredArgsConstructor
public class ReceiptController implements IReceiptController {

    private final ReceiptService receiptService;

    @GetMapping("/my")
    public List<ReceiptResponse> getMy(@RequestParam(name = "status_filter", required = false, defaultValue = "ALL")
                                       ReceiptStatusFilter statusFilter,
                                       Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return receiptService.getAll(user.getUserId(), statusFilter);
    }

    @GetMapping("/my/{receipt_id}")
    public ReceiptResponse getMyByReceiptId(@PathVariable("receipt_id") UUID receiptId,
                                            Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!receiptService.owns(user.getUserId(), receiptId)) {
            throw new AccessDeniedException("It's not your receipt");
        }

        return receiptService.findOne(receiptId);
    }

    @GetMapping("/{user_id}")
    public List<ReceiptResponse> getByUserId(@PathVariable("user_id") Long userId,
                                             @RequestParam(name = "status_filter", required = false, defaultValue = "ALL")
                                             ReceiptStatusFilter statusFilter,
                                             Authentication authentication) {
        log.info("Employee {} requests all receipts for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                userId);

        return receiptService.getAll(userId, statusFilter);
    }

    @GetMapping("/{user_id}/{receipt_id}")
    public ReceiptResponse getReceiptByUserIdAndReceiptId(@PathVariable("user_id") Long userId,
                                                          @PathVariable("receipt_id") UUID receiptId,
                                                          Authentication authentication) {
        log.info("Employee {} requests receipt by id {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                receiptId);

        if (!receiptService.owns(userId, receiptId)) {
            throw new AccessDeniedException("It's not %d user's receipt"
                    .formatted(userId));
        }

        return receiptService.findOne(receiptId);
    }

    @PatchMapping("/my/{receipt_id}/pay")
    public ReceiptResponse performPay(@PathVariable("receipt_id") UUID receiptId,
                                      Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();

        if (!receiptService.owns(user.getUserId(), receiptId)) {
            throw new AccessDeniedException("It's not your receipt");
        }

        return receiptService.performPay(receiptId);
    }


}
