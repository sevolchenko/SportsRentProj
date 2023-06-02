package vsu.csf.rentyserver.model.mapping;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import vsu.csf.rentyserver.component.ReceiptProcessor;
import vsu.csf.rentyserver.configuration.MapperConfiguration;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptResponse;
import vsu.csf.rentyserver.model.entity.Receipt;

import java.util.List;

@Mapper(config = MapperConfiguration.class,
        uses = {
                UserMapper.class,
                RentMapper.class
        })
public abstract class ReceiptMapper {

    @Autowired
    ReceiptProcessor receiptProcessor;

    @Mapping(target = "payLink", expression = "java(\"/pay?=receipt_id%s\".formatted(receipt.getReceiptId()))")
    @Mapping(target = "sum", expression = "java(receiptProcessor.countSum(rents))")
    public abstract ReceiptResponse map(Receipt receipt);

    public abstract List<ReceiptResponse> map(List<Receipt> receipts);
}
