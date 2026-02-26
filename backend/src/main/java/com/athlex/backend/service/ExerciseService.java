package com.athlex.backend.service;

import com.athlex.backend.dto.AdminExerciseRequest;
import com.athlex.backend.entity.Exercise;
import com.athlex.backend.entity.Workout;
import com.athlex.backend.repository.ExerciseRepository;
import com.athlex.backend.repository.WorkoutRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ExerciseService {

    private final ExerciseRepository exerciseRepository;
    private final WorkoutRepository workoutRepository;

    public ExerciseService(ExerciseRepository exerciseRepository, WorkoutRepository workoutRepository) {
        this.exerciseRepository = exerciseRepository;
        this.workoutRepository = workoutRepository;
    }

    @Transactional
    public Exercise createExercise(AdminExerciseRequest request) {
        Workout workout = workoutRepository.findById(request.getWorkoutId())
                .orElseThrow(() -> new IllegalArgumentException("Workout not found"));

        Exercise exercise = new Exercise();
        exercise.setWorkout(workout);
        exercise.setTitle(request.getTitle());
        exercise.setDescription(request.getDescription());
        exercise.setVideoUrl(request.getVideoUrl());
        exercise.setTargetMuscleGroup(request.getTargetMuscleGroup());
        exercise.setReps(request.getReps());

        return exerciseRepository.save(exercise);
    }

    @Transactional
    public Exercise updateExercise(Long id, AdminExerciseRequest request) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Exercise not found"));

        Workout workout = workoutRepository.findById(request.getWorkoutId())
                .orElseThrow(() -> new IllegalArgumentException("Workout not found"));

        exercise.setWorkout(workout);
        exercise.setTitle(request.getTitle());
        exercise.setDescription(request.getDescription());
        exercise.setVideoUrl(request.getVideoUrl());
        exercise.setTargetMuscleGroup(request.getTargetMuscleGroup());
        exercise.setReps(request.getReps());

        return exerciseRepository.save(exercise);
    }

    @Transactional
    public void deleteExercise(Long id) {
        if (!exerciseRepository.existsById(id)) {
            throw new IllegalArgumentException("Exercise not found");
        }
        exerciseRepository.deleteById(id);
    }
}
