package vsu.csf.rentyserver.model.dto.receipt.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import vsu.csf.rentyserver.model.entity.enumeration.ReceiptStatus;

import java.util.Set;

@Getter
@RequiredArgsConstructor
public enum ReceiptStatusFilter {

    ALL(Set.of(ReceiptStatus.values())),

    PAID(Set.of(ReceiptStatus.PAID)),

    NOT_PAID(Set.of(ReceiptStatus.CREATED));

    private final Set<ReceiptStatus> statuses;
}
