package vsu.csf.rentyserver.model.dto.rent.request;

import jakarta.validation.constraints.NotEmpty;

import java.util.List;

public record CreateRentsBatchRequest(

        @NotEmpty
        List<CreateRentRequest> rents

) {
}
