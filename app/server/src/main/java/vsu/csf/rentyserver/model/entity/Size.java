package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.id.SizeId;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "size")
public class Size {

    @EmbeddedId
    private SizeId sizeId;

    @Column(name = "total")
    private Integer total;

}
