package vsu.csf.rentyserver.configuration;

import org.joda.time.format.PeriodFormatter;
import org.joda.time.format.PeriodFormatterBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JodaConfiguration {
    // TODO: 31.05.2023 make it more pretty
    @Bean
    public PeriodFormatter periodFormatter() {
        return new PeriodFormatterBuilder()
                .appendDays()
                .appendSuffix("days")
                .appendHours()
                .appendSuffix("hours")
                .appendMinutes()
                .appendSuffix("minutes")
                .toFormatter();
    }

}
