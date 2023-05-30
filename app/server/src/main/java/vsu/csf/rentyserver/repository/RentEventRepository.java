package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;

@Repository
public interface RentEventRepository extends JpaRepository<RentEvent, Long> {

    List<RentEvent> findRentEventsByUser_userIdEquals(Long userId);

    List<RentEvent> findRentEventsByUser_userIdEqualsAndStatusIsIn(Long userId, Set<RentStatus> statuses);

    List<RentEvent> findRentEventsBySizeEqualsAndStartTimeBeforeAndEndTimeAfter(
            Size size, OffsetDateTime startTime, OffsetDateTime endTime);

}
