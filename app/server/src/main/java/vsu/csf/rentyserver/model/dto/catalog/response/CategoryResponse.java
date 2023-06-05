package vsu.csf.rentyserver.model.dto.catalog.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CategoryResponse(

        @JsonProperty("category_id")
        Long categoryId,

        String name,

        @JsonProperty("parent_category")
        CategoryPreviewResponse parentCategory

) {
}
