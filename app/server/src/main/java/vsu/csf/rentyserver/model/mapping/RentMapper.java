package vsu.csf.rentyserver.model.mapping;

import org.joda.time.Period;
import org.joda.time.format.PeriodFormatter;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.configuration.properties.FineProperties;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptItemResponse;
import vsu.csf.rentyserver.model.dto.rent.response.RentResponse;
import vsu.csf.rentyserver.model.entity.RentEvent;

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
                Period.class
        })
public abstract class RentMapper {

    @Autowired
    PeriodFormatter periodFormatter;

    @Autowired
    FineProperties fineProperties;

    public abstract RentResponse map(RentEvent rentEvent);

    public abstract List<RentResponse> map(List<RentEvent> rentEvents);

    @Mapping(target = "duration",
            expression = "java(Duration.between(rentEvent.getStartTime(), rentEvent.getFinishedAt()))")
    @Mapping(target = "prettyDuration",
            expression = "java(periodFormatter.print(Period.parse(duration.toString())))")
    @Mapping(target = "fine",
            expression = "java((int) (duration" +
                    ".minus(Duration.between(rentEvent.getStartTime(), rentEvent.getEndTime()))" +
                    ".dividedBy(fineProperties.per()) * rentEvent.getPrice() * fineProperties.percent()" +
                    "))")
    public abstract ReceiptItemResponse mapToReceiptItem(RentEvent rentEvent);

    public abstract List<ReceiptItemResponse> mapToReceiptItem(List<RentEvent> rentEvents);

}
