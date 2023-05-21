package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record CreateImageRequest(

        Integer position,

        @JsonProperty("image")
        byte[] imgBytes

) {
}
