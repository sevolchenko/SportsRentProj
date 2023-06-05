package vsu.csf.rentyserver.component;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.repository.RentEventsRepository;

import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
public class RentUpdaterScheduler {

    private final RentProcessor rentProcessor;
    private final ScheduledExecutorService executor;

    private final RentEventsRepository rentEventsRepository;

    private List<Pair<Long, ScheduledFuture<?>>> expirationTasks;

    @PostConstruct
    private void setUp() {
        expirationTasks = new ArrayList<>();

        var rents = rentEventsRepository.findRentEventsByStatusIsIn(Set.of(RentStatus.CREATED, RentStatus.ONGOING));

        rents.forEach((rentEvent -> addRentTrack(
                rentEvent.getRentId(), rentEvent.getStartTime(), rentEvent.getEndTime()
        )));
    }

    public void addRentTrack(Long rentId, OffsetDateTime startTime, OffsetDateTime endTime) {
        scheduleStart(rentId, startTime);
        scheduleExpiration(rentId, endTime);
    }

    private void scheduleStart(Long rentId, OffsetDateTime startTime) {
        executor.schedule(
                () -> {
                    log.info("Start rent {} called", rentId);
                    rentProcessor.startRent(rentId);
                },
                Duration.between(OffsetDateTime.now(), startTime).toMillis(),
                TimeUnit.MILLISECONDS
        );
    }

    private void scheduleExpiration(Long rentId, OffsetDateTime endTime) {
        var expirationTask = executor.schedule(
                () -> {
                    log.info("Expire rent {} called", rentId);
                    rentProcessor.expireRent(rentId);
                },
                Duration.between(OffsetDateTime.now(), endTime).toMillis(),
                TimeUnit.MILLISECONDS
        );
        expirationTasks.add(Pair.of(rentId, expirationTask));
    }

    public void onProlong(Long rentId, OffsetDateTime endTime) {
        expirationTasks
                .stream()
                .filter((pair) -> pair.getFirst().equals(rentId))
                .findFirst().get()
                .getSecond().cancel(true);

        scheduleExpiration(rentId, endTime);
    }
}
