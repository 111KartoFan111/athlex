package com.athlex.backend.service;

import com.athlex.backend.entity.User;
import com.athlex.backend.entity.Workout;
import com.athlex.backend.entity.WorkoutLog;
import com.athlex.backend.entity.enums.Level;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.repository.WorkoutLogRepository;
import com.athlex.backend.repository.WorkoutRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class WorkoutServiceTest {

    @Mock
    private WorkoutRepository workoutRepository;
    @Mock
    private WorkoutLogRepository workoutLogRepository;
    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private WorkoutService workoutService;

    @Test
    void getWorkoutsByLevel_returnsList() {
        Workout w = new Workout();
        w.setLevel(Level.BEGINNER);
        when(workoutRepository.findByLevel(Level.BEGINNER)).thenReturn(List.of(w));

        List<Workout> result = workoutService.getWorkoutsByLevel(Level.BEGINNER);
        assertEquals(1, result.size());
    }

    @Test
    void logWorkout_success() {
        User user = new User();
        user.setId(1L);
        user.setCurrentStreak(0);

        Workout workout = new Workout();
        workout.setId(2L);

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(workoutRepository.findById(2L)).thenReturn(Optional.of(workout));

        workoutService.logWorkout(1L, 2L, 45, 400, 85);

        verify(workoutLogRepository).save(any(WorkoutLog.class));
        verify(userRepository).save(user);
        assertEquals(1, user.getCurrentStreak());
        assertEquals("Beginner", user.getRankTitle());
    }
}
