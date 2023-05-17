package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.springframework.data.annotation.CreatedDate;

import java.time.OffsetDateTime;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "rent_event")
public class RentEvent {

    @Id
    @Column(name = "rent_id")
    private Long rentId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private AppUser user;

    @CreatedDate
    @Column(name = "created_at")
    private OffsetDateTime createdAt;

    @Column(name = "start_time")
    private OffsetDateTime startTime;

    @Column(name = "end_time")
    private OffsetDateTime endTime;

    @Column(name = "status")
    private String status;

}
