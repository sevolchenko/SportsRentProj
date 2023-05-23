package vsu.csf.rentyserver.configuration.properties;

import java.time.Duration;

public record SecurityProperties(

        String secretKey,

        Duration jwtExpiresAfter

) {
}
