package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.repository.RentEventRepository;

import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;

@Component
@RequiredArgsConstructor
public class RentProcessor {

    private final RentEventRepository eventRepository;

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

    public Integer countOfAvailableAt(Size size, OffsetDateTime time) {
        return countOfAvailableAt(size, time, time);
    }

    public Integer countOfAvailableNow(Size size) {
        return countOfAvailableAt(size, OffsetDateTime.now());
    }

}
