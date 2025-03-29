package com.forgedevs.pololitos.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.forgedevs.pololitos.models.Category;

@Repository
public interface CategoryRepository extends CrudRepository<Category, Long> {
    
    Category findByName(String name);

    List<Category> findAll();
}
