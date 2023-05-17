package vsu.csf.rentyserver.model.dto.response.list;

import vsu.csf.rentyserver.model.dto.response.ProductResponse;

import java.util.List;

public record ProductListResponse(

        List<ProductResponse> products,

        Integer size

) {
}
