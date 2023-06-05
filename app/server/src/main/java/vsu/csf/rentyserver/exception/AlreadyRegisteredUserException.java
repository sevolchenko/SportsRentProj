package vsu.csf.rentyserver.exception;

import org.springframework.security.core.AuthenticationException;

public class AlreadyRegisteredUserException extends AuthenticationException {

    public AlreadyRegisteredUserException(String username) {
        super("User already registered: %s".formatted(username));
    }

}
