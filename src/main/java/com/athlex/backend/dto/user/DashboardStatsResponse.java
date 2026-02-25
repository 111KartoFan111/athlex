package com.athlex.backend.dto.user;

public record DashboardStatsResponse(
        Integer currentStreak,
        String rankTitle,
        Integer totalCaloriesBurned,
        Integer totalDurationMin
) {}
