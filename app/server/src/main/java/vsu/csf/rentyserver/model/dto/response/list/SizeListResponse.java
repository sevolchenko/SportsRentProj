package vsu.csf.rentyserver.model.dto.response.list;

import vsu.csf.rentyserver.model.dto.response.SizeResponse;

import java.util.List;

public record SizeListResponse(

        List<SizeResponse> sizes,

        Integer size

) {
}
