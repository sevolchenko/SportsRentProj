package vsu.csf.rentyserver.model.dto.catalog.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ProductsSorting {

    DEFAULT("productId"),

    NAME("name"),

    PRICE("price");

    private final String columnName;

}
