package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vsu.csf.rentyserver.model.entity.Receipt;

import java.util.UUID;

public interface ReceiptsRepository extends JpaRepository<Receipt, UUID> {
}
