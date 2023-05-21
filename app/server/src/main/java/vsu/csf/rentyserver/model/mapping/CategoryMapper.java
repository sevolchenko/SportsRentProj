package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.list.CategoryListResponse;
import vsu.csf.rentyserver.model.entity.Category;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CategoryMapper {

    CategoryResponse map(Category category);

    List<CategoryResponse> map(List<Category> categories);

    default CategoryListResponse fromList(List<Category> categories) {
        return fromListResponse(map(categories));
    }

    default CategoryListResponse fromListResponse(List<CategoryResponse> categories) {
        if (categories == null) {
            return new CategoryListResponse(List.of(), 0);
        }
        return new CategoryListResponse(categories, categories.size());
    }
}
