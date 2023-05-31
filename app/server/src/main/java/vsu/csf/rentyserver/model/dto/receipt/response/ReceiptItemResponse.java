package vsu.csf.rentyserver.model.dto.receipt.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductPreviewResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;

import java.time.Duration;

public record ReceiptItemResponse(

        @JsonProperty("rent_id")
        Long rentId,

        ProductPreviewResponse product,

        SizeResponse size,

        Duration duration,

        @JsonProperty("pretty_duration")
        String prettyDuration,

        Integer count,

        Integer price,

        Integer fine

) {
}
