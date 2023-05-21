package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record CreateProductRequest(

        String name,

        String description,

        Integer price,

        @JsonProperty("category_id")
        Long categoryId,

        List<CreateImageRequest> images

) {
}
