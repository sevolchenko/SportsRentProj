package vsu.csf.rentyserver.model.dto.catalog.response.list;

import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;

import java.util.List;

public record ProductListResponse(

        List<ProductResponse> products,

        Integer size

) {
}
