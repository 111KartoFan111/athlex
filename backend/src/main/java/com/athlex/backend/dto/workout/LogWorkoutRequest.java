package com.athlex.backend.dto.workout;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record LogWorkoutRequest(
        @NotNull Long workoutId,
        @NotNull @Min(1) Integer durationMin,
        @NotNull @Min(0) Integer caloriesBurned,
        @NotNull @Min(1) Integer performanceScore
) {}
