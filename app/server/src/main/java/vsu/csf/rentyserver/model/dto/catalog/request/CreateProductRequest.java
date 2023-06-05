package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

public record CreateProductRequest(

        @NotBlank
        String name,

        @NotBlank
        String description,

        @Min(0)
        Integer price,

        @JsonProperty("category_id")
        Long categoryId,

        @Valid
        List<CreateImageRequest> images

) {
}
