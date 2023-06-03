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

        @JsonProperty("excepted_duration")
        Duration exceptedDuration,

        @JsonProperty("fact_duration")
        Duration factDuration,

        @JsonProperty("pretty_duration")
        String prettyDuration,

        Integer count,

        Integer price,

        Integer fine

) {
}
