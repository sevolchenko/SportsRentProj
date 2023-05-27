package vsu.csf.rentyserver.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;
import vsu.csf.rentyserver.model.entity.Permission;

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
            log.warn("Token is null");

        } else if (!jwtTokenProvider.validateToken(token)) {
            log.warn("Token from user {} is invalid", jwtTokenProvider.getUsername(token));

        } else {
            log.info("Token validation for user {} is successful", jwtTokenProvider.getUsername(token));

            Authentication authentication = jwtTokenProvider.getAuthentication(token);

            if (authentication != null) {

                if (servletRequest.getParameter("user_id") != null) {
                    var authUser = ((SecurityUser) authentication.getPrincipal());
                    Long userId = authUser.getUserId();
                    Long asksForUserId = Long.parseLong(servletRequest.getParameter("user_id"));

                    log.info("User id {} with authorities {} is trying to access {}'s data",
                            userId, authUser.getAuthorities(), asksForUserId);

                    if (authentication.isAuthenticated()) {

                        if (authentication.getAuthorities().contains(Permission.WRITE.getAuthority()) ||
                                (authentication.getAuthorities().contains(Permission.READ.getAuthority()) &&
                                        userId.equals(asksForUserId))) {
                            SecurityContextHolder.getContext().setAuthentication(authentication);
                        }
                    }

                } else {
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }

            }

        }


        filterChain.doFilter(servletRequest, servletResponse);
    }
}
