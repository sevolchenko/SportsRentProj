package vsu.csf.rentyserver.model.dto.catalog.response.list;

import vsu.csf.rentyserver.model.dto.catalog.response.ImageResponse;

import java.util.List;

public record ImageListResponse(

        List<ImageResponse> images,

        Integer size

) {
}
