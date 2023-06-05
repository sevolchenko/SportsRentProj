package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.catalog.response.CategoryResponse;
import vsu.csf.rentyserver.model.entity.Category;

import java.util.List;

@Mapper(config = MapperConfiguration.class)
public interface CategoryMapper {

    CategoryResponse map(Category category);


    List<CategoryResponse> map(List<Category> categories);
}
