package vsu.csf.rentyserver.model.dto.auth.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoginResponse(

        @JsonProperty("user_id")
        Long userId,

        String role,

        String token


) {
}
