package vsu.csf.rentyserver.model.dto.response.list;

import vsu.csf.rentyserver.model.dto.response.CategoryResponse;

import java.util.List;

public record CategoryListResponse(

        List<CategoryResponse> categories,

        Integer size

) {
}
