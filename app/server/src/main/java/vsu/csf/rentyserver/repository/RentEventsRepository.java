package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;

@Repository
public interface RentEventsRepository extends JpaRepository<RentEvent, Long> {

    List<RentEvent> findRentEventsByUser_userIdEqualsAndStatusIsIn(Long userId, Set<RentStatus> statuses);

    @Query("select e from RentEvent e where (e.size = :size and e.startTime < :startTime and (e.endTime > :endTime or e.status = 'EXPIRED'))")
    List<RentEvent> findRelatedEvents(Size size, OffsetDateTime startTime, OffsetDateTime endTime);

    List<RentEvent> findRentEventsByStatusIsIn(Set<RentStatus> statuses);

}
