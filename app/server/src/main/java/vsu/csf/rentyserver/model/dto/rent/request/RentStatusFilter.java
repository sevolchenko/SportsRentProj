package vsu.csf.rentyserver.model.dto.rent.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

import java.util.Set;

@Getter
@RequiredArgsConstructor
public enum RentStatusFilter {

    ALL(Set.of(RentStatus.values())),

    ONGOING(Set.of(RentStatus.ONGOING, RentStatus.EXPIRED)),

    NOT_FINISHED(Set.of(RentStatus.CREATED, RentStatus.ONGOING, RentStatus.EXPIRED));

    private final Set<RentStatus> events;

}
