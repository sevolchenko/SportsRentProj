package vsu.csf.rentyserver.model.dto.auth.request;

public record RegisterRequest(

        String email,

        String name,

        String password

) {
}
