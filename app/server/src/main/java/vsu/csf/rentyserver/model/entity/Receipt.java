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
@Table(name = "receipt")
public class Receipt {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "receipt_id")
    private String receiptId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private AppUser user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private AppUser employee;

    @CreatedDate
    @Column(name = "created_at")
    private OffsetDateTime createdAt;

    @Column(name = "pay_link")
    private String payLink;

    @Column(name = "status")
    private String status;

}
