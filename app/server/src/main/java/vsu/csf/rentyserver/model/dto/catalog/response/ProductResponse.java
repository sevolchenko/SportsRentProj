package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record ProductResponse(

        @JsonProperty("product_id")
        Long productId,

        String name,

        String description,

        Integer price,

        List<SizeResponse> sizes,

        CategoryPreviewResponse category,

        List<ImageResponse> images

) {
}
