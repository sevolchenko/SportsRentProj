package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import vsu.csf.rentyserver.model.entity.Product;

@Component
@RequiredArgsConstructor
public class ProductProcessor {

    private final RentProcessor rentProcessor;

    public Integer countOfAvailableSizes(Product product) {
        if (product.getSizes() == null) {
            return 0;
        }
        return product.getSizes()
                .stream()
                .mapToInt(rentProcessor::countOfAvailableNow)
                .sum();
    }

}
