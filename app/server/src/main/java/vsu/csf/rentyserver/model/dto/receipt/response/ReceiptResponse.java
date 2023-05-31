package vsu.csf.rentyserver.model.dto.receipt.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import vsu.csf.rentyserver.model.dto.user.response.UserResponse;
import vsu.csf.rentyserver.model.entity.enumeration.ReceiptStatus;

import java.util.List;

public record ReceiptResponse(

        UserResponse user,

        UserResponse employee,

        @JsonProperty("pay_link")
        String payLink,

        ReceiptStatus status,

        Integer sum,

        List<ReceiptItemResponse> rents

) {
}
