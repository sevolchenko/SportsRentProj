package vsu.csf.rentyserver.exception;

import lombok.Getter;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

@Getter
public class WrongRentStatusException extends IllegalStateException{

    public WrongRentStatusException(Long rentId, RentStatus status) {
        super("Rent %d have status %s, excepted one of [%s, %s]"
                .formatted(rentId, status, RentStatus.ONGOING, RentStatus.EXPIRED));

        this.rentId = rentId;
        this.status = status;
    }

    private final Long rentId;
    private final RentStatus status;

}
