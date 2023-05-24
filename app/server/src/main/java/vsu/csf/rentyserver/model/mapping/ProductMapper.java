package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductPreviewResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;
import vsu.csf.rentyserver.model.entity.Product;

import java.util.List;

@Mapper(config = MapperConfiguration.class,
        uses = {
                SizeMapper.class,
                CategoryMapper.class,
                ImageMapper.class
        })
public interface ProductMapper {


    ProductResponse map(Product product);

    List<ProductResponse> map(List<Product> products);

    // TODO: 12.05.2023 fill busyNow
    @Mapping(target = "busyNow", expression = "java(false)")
    @Mapping(target = "mainImage",
            expression = "java(product.getImages() != null ? imageMapper.map(product.getImages().get(0)) : null)")
    ProductPreviewResponse mapToPreview(Product product);

    List<ProductPreviewResponse> mapToPreview(List<Product> products);
}

