package vsu.csf.rentyserver.controller.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

    @GetMapping("/{user_id}")
    public List<ReceiptResponse> getByUserId(@PathVariable("user_id") Long userId,
                                             @RequestParam(name = "status_filter", required = false, defaultValue = "ALL")
                                             ReceiptStatusFilter statusFilter,
                                             Authentication authentication) {
        log.info("Employee {} requests {} receipts for user {}",
                ((SecurityUser) authentication.getPrincipal()).getUserId(),
                statusFilter,
                userId);

        return receiptService.getAll(userId, statusFilter);
    }

    @GetMapping("/{receipt_id}/show")
    public ReceiptResponse getByReceiptId(@PathVariable("receipt_id") UUID receiptId) {
        return receiptService.findOne(receiptId);
    }

    @PatchMapping("/{receipt_id}/pay")
    public ReceiptResponse performPay(@PathVariable("receipt_id") UUID receiptId) {
        return receiptService.performPay(receiptId);
    }


}
