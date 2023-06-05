package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

public record CreateCategoryRequest(

        @JsonProperty("parent_category_id")
        Long parentCategoryId,

        @NotBlank
        String name

) {
}
