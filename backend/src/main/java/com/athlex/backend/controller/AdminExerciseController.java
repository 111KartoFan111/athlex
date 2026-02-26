package com.athlex.backend.controller;

import com.athlex.backend.dto.AdminExerciseRequest;
import com.athlex.backend.entity.Exercise;
import com.athlex.backend.service.ExerciseService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/admin/exercises")
@PreAuthorize("hasRole('ADMIN')")
public class AdminExerciseController {

    private final ExerciseService exerciseService;

    public AdminExerciseController(ExerciseService exerciseService) {
        this.exerciseService = exerciseService;
    }

    @PostMapping
    public ResponseEntity<Exercise> createExercise(@Valid @RequestBody AdminExerciseRequest request) {
        Exercise exercise = exerciseService.createExercise(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(exercise);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Exercise> updateExercise(@PathVariable Long id, @Valid @RequestBody AdminExerciseRequest request) {
        Exercise exercise = exerciseService.updateExercise(id, request);
        return ResponseEntity.ok(exercise);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExercise(@PathVariable Long id) {
        exerciseService.deleteExercise(id);
        return ResponseEntity.noContent().build();
    }
}
