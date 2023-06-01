package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.Product;

@Component
@RequiredArgsConstructor
public class ProductProcessor {

    private final RentProcessor rentProcessor;

    public Integer countOfAvailableSizes(Product product) {
        return product.getSizes()
                .stream()
                .mapToInt(rentProcessor::countOfAvailableNow)
                .sum();
    }

}
