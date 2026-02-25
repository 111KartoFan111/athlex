package com.athlex.backend.service;

import com.athlex.backend.dto.user.DashboardStatsResponse;
import com.athlex.backend.dto.user.UserProfileSetupRequest;
import com.athlex.backend.entity.User;
import com.athlex.backend.entity.WorkoutLog;
import com.athlex.backend.entity.enums.Level;
import com.athlex.backend.repository.SportRepository;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.repository.WorkoutLogRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private SportRepository sportRepository;
    @Mock
    private WorkoutLogRepository workoutLogRepository;

    @InjectMocks
    private UserService userService;

    @Test
    void setupProfile_success() {
        UserProfileSetupRequest request = new UserProfileSetupRequest(null, Level.INTERMEDIATE, "Lose weight");
        User user = new User();
        user.setEmail("test@test.com");

        when(userRepository.findByEmail("test@test.com")).thenReturn(Optional.of(user));

        userService.setupProfile("test@test.com", request);

        assertEquals(Level.INTERMEDIATE, user.getLevel());
        assertEquals("Lose weight", user.getGoal());
        verify(userRepository).save(user);
    }

    @Test
    void getDashboardStats_success() {
        User user = new User();
        user.setId(1L);
        user.setEmail("test@test.com");
        user.setCurrentStreak(5);
        user.setRankTitle("Beginner");

        WorkoutLog log1 = new WorkoutLog();
        log1.setCaloriesBurned(300);
        log1.setDuration(30);

        WorkoutLog log2 = new WorkoutLog();
        log2.setCaloriesBurned(200);
        log2.setDuration(20);

        when(userRepository.findByEmail("test@test.com")).thenReturn(Optional.of(user));
        when(workoutLogRepository.findByUserId(1L)).thenReturn(List.of(log1, log2));

        DashboardStatsResponse stats = userService.getDashboardStats("test@test.com");

        assertEquals(5, stats.currentStreak());
        assertEquals("Beginner", stats.rankTitle());
        assertEquals(500, stats.totalCaloriesBurned());
        assertEquals(50, stats.totalDurationMin());
    }
}
