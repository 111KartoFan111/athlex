package com.athlex.backend.service;

import com.athlex.backend.entity.Workout;
import com.athlex.backend.entity.WorkoutLog;
import com.athlex.backend.entity.enums.Level;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.repository.WorkoutLogRepository;
import com.athlex.backend.repository.WorkoutRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class WorkoutService {

    private final WorkoutRepository workoutRepository;
    private final WorkoutLogRepository workoutLogRepository;
    private final UserRepository userRepository;

    public WorkoutService(WorkoutRepository workoutRepository, WorkoutLogRepository workoutLogRepository, UserRepository userRepository) {
        this.workoutRepository = workoutRepository;
        this.workoutLogRepository = workoutLogRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public List<Workout> getWorkoutsByLevel(Level level) {
        return workoutRepository.findByLevel(level);
    }

    @Transactional(readOnly = true)
    public List<Workout> getAllWorkouts() {
        return workoutRepository.findAll();
    }
    
    @Transactional(readOnly = true)
    public Workout getWorkoutById(Long id) {
        return workoutRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Workout not found"));
    }

    @Transactional
    public void logWorkout(Long userId, Long workoutId, int duration, int caloriesBurned, int performanceScore) {
        var user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        var workout = workoutRepository.findById(workoutId)
                .orElseThrow(() -> new IllegalArgumentException("Workout not found"));

        WorkoutLog log = new WorkoutLog();
        log.setUser(user);
        log.setWorkout(workout);
        log.setDate(LocalDateTime.now());
        log.setDuration(duration);
        log.setCaloriesBurned(caloriesBurned);
        log.setPerformanceScore(performanceScore);

        workoutLogRepository.save(log);

        // Update progress parameters
        user.setCurrentStreak(user.getCurrentStreak() + 1);
        if (user.getCurrentStreak() > 10) {
            user.setRankTitle("Pro");
        } else if (user.getCurrentStreak() > 5) {
            user.setRankTitle("Advanced");
        } else {
            user.setRankTitle("Beginner");
        }
        userRepository.save(user);
    }
}
