package vsu.csf.rentyserver.model.dto.catalog.response.list;

import vsu.csf.rentyserver.model.dto.catalog.response.ProductProjectionResponse;

import java.util.List;

public record ProductProjectionListResponse(

        List<ProductProjectionResponse> projections,

        Integer size

) {
}
