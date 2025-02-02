package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vsu.csf.rentyserver.model.entity.Receipt;
import vsu.csf.rentyserver.model.entity.enumeration.ReceiptStatus;

import java.util.List;
import java.util.Set;
import java.util.UUID;

public interface ReceiptsRepository extends JpaRepository<Receipt, UUID> {

    List<Receipt> findAllByUserUserIdAndStatusIsIn(Long userId, Set<ReceiptStatus> statuses);

}
