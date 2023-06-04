package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.component.RentProcessor;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptItemResponse;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.util.DurationUtils;

import java.time.Duration;
import java.util.List;

@Mapper(config = MapperConfiguration.class,
        uses = {
                ProductMapper.class,
                UserMapper.class,
                SizeMapper.class
        },
        imports = {
                Duration.class,
                DurationUtils.class
        })
public abstract class RentMapper {

    @Autowired
    RentProcessor rentProcessor;

    @Mapping(target = "receiptId", source = "receipt.receiptId")
    @Mapping(target = "exceptedDuration",
            expression = "java(rentProcessor.countExceptedDuration(rentEvent))")
    @Mapping(target = "prettyDuration",
            expression = "java(DurationUtils.formatDuration(exceptedDuration))")
    public abstract RentResponse map(RentEvent rentEvent);

    public abstract List<RentResponse> map(List<RentEvent> rentEvents);

    @Mapping(target = "exceptedDuration",
            expression = "java(rentProcessor.countExceptedDuration(rentEvent))")
    @Mapping(target = "factDuration",
            expression = "java(rentProcessor.countFactDuration(rentEvent))")
    @Mapping(target = "prettyDuration",
            expression = "java(DurationUtils.formatDuration(factDuration))")
    @Mapping(target = "fine",
            expression = "java(rentProcessor.countFine(rentEvent))")
    public abstract ReceiptItemResponse mapToReceiptItem(RentEvent rentEvent);

    public abstract List<ReceiptItemResponse> mapToReceiptItem(List<RentEvent> rentEvents);

}
