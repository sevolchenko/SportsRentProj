package vsu.csf.rentyserver.model.dto.error;

public record FieldErrorResponse(

        String field,

        String message

){

    public static FieldErrorResponse of(String field, String  message) {
        return new FieldErrorResponse(field, message);
    }

}
