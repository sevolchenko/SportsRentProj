package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.component.RentProcessor;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.catalog.response.SizeResponse;
import vsu.csf.rentyserver.model.entity.Size;

import java.util.List;

@Mapper(config = MapperConfiguration.class)
public abstract class SizeMapper {

    @Autowired
    RentProcessor rentProcessor;

    @Mapping(target = "productId", source = "sizeId.product.productId")
    @Mapping(target = "sizeName", source = "sizeId.name")
    @Mapping(target = "countAvailableNow", expression = "java(rentProcessor.countOfAvailableNow(size))")
    public abstract SizeResponse map(Size size);

    public abstract List<SizeResponse> map(List<Size> list);

}
