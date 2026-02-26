package com.athlex.backend.service;

import com.athlex.backend.entity.User;
import com.athlex.backend.entity.enums.Role;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.repository.WorkoutLogRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class AdminService {

    private final UserRepository userRepository;
    private final WorkoutLogRepository workoutLogRepository;

    public AdminService(UserRepository userRepository, WorkoutLogRepository workoutLogRepository) {
        this.userRepository = userRepository;
        this.workoutLogRepository = workoutLogRepository;
    }

    @Transactional
    public void updateUserRole(Long userId, Role role) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.setRole(role);
        userRepository.save(user);
    }
    
    @Transactional
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }

    @Transactional(readOnly = true)
    public long getActiveUsersCount() {
        // For simplicity, considering all non-blocked users as active
        return userRepository.count() - userRepository.findAll().stream().filter(u -> Boolean.TRUE.equals(u.getBlocked())).count();
    }

    @Transactional(readOnly = true)
    public long getTotalUsersCount() {
        return userRepository.count();
    }

    @Transactional(readOnly = true)
    public long getCompletedWorkoutsCount() {
        return workoutLogRepository.count();
    }

    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Transactional
    public void blockUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.setBlocked(true);
        userRepository.save(user);
    }

    @Transactional
    public void unblockUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        user.setBlocked(false);
        userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public Map<String, Object> getUserStats(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        long totalWorkouts = workoutLogRepository.findByUserId(user.getId()).size();
        return Map.of(
                "currentStreak", user.getCurrentStreak(),
                "totalWorkouts", totalWorkouts,
                "rankTitle", user.getRankTitle() != null ? user.getRankTitle() : "Unranked"
        );
    }
}
