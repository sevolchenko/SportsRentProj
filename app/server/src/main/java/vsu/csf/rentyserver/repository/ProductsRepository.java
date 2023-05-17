package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.Product;

import java.util.List;

@Repository
public interface ProductsRepository extends JpaRepository<Product, Long> {

    List<Product> removeProductByProductIdEquals(Long id);

}
