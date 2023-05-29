package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.model.entity.RentEvent;

import java.util.List;

@Mapper(config = MapperConfiguration.class,
        uses = {
                ProductMapper.class,
                UserMapper.class,
                SizeMapper.class
        })
public interface RentMapper {

    //@Mapping(target = "product", expression = "java(productMapper.mapToPreview(rentEvent.getProduct()))")
    RentResponse map(RentEvent rentEvent);

    List<RentResponse> map(List<RentEvent> rentEvents);
}
