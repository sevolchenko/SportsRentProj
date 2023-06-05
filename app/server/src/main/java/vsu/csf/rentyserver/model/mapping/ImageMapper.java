package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.catalog.response.ImageResponse;
import vsu.csf.rentyserver.model.entity.Image;

import java.util.List;

@Mapper(config = MapperConfiguration.class)
public interface ImageMapper {

    @Mapping(target = "productId", source = "imageId.product.productId")
    @Mapping(target = "position", source = "imageId.position")
    ImageResponse map(Image image);

    List<ImageResponse> map(List<Image> images);

}
