package com.athlex.backend.repository;

import com.athlex.backend.entity.Workout;
import com.athlex.backend.entity.enums.Level;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WorkoutRepository extends JpaRepository<Workout, Long> {

    @Override
    @EntityGraph(attributePaths = {"sport", "exercises"})
    Optional<Workout> findById(Long id);

    @EntityGraph(attributePaths = {"sport"})
    List<Workout> findByLevel(Level level);

    @Override
    @EntityGraph(attributePaths = {"sport"})
    List<Workout> findAll();
    
    @EntityGraph(attributePaths = {"sport"})
    List<Workout> findByEquipmentNeededContainingIgnoreCase(String equipment);
}
