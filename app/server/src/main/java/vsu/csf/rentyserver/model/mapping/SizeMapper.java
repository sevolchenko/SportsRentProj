package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.component.RentProcessor;
import vsu.csf.rentyserver.model.dto.response.SizeResponse;
import vsu.csf.rentyserver.model.dto.response.list.SizeListResponse;
import vsu.csf.rentyserver.model.entity.Size;

import java.util.List;

@Mapper(componentModel = "spring")
public abstract class SizeMapper {

    @Autowired
    RentProcessor rentProcessor;

    @Mapping(target = "productId", source = "sizeId.product.productId")
    @Mapping(target = "sizeName", source = "sizeId.name")
    @Mapping(target = "countAvailableNow", expression = "java(rentProcessor.getCountOfAvailable(size))")
    public abstract SizeResponse map(Size size);

    public abstract List<SizeResponse> map(List<Size> list);

    public SizeListResponse fromList(List<Size> list) {
        return fromListResponse(map(list));
    }

    public SizeListResponse fromListResponse(List<SizeResponse> list) {
        if (list == null) {
            return new SizeListResponse(List.of(), 0);
        }
        return new SizeListResponse(list, list.size());
    }

}
