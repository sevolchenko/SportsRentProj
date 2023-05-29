package vsu.csf.rentyserver.model.dto.rent.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

import java.time.OffsetDateTime;

public record CreateRentRequest(

        @FutureOrPresent
        @JsonProperty("start_time")
        OffsetDateTime startTime,

        @FutureOrPresent
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
}
