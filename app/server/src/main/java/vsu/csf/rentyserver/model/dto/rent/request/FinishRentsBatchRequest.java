package vsu.csf.rentyserver.model.dto.rent.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;

import java.util.List;

public record FinishRentsBatchRequest(

        @NotEmpty
        @JsonProperty("rent_ids")
        List<Long> rentIds

) {
}
