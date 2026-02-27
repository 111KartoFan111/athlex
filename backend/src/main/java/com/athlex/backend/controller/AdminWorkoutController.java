package com.athlex.backend.controller;

import com.athlex.backend.dto.AdminWorkoutRequest;
import com.athlex.backend.entity.Workout;
import com.athlex.backend.service.WorkoutService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/admin/workouts")
@PreAuthorize("hasRole('ADMIN')")
public class AdminWorkoutController {

    private final WorkoutService workoutService;

    public AdminWorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    @GetMapping
    public ResponseEntity<List<Workout>> getAllWorkouts() {
        return ResponseEntity.ok(workoutService.getAllWorkouts());
    }

    @PostMapping
    public ResponseEntity<Workout> createWorkout(@Valid @RequestBody AdminWorkoutRequest request) {
        Workout workout = workoutService.createWorkout(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(workout);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Workout> updateWorkout(@PathVariable Long id, @Valid @RequestBody AdminWorkoutRequest request) {
        Workout workout = workoutService.updateWorkout(id, request);
        return ResponseEntity.ok(workout);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteWorkout(@PathVariable Long id) {
        workoutService.deleteWorkout(id);
        return ResponseEntity.noContent().build();
    }
}
