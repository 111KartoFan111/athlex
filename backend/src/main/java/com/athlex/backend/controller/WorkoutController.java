package com.athlex.backend.controller;

import com.athlex.backend.entity.Workout;
import com.athlex.backend.entity.enums.Level;
import com.athlex.backend.service.WorkoutService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/workouts")
public class WorkoutController {

    private final WorkoutService workoutService;

    public WorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    @GetMapping
    public ResponseEntity<List<Workout>> getAllWorkouts(
            @RequestParam(required = false) Level level,
            @RequestParam(required = false) Long sportId) {
        if (sportId != null) {
            return ResponseEntity.ok(workoutService.getWorkoutsBySport(sportId));
        }
        if (level != null) {
            return ResponseEntity.ok(workoutService.getWorkoutsByLevel(level));
        }
        return ResponseEntity.ok(workoutService.getAllWorkouts());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Workout> getWorkoutById(@PathVariable Long id) {
        return ResponseEntity.ok(workoutService.getWorkoutById(id));
    }
}
