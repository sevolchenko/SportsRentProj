package vsu.csf.rentyserver;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import vsu.csf.rentyserver.configuration.ApplicationConfig;

@SpringBootApplication
@EnableConfigurationProperties(ApplicationConfig.class)
@Slf4j
public class ProjectApplication {

    public static void main(String[] args) {
        var ctx = SpringApplication.run(ProjectApplication.class, args);
        ApplicationConfig config = ctx.getBean(ApplicationConfig.class);
        log.info("{}", config);
    }

}
