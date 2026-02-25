package com.athlex.backend.controller;

import com.athlex.backend.dto.workout.LogWorkoutRequest;
import com.athlex.backend.entity.User;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.service.WorkoutService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/progress")
public class ProgressController {

    private final WorkoutService workoutService;
    private final UserRepository userRepository;

    public ProgressController(WorkoutService workoutService, UserRepository userRepository) {
        this.workoutService = workoutService;
        this.userRepository = userRepository;
    }

    @PostMapping("/log")
    public ResponseEntity<Void> logWorkout(Authentication authentication, @Valid @RequestBody LogWorkoutRequest request) {
        User user = userRepository.findByEmail(authentication.getName())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        workoutService.logWorkout(
                user.getId(),
                request.workoutId(),
                request.durationMin(),
                request.caloriesBurned(),
                request.performanceScore()
        );
        return ResponseEntity.ok().build();
    }
}
