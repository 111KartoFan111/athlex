package com.athlex.backend.repository;

import com.athlex.backend.entity.WorkoutLog;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WorkoutLogRepository extends JpaRepository<WorkoutLog, Long> {

    @EntityGraph(attributePaths = {"user", "workout", "workout.sport"})
    List<WorkoutLog> findByUserId(Long userId);
}
