package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.configuration.properties.RentProperties;
import vsu.csf.rentyserver.model.dto.receipt.response.ReceiptItemResponse;

import java.util.List;

@Component
@RequiredArgsConstructor
public class ReceiptProcessor {

    private final RentProperties rentProperties;

    public Integer countSum(List<ReceiptItemResponse> rents) {

        return rents.stream()
                .mapToInt(this::countSum)
                .sum();

    }

    public Integer countSum(ReceiptItemResponse rent) {

        return (int) rent.factDuration().dividedBy(rentProperties.price().per()) *
                rent.price() * rent.count() + rent.fine();

    }

}
