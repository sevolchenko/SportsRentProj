package vsu.csf.rentyserver.model.dto.receipt.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.model.entity.enumeration.ReceiptStatus;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public record ReceiptResponse(

        @JsonProperty("receipt_id")
        UUID receiptId,

        UserResponse user,

        UserResponse employee,

        @JsonProperty("pay_link")
        String payLink,

        @JsonProperty("created_at")
        OffsetDateTime createdAt,

        ReceiptStatus status,

        Integer sum,

        List<ReceiptItemResponse> rents

) {
}
