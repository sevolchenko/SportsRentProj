package vsu.csf.rentyserver.model.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CategoryResponse(

        @JsonProperty("category_id")
        Long categoryId,

        String name

) {
}
