package com.athlex.backend.service;

import com.athlex.backend.entity.User;
import com.athlex.backend.entity.enums.Role;
import com.athlex.backend.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminService {

    private final UserRepository userRepository;

    public AdminService(UserRepository userRepository) {
        this.userRepository = userRepository;
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
        return userRepository.count();
    }
}
