package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CategoryPreviewResponse(

        @JsonProperty("category_id")
        Long categoryId,

        String name

) {
}
