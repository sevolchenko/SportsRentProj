package vsu.csf.rentyserver.configuration.properties;

import java.time.Duration;

public record FineProperties(

        Double percent,

        Duration per

) {
}
