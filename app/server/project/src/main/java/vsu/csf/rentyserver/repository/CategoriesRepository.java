package vsu.csf.rentyserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vsu.csf.rentyserver.model.entity.Category;

import java.util.List;

@Repository
public interface CategoriesRepository extends JpaRepository<Category, Long> {

    List<Category> removeCategoryByCategoryIdEquals(Long categoryId);

}
