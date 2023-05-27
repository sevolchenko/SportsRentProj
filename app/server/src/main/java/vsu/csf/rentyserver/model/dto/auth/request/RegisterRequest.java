package vsu.csf.rentyserver.model.dto.auth.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record RegisterRequest(

        @Email
        String email,

        @NotBlank
        String name,

        @Pattern(regexp = "^.{8,}$", message = "должен быть минимум 8 символов в длину")
        @Pattern(regexp = "^\\S*$", message = "не должен содержать пробелов")
        @Pattern(regexp = "^([0-9a-zA-Z@#$%^&+=]+)$", message = "должен состоять только из латинских букв, цифр и " +
                "специальных символов @#$%^&+=")
        @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$", message = "должен содержать как минимум " +
                "одну цифру и латинскую букву")
        String password

) {
}
