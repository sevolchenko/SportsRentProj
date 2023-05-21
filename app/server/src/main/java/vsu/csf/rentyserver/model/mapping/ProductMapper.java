package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductProjectionResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.ProductResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.list.ProductListResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.list.ProductProjectionListResponse;
import vsu.csf.rentyserver.model.entity.Product;

import java.util.List;

@Mapper(componentModel = "spring",
        uses = {
                SizeMapper.class,
                CategoryMapper.class,
                ImageMapper.class
        })
public interface ProductMapper {


    ProductResponse map(Product product);

    List<ProductResponse> map(List<Product> products);

    default ProductListResponse fromList(List<Product> products) {
        return fromListResponse(map(products));
    }

    default ProductListResponse fromListResponse(List<ProductResponse> products) {
        if (products == null) {
            return new ProductListResponse(List.of(), 0);
        }
        return new ProductListResponse(products, products.size());
    }

    // TODO: 12.05.2023 fill busyNow
    @Mapping(target = "busyNow", expression = "java(false)")
    @Mapping(target = "mainImage",
            expression = "java(!product.getImages().isEmpty() ? imageMapper.map(product.getImages().get(0)) : null)")
    ProductProjectionResponse mapToProjection(Product product);

    List<ProductProjectionResponse> mapToProjection(List<Product> products);

    default ProductProjectionListResponse fromListToProjection(List<Product> products) {
        return fromListResponseProjection(mapToProjection(products));
    }

    default ProductProjectionListResponse fromListResponseProjection(List<ProductProjectionResponse> projections) {
        if (projections == null) {
            return new ProductProjectionListResponse(List.of(), 0);
        }
        return new ProductProjectionListResponse(projections, projections.size());
    }

}
