package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vsu.csf.rentyserver.model.entity.AppUser;

import java.util.Optional;

public interface AppUsersRepository extends JpaRepository<AppUser, Long> {

    Optional<AppUser> findByEmail(String email);

}
