package vsu.csf.rentyserver.model.dto.auth.request;

public record LoginRequest(

        String email,

        String password

) {
}
