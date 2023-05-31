package vsu.csf.rentyserver.model.dto.rent.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record FinishRentRequest(

        @JsonProperty("rend_id")
        Long rentId

) {
}
