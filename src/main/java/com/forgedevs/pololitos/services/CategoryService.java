package com.forgedevs.pololitos.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forgedevs.pololitos.models.Category;
import com.forgedevs.pololitos.repositories.CategoryRepository;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    // Method to get all categories (for category selection in forms)
    public List<Category> getAll() {
        return (List<Category>) categoryRepository.findAll();
    }
}
