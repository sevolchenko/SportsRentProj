package vsu.csf.rentyserver.model.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ProductProjectionResponse(

        @JsonProperty("product_id")
        Long productId,

        String name,

        Integer price,

        @JsonProperty("busy_now")
        Boolean busyNow,

        CategoryResponse category,

        @JsonProperty("main_image")
        ImageResponse mainImage

) {
}
