package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.id.RentItemId;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "rent_item")
public class RentItem {

    @EmbeddedId
    private RentItemId rentItemId;

    @Column(name = "count")
    private Integer count;

    @Column(name = "price")
    private Integer price;

    @ManyToOne
    @JoinColumn(name = "receipt_id")
    private Receipt receipt;

}
