package vsu.csf.rentyserver.controller.handler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import vsu.csf.rentyserver.exception.AlreadyRegisteredUserException;
import vsu.csf.rentyserver.exception.DuplicateElementException;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.model.dto.ApiErrorResponse;

import javax.naming.AuthenticationException;
import java.util.Arrays;
import java.util.List;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
@Slf4j
public class ApiExceptionHandler extends ResponseEntityExceptionHandler {

    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex,
                                                                  HttpHeaders headers,
                                                                  HttpStatusCode status,
                                                                  WebRequest request) {
        return buildApiErrorResponse(ex, "Wrong response", HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    protected ResponseEntity<Object> handleMethodArgumentTypeMismatchException(MethodArgumentTypeMismatchException ex) {
        return buildApiErrorResponse(ex, "Wrong response parameters", HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DuplicateElementException.class)
    protected ResponseEntity<Object> handleNoSuchChatException(DuplicateElementException ex) {
        return buildApiErrorResponse(ex, ex.getVarName(), HttpStatus.CONFLICT);
    }

    @ExceptionHandler(NoSuchElementException.class)
    protected ResponseEntity<Object> handleNoSuchChatException(NoSuchElementException ex) {
        return buildApiErrorResponse(ex, ex.getVarName(), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(BadCredentialsException.class)
    protected ResponseEntity<Object> handleBadCredentialsException(BadCredentialsException ex) {
        return buildApiErrorResponse(ex, ex.getMessage(), HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(AuthenticationException.class)
    protected ResponseEntity<Object> handleAuthenticationException(AuthenticationException ex) {
        return buildApiErrorResponse(ex, ex.getMessage(), HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(AlreadyRegisteredUserException.class)
    protected ResponseEntity<Object> handleAlreadyRegisteredUserException(AlreadyRegisteredUserException ex) {
        return buildApiErrorResponse(ex, ex.getMessage(), HttpStatus.CONFLICT);
    }


    private ResponseEntity<Object> buildApiErrorResponse(Exception ex, String description, HttpStatus status) {
        log.warn("Received exception {}: {}. Response code: {}", ex.getClass().getName(), description, status);

        List<String> stackTrace = Arrays.stream(ex.getStackTrace())
                .map(StackTraceElement::toString)
                .toList();
        ApiErrorResponse apiErrorResponse = new ApiErrorResponse(description,
                String.valueOf(status.value()), ex.getClass().getName(), ex.getMessage(), stackTrace);
        return new ResponseEntity<>(apiErrorResponse, status);
    }
}

