package vsu.csf.rentyserver.model.dto.response.list;

import vsu.csf.rentyserver.model.dto.response.ProductProjectionResponse;

import java.util.List;

public record ProductProjectionListResponse(

        List<ProductProjectionResponse> projections,

        Integer size

) {
}
