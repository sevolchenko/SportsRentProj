package vsu.csf.rentyserver.exception;

import lombok.Getter;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

import java.util.Set;

@Getter
public class WrongRentStatusException extends IllegalStateException{

    public WrongRentStatusException(Long rentId, RentStatus status) {
        this(rentId, status, Set.of(RentStatus.ONGOING, RentStatus.EXPIRED));
    }

    public WrongRentStatusException(Long rentId, RentStatus status, Set<RentStatus> excepted) {
        super("Rent %d have status %s, excepted one of %s"
                .formatted(rentId, status, excepted));

        this.rentId = rentId;
        this.status = status;
    }

    private final Long rentId;
    private final RentStatus status;

}
