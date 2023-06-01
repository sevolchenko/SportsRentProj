package vsu.csf.rentyserver.model.dto.rent.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.OffsetDateTime;

public record ProlongRentRequest (

        @JsonProperty("end_time")
        OffsetDateTime endTime

) {
}
