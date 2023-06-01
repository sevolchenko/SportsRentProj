package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.component.ProductProcessor;
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
public abstract class ProductMapper {

    @Autowired
    ProductProcessor productProcessor;

    public abstract ProductResponse map(Product product);

    public abstract List<ProductResponse> map(List<Product> products);

    @Mapping(target = "busyNow", expression = "java(productProcessor.countOfAvailableSizes(product) == 0)")
    @Mapping(target = "mainImage",
            expression = "java((product.getImages() != null && product.getImages().size() > 0) ? " +
                    "imageMapper.map(product.getImages().get(0)) : null)")
    public abstract ProductPreviewResponse mapToPreview(Product product);

    public abstract List<ProductPreviewResponse> mapToPreview(List<Product> products);
}

