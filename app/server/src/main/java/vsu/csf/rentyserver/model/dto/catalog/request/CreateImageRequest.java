package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;

public record CreateImageRequest(

        @Min(1)
        Integer position,

        @JsonProperty("image")
        byte[] imgBytes

) {
}
