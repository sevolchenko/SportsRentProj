package vsu.csf.rentyserver.model.dto.error;

import java.util.List;

public record ApiErrorResponse(

        List<FieldErrorResponse> errors,

        String code,

        String exceptionName,

        String exceptionMessage

) {
}
