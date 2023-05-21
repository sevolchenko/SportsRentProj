package vsu.csf.rentyserver.model.dto.catalog.response.list;

import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;

import java.util.List;

public record SizeListResponse(

        List<SizeResponse> sizes,

        Integer size

) {
}
