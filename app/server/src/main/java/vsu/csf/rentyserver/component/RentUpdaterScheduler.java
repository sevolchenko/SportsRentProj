package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
public class RentUpdaterScheduler {

    private final RentProcessor rentProcessor;
    private final ScheduledExecutorService executor;

    public void addRentTrack(Long rentId, OffsetDateTime startTime, OffsetDateTime endTime) {
        executor.schedule(
                () -> {
                    log.info("Start rent {} called", rentId);
                    rentProcessor.startRent(rentId);
                },
                Duration.between(OffsetDateTime.now(), startTime).toMillis(),
                TimeUnit.MILLISECONDS
        );

        executor.schedule(
                () -> {
                    log.info("Exprire rent {} called", rentId);
                    rentProcessor.expireRent(rentId);
                },
                Duration.between(OffsetDateTime.now(), endTime).toMillis(),
                TimeUnit.MILLISECONDS
        );
    }
}
