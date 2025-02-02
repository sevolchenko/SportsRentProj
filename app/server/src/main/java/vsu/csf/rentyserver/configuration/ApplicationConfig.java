package vsu.csf.rentyserver.configuration;

import jakarta.validation.constraints.NotNull;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.validation.annotation.Validated;
import vsu.csf.rentyserver.configuration.properties.RentProperties;
import vsu.csf.rentyserver.configuration.properties.SecurityProperties;

@Validated
@ConfigurationProperties(prefix = "application", ignoreUnknownFields = false)
public record ApplicationConfig(

        @NotNull SecurityProperties security,

        @NotNull RentProperties rent

) {

    @Bean
    public SecurityProperties securityProperties() {
        return security;
    }

    @Bean
    public RentProperties rentProperties() {
        return rent;
    }

}
