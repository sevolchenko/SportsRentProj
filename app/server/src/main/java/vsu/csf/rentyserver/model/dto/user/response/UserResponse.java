package vsu.csf.rentyserver.model.dto.user.response;

import com.fasterxml.jackson.annotation.JsonProperty;

public record UserResponse(

        @JsonProperty("user_id")
        Long userId,

        String email,

        String name,

        String role

) {
}
