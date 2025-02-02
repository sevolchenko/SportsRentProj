package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ImageResponse(

        @JsonProperty("image")
        byte[] imgBytes,

        @JsonProperty("product_id")
        Long productId,

        Integer position

) {
}
