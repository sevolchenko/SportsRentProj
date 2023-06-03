package vsu.csf.rentyserver.component;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.repository.RentEventsRepository;

import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.Set;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
public class RentUpdaterScheduler {

    private final RentProcessor rentProcessor;
    private final ScheduledExecutorService executor;

    private final RentEventsRepository rentEventsRepository;

    @PostConstruct
    private void setUp() {
        var rents = rentEventsRepository.findRentEventsByStatusIsIn(Set.of(RentStatus.CREATED, RentStatus.ONGOING));

        rents.forEach((rentEvent -> addRentTrack(
                rentEvent.getRentId(), rentEvent.getStartTime(), rentEvent.getEndTime()
        )));
    }

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
