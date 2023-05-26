package vsu.csf.rentyserver.model.dto;

import java.util.Map;

public record ApiErrorResponse(

        Map<String, String> errors,

        String code,

        String exceptionName,

        String exceptionMessage

) {
}
