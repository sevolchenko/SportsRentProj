package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.model.dto.response.ImageResponse;
import vsu.csf.rentyserver.model.entity.Image;

@Mapper(componentModel = "spring")
public interface ImageMapper {

    @Mapping(target = "productId", source = "imageId.product.productId")
    @Mapping(target = "position", source = "imageId.position")
    ImageResponse map(Image image);

}
