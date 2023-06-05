package vsu.csf.rentyserver.util;

import org.springframework.data.jpa.domain.Specification;
import vsu.csf.rentyserver.model.entity.Category;
import vsu.csf.rentyserver.model.entity.Product;

import java.util.Collection;

public final class ProductSpecifications {

    private ProductSpecifications() {
    }

    public static Specification<Product> buildSpec(String search, Collection<Category> categories,
                                                   Integer minPrice, Integer maxPrice){
        Specification<Product> spec = Specification.where(null);

        if (search != null && !search.isEmpty()) {
            spec = spec.and(nameContains(search));
        }

        if (minPrice != null) {
            spec = spec.and(priceGreaterThan(minPrice));
        }

        if (maxPrice != null) {
            spec = spec.and(priceLessThan(maxPrice));
        }

        if (categories != null) {
            spec = spec.and(categoryIn(categories));
        }

        return spec;
    }

    private static Specification<Product> priceGreaterThan(Integer price) {
        return (root, query, builder) -> builder.greaterThan(root.get("price"), price);
    }

    private static Specification<Product> priceLessThan(Integer price) {
        return (root, query, builder) -> builder.lessThan(root.get("price"), price);
    }

    private static Specification<Product> nameContains(String name) {
        return (root, query, builder) -> builder.like(builder.lower(root.get("name")), "%" + name.toLowerCase() + "%");
    }

    private static Specification<Product> categoryIn(Collection<Category> categories) {
        return (root, query, criteriaBuilder) -> root.get("category").in(categories);
    }
}
