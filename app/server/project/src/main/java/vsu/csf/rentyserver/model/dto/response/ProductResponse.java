package vsu.csf.rentyserver.model.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import vsu.csf.rentyserver.model.dto.response.list.SizeListResponse;

import java.util.List;

public record ProductResponse(

        @JsonProperty("product_id")
        Long productId,

        String name,

        String description,

        Integer price,

        SizeListResponse sizes,

        CategoryResponse category,

        List<ImageResponse> images

) {
}
