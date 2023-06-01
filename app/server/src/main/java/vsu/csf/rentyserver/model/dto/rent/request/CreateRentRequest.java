package vsu.csf.rentyserver.model.dto.rent.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;

import java.time.OffsetDateTime;

public record CreateRentRequest(

        @FutureOrPresent
        @JsonProperty("start_time")
        OffsetDateTime startTime,

        @JsonProperty("end_time")
        OffsetDateTime endTime,

        @NotNull
        @JsonProperty("product_id")
        Long productId,

        @NotBlank
        @JsonProperty("size_name")
        String sizeName,

        @Positive
        Integer count

) {

    @AssertTrue(message = "End time should be later than start time")
    private boolean validateEndTime() {
        return endTime.isAfter(startTime);
    }

}
