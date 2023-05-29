package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.data.annotation.CreatedDate;
import vsu.csf.rentyserver.model.entity.enumeration.RentStatus;

import java.time.OffsetDateTime;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "rent_event")
public class RentEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rent_id")
    private Long rentId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private AppUser user;

    @Column(name = "start_time")
    private OffsetDateTime startTime;

    @Column(name = "end_time")
    private OffsetDateTime endTime;

    @CreatedDate
    @Column(name = "finished_at")
    private OffsetDateTime finishedAt;

    @CreatedDate
    @Column(name = "created_at")
    private OffsetDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @MapsId("sizeId")
    @JoinColumns({
            @JoinColumn(name="product_id", referencedColumnName="product_id"),
            @JoinColumn(name="size_name", referencedColumnName="name")
    })
    private Size size;

    @Column(name = "count")
    private Integer count;

    @Column(name = "price")
    private Integer price;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private RentStatus status = RentStatus.CREATED;

    @ManyToOne
    @JoinColumn(name = "receipt_id")
    private Receipt receipt;

}
