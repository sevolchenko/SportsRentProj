package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ProductProjectionResponse(

        @JsonProperty("product_id")
        Long productId,

        String name,

        Integer price,

        @JsonProperty("busy_now")
        Boolean busyNow,

        CategoryPreviewResponse category,

        @JsonProperty("main_image")
        ImageResponse mainImage

) {
}
