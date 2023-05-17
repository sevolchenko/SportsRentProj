package vsu.csf.rentyserver.model.entity.id;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.Product;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
@Accessors(chain = true)
@Embeddable
public class SizeId implements Serializable {

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "name")
    private String name;

}
