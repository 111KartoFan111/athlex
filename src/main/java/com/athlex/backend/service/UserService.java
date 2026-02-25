package com.athlex.backend.service;

import com.athlex.backend.dto.user.DashboardStatsResponse;
import com.athlex.backend.dto.user.UserProfileSetupRequest;
import com.athlex.backend.entity.Sport;
import com.athlex.backend.entity.User;
import com.athlex.backend.entity.WorkoutLog;
import com.athlex.backend.repository.SportRepository;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.repository.WorkoutLogRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final SportRepository sportRepository;
    private final WorkoutLogRepository workoutLogRepository;

    public UserService(UserRepository userRepository, SportRepository sportRepository, WorkoutLogRepository workoutLogRepository) {
        this.userRepository = userRepository;
        this.sportRepository = sportRepository;
        this.workoutLogRepository = workoutLogRepository;
    }

    @Transactional
    public void setupProfile(String email, UserProfileSetupRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        if (request.primarySportId() != null) {
            Sport sport = sportRepository.findById(request.primarySportId())
                    .orElseThrow(() -> new IllegalArgumentException("Sport not found"));
            user.setPrimarySport(sport);
        }

        user.setLevel(request.level());
        user.setGoal(request.goal());
        userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public DashboardStatsResponse getDashboardStats(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        List<WorkoutLog> logs = workoutLogRepository.findByUserId(user.getId());

        int totalCalories = logs.stream().mapToInt(WorkoutLog::getCaloriesBurned).sum();
        int totalDuration = logs.stream().mapToInt(WorkoutLog::getDuration).sum();

        return new DashboardStatsResponse(
                user.getCurrentStreak(),
                user.getRankTitle(),
                totalCalories,
                totalDuration
        );
    }
}
