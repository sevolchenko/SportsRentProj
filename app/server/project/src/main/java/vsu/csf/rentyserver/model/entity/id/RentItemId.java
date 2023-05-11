package vsu.csf.rentyserver.model.entity.id;

import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.RentEvent;
import vsu.csf.rentyserver.model.entity.Size;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
@Accessors(chain = true)
@Embeddable
public class RentItemId implements Serializable {

    @ManyToOne
    @JoinColumn(name = "rent_id")
    private RentEvent rentEvent;

    @ManyToOne
    @MapsId("size_pkey")
    private Size size;

}
