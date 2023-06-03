package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.configuration.properties.RentProperties;
import vsu.csf.rentyserver.exception.NoSuchElementException;
import vsu.csf.rentyserver.exception.WrongRentStatusException;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.repository.RentEventsRepository;

import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;

@Component
@Transactional
@RequiredArgsConstructor
@Slf4j
public class RentProcessor {

    private final RentEventsRepository eventRepository;

    private final RentProperties rentProperties;


    @Transactional(readOnly = true)
    public Integer countOfAvailableAt(Size size, OffsetDateTime startTime, OffsetDateTime endTime) {

        var relatedEvents = eventRepository.findRentEventsBySizeEqualsAndStartTimeBeforeAndEndTimeAfter(
                size, endTime, startTime);

        var allRelatedEnds = OffsetDateTime.MIN;

        var countOfBusy = 0;

        for (RentEvent event : relatedEvents) {

            if (!event.getStartTime().isBefore(allRelatedEnds)) {
                countOfBusy = Math.max(event.getCount(), countOfBusy);
            } else {
                countOfBusy += event.getCount();
            }

            allRelatedEnds = Collections.max(List.of(allRelatedEnds, event.getEndTime()));

        }

        return size.getTotal() - countOfBusy;
    }

    @Transactional(readOnly = true)
    public Integer countOfAvailableAt(Size size, OffsetDateTime time) {
        return countOfAvailableAt(size, time, time);
    }

    @Transactional(readOnly = true)
    public Integer countOfAvailableNow(Size size) {
        return countOfAvailableAt(size, OffsetDateTime.now());
    }


    public void startRent(Long rentId) {
        var rent = eventRepository.findById(rentId)
                .orElseThrow(() -> new NoSuchElementException("rent", RentEvent.class, rentId));

        if (rent.getStatus() != RentStatus.CREATED) {
            throw new WrongRentStatusException(rentId, rent.getStatus());
        }
        rent.setStatus(RentStatus.ONGOING);

        log.info("Rent {} started", rentId);
    }

    public void expireRent(Long rentId) {

        var rent = eventRepository.findById(rentId)
                .orElseThrow(() -> new NoSuchElementException("rent", RentEvent.class, rentId));

        if (rent.getStatus() == RentStatus.AWAITING_PAYMENT || rent.getStatus() == RentStatus.FINISHED) {
            log.info("Rent {} already finished", rentId);
            return;
        }

        if (rent.getStatus() != RentStatus.ONGOING) {
            throw new WrongRentStatusException(rentId, rent.getStatus());
        }

        rent.setStatus(RentStatus.EXPIRED);

        log.info("Rent {} expired", rentId);
    }

    public Duration countExceptedDuration(RentEvent rentEvent) {
        return Duration.between(rentEvent.getStartTime(), rentEvent.getEndTime()).withNanos(0);
    }

    public Duration countFactDuration(RentEvent rentEvent) {
        if (rentEvent.getFinishedAt() == null) {
            return null;
        }
        return Duration.between(rentEvent.getStartTime(), rentEvent.getFinishedAt()).withNanos(0);
    }

    public Integer countFine(RentEvent rentEvent) {

        var duration = countFactDuration(rentEvent);

        if (duration == null) {
            return 0;
        }

        return (int) (duration
                .minus(Duration.between(rentEvent.getStartTime(), rentEvent.getEndTime()))
                .dividedBy(rentProperties.fine().per()) *
                rentEvent.getPrice() * rentProperties.fine().percent());
    }

}
