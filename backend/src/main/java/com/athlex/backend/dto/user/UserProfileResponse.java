package com.athlex.backend.dto.user;

import com.athlex.backend.entity.Sport;
import com.athlex.backend.entity.enums.Level;
import com.athlex.backend.entity.enums.Role;

public record UserProfileResponse(
    Long id,
    String email,
    Role role,
    Level level,
    Sport primarySport,
    String goal,
    Integer currentStreak,
    String rankTitle,
    Boolean isBlocked
) {}
