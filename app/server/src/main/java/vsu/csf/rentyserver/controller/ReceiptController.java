package vsu.csf.rentyserver.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;
import vsu.csf.rentyserver.security.SecurityUser;
import vsu.csf.rentyserver.service.ReceiptService;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/receipts")
@Slf4j
@RequiredArgsConstructor
public class ReceiptController {

    private final ReceiptService receiptService;

    @GetMapping("/my")
    public List<ReceiptResponse> getMy(Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return receiptService.getAll(user.getUserId());
    }

    @GetMapping("/my/unpaid")
    public List<ReceiptResponse> getMyUnpaid(Authentication authentication) {
        var user = (SecurityUser) authentication.getPrincipal();
        return receiptService.getUnpaid(user.getUserId());
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
                                             Authentication authentication) {
        log.info("Employee {} requests all receipts for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                userId);

        return receiptService.getAll(userId);
    }

    @GetMapping("/{user_id}/unpaid")
    public List<ReceiptResponse> getByUserIdUnpaid(@PathVariable("user_id") Long userId,
                                                   Authentication authentication) {
        log.info("Employee {} requests unpaid receipts for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                userId);

        return receiptService.getUnpaid(userId);
    }

    @GetMapping("/{user_id}/{receipt_id}")
    public ReceiptResponse getByUserIdByReceiptId(@PathVariable("user_id") Long userId,
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
