package vsu.csf.rentyserver.model.dto.catalog.response.list;

import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;

import java.util.List;

public record CategoryListResponse(

        List<CategoryResponse> categories,

        Integer size

) {
}
