package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.Size;
import vsu.csf.rentyserver.model.entity.id.SizeId;

import java.util.List;

@Repository
public interface SizesRepository extends JpaRepository<Size, SizeId> {

    List<Size> removeSizeBySizeIdEquals(SizeId sizeId);

}
