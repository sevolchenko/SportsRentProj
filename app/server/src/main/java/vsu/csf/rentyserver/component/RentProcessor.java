package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;
import vsu.csf.rentyserver.repository.RentEventRepository;

import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Component
@Transactional
@RequiredArgsConstructor
@Slf4j
public class RentProcessor {

    private final RentEventRepository eventRepository;

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

    public Integer update() {
        AtomicInteger count = new AtomicInteger();

        var events = eventRepository.findAll();

        events.forEach((rent) -> {
            switch (rent.getStatus()) {
                case CREATED -> {
                    if (rent.getStartTime().isAfter(OffsetDateTime.now())) {
                        log.info("Rent {} started", rent.getRentId());

                        rent.setStatus(RentStatus.ONGOING);
                        count.getAndIncrement();
                    }
                }
                case ONGOING -> {
                    if (rent.getEndTime().isBefore(OffsetDateTime.now())) {
                        log.info("Rent {} expired", rent.getRentId());

                        rent.setStatus(RentStatus.EXPIRED);
                        count.getAndIncrement();
                    }
                }
            }
        });

        return count.get();
    }

}
