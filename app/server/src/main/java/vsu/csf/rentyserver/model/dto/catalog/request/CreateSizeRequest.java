package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

public record CreateSizeRequest(
        @JsonProperty("size_name")
        @NotBlank
        String sizeName,

        @Min(0)
        Integer total

) {
}
