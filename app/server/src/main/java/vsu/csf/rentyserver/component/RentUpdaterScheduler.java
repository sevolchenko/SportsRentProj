package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class RentUpdaterScheduler {

    private final RentProcessor rentProcessor;

    @Scheduled(fixedDelayString = "#{@rentCheckDelay}")
    private void update() {
        log.info("Checking for rents updates");

        rentProcessor.update();
    }
}
