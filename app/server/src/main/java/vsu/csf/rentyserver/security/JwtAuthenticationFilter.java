package vsu.csf.rentyserver.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationFilter extends GenericFilterBean {

    private final JwtTokenProvider jwtTokenProvider;

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        String token = jwtTokenProvider.resolveToken((HttpServletRequest) servletRequest);

        if (token == null) {
            if (!((HttpServletRequest) servletRequest).getServletPath().contains("swagger") &&
                    !((HttpServletRequest) servletRequest).getServletPath().startsWith("/pay") &&
                    !((HttpServletRequest) servletRequest).getServletPath().startsWith("/favicon") &&
                    !((HttpServletRequest) servletRequest).getServletPath().startsWith("/error")
            ) {
                log.warn("Token is null");
            }
        } else if (!jwtTokenProvider.validateToken(token)) {
            log.warn("Token from user {} is invalid", jwtTokenProvider.getUsername(token));

        } else {
            log.info("Token validation for user {} is successful", jwtTokenProvider.getUsername(token));

            try {
                Authentication authentication = jwtTokenProvider.getAuthentication(token);
                if (authentication != null) {
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }

            } catch (AuthenticationException ex) {
                SecurityContextHolder.clearContext();
                throw ex;
            }

        }
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
