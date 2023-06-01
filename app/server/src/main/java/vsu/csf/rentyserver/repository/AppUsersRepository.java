package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.AppUser;

import java.util.Optional;

@Repository
public interface AppUsersRepository extends JpaRepository<AppUser, Long> {

    Optional<AppUser> findByEmail(String email);

}
