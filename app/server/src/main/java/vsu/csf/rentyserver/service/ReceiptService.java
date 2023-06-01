package vsu.csf.rentyserver.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.exception.WrongRentStatusException;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;
import vsu.csf.rentyserver.model.entity.Receipt;
import vsu.csf.rentyserver.model.entity.enumeration.ReceiptStatus;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.model.mapping.ReceiptMapper;
import vsu.csf.rentyserver.repository.ReceiptsRepository;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class ReceiptService {

    private final ReceiptsRepository receiptsRepository;

    private final ReceiptMapper receiptMapper;

    @Transactional(readOnly = true)
    public List<ReceiptResponse> getAll(Long userId) {
        log.info("List all receipts for user {} called", userId);

        var receipts = receiptsRepository.findAllByUserUserId(userId);

        return receiptMapper.map(receipts);
    }

    @Transactional(readOnly = true)
    public List<ReceiptResponse> getUnpaid(Long userId) {
        log.info("List unpaid receipts for user {} called", userId);

        var receipts = receiptsRepository.findAllByUserUserIdAndStatusNot(userId, ReceiptStatus.PAID);

        return receiptMapper.map(receipts);
    }

    @Transactional(readOnly = true)
    public boolean owns(Long userId, UUID receiptId) {
        return receiptsRepository.findById(receiptId)
                .orElseThrow(() -> new NoSuchElementException("receipt", Receipt.class, receiptId))
                .getUser().getUserId().equals(userId);
    }

    @Transactional(readOnly = true)
    public ReceiptResponse findOne(UUID receiptId) {
        log.info("Find receipt by id {} called", receiptId);

        var receipt = receiptsRepository.findById(receiptId)
                .orElseThrow(() -> new NoSuchElementException("receipt", Receipt.class, receiptId));

        return receiptMapper.map(receipt);
    }

    public ReceiptResponse performPay(UUID receiptId) {
        log.info("Pay receipt by id {} called", receiptId);

        var receipt = receiptsRepository.findById(receiptId)
                .orElseThrow(() -> new NoSuchElementException("receipt", Receipt.class, receiptId));

        receipt.setStatus(ReceiptStatus.PAID);

        receipt.getRents().forEach((rentEvent -> {

            if (rentEvent.getStatus() != RentStatus.AWAITING_PAYMENT) {
                throw new WrongRentStatusException(rentEvent.getRentId(), rentEvent.getStatus());
            }

            rentEvent.setStatus(RentStatus.FINISHED);

            log.info("Rent {} paid by user {}", rentEvent.getRentId(), receipt.getUser().getUserId());
        }));

        return receiptMapper.map(receipt);

    }

}
