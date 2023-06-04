package vsu.csf.rentyserver.component;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import vsu.csf.rentyserver.model.entity.Category;
import vsu.csf.rentyserver.model.entity.Product;

import java.util.HashSet;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class CatalogProcessor {

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

    @Transactional(readOnly = true)
    public Set<Category> getChildrenCategories(Category category) {
        if (category == null) {
            return null;
        }

        return findRecursive(category, new HashSet<>());
    }

    private Set<Category> findRecursive(Category category, Set<Category> res) {

        res.add(category);

        if (category.getChildCategories() != null) {
            category.getChildCategories().forEach((child) -> findRecursive(child, res));
        }

        return res;
    }



}
