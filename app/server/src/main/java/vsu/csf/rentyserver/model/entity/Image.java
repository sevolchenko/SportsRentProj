package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.id.ImageId;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "image")
public class Image {

    @EmbeddedId
    private ImageId imageId;

    @Column(name = "img_bytes")
    private byte[] imgBytes;

}
