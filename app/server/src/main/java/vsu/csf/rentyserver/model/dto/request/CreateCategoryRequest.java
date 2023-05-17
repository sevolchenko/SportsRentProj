package vsu.csf.rentyserver.model.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CreateCategoryRequest(

        @JsonProperty("parent_category_id")
        Long parentCategoryId,

        String name

) {
}
