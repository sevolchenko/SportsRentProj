package vsu.csf.rentyserver.model.dto.catalog.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record DeleteSizeRequest(

        @JsonProperty("size_name")
        String sizeName

) {
}
