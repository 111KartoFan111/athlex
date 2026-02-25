package com.athlex.backend.dto.user;

import com.athlex.backend.entity.enums.Level;

public record UserProfileSetupRequest(
        Long primarySportId,
        Level level,
        String goal
) {}
