package vsu.csf.rentyserver.model.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record SizeResponse(

        @JsonProperty("product_id")
        Long productId,

        @JsonProperty("size_name")
        String sizeName,

        Integer total,

        @JsonProperty("count_available_now")
        Integer countAvailableNow

) {
}
