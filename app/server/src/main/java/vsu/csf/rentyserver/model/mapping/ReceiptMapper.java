package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;
import vsu.csf.rentyserver.model.entity.Receipt;

@Mapper(config = MapperConfiguration.class,
        uses = {
                UserMapper.class,
                RentMapper.class
        })
public interface ReceiptMapper {

    @Mapping(target = "payLink", expression = "java(\"/pay?=%s\".formatted(receipt.getReceiptId()))")
    @Mapping(target = "sum", expression = "java(rents.stream().mapToInt((rent) -> rent.price() * rent.count() + rent.fine()).sum())")
    ReceiptResponse map(Receipt receipt);

}
