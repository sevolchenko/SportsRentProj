package vsu.csf.rentyserver.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import vsu.csf.rentyserver.model.entity.enumeration.Permission;
import vsu.csf.rentyserver.security.JwtAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, JwtAuthenticationFilter jwtAuthenticationFilter) throws Exception {
        return http
                .csrf().disable()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeHttpRequests()

                .requestMatchers(new AntPathRequestMatcher("/swagger-ui/**")).permitAll()
                .requestMatchers(new AntPathRequestMatcher("/v3/api-docs/**")).permitAll()

                .requestMatchers(new AntPathRequestMatcher("/auth/login")).permitAll()
                .requestMatchers(new AntPathRequestMatcher("/auth/logout")).authenticated()

                .requestMatchers(new AntPathRequestMatcher("/users/register")).permitAll()
                .requestMatchers(new AntPathRequestMatcher("/users/me")).authenticated()
                .requestMatchers(new AntPathRequestMatcher("/users/find")).hasAuthority(Permission.WRITE.getPermission())

                .requestMatchers(new AntPathRequestMatcher("/catalog/**", "GET")).permitAll()
                .requestMatchers(new AntPathRequestMatcher("/catalog/**")).hasAuthority(Permission.WRITE.getPermission())

                .requestMatchers(new AntPathRequestMatcher("/rents/my/**")).authenticated()
                .requestMatchers(new AntPathRequestMatcher("/rents/**")).hasAuthority(Permission.WRITE.getPermission())

                .requestMatchers(new AntPathRequestMatcher("/**", "GET")).hasAuthority(Permission.READ.getPermission())
                .requestMatchers(new AntPathRequestMatcher("/**")).hasAuthority(Permission.WRITE.getPermission())
                .and()
                .addFilterAfter(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    public AuthenticationManager authManager(HttpSecurity http)
            throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class).build();
    }

}
