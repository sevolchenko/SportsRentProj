package vsu.csf.rentyserver.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import vsu.csf.rentyserver.model.entity.enumeration.Role;

@Entity
@Getter
@Setter
@Accessors(chain = true)
@Table(name = "app_user")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,
            generator = "user_sequence")
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "email")
    private String email;

    @Column(name = "name")
    private String name;

    @Column(name = "password")
    private String password;

    @Enumerated(EnumType.STRING)
    private Role role = Role.USER;
}
