package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import vsu.csf.rentyserver.model.dto.catalog.response.list.ImageListResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.list.SizeListResponse;

public record ProductResponse(

        @JsonProperty("product_id")
        Long productId,

        String name,

        String description,

        Integer price,

        SizeListResponse sizes,

        CategoryPreviewResponse category,

        ImageListResponse images

) {
}
