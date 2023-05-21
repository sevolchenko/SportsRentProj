package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.model.dto.catalog.response.ImageResponse;
import vsu.csf.rentyserver.model.dto.catalog.response.list.ImageListResponse;
import vsu.csf.rentyserver.model.entity.Image;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ImageMapper {

    @Mapping(target = "productId", source = "imageId.product.productId")
    @Mapping(target = "position", source = "imageId.position")
    ImageResponse map(Image image);

    List<ImageResponse> map(List<Image> images);

    default ImageListResponse fromList(List<Image> images) {
        return fromListResponse(map(images));
    }

    default ImageListResponse fromListResponse(List<ImageResponse> images) {
        if (images == null) {
            return new ImageListResponse(List.of(), 0);
        }
        return new ImageListResponse(images, images.size());
    }

}
