package com.athlex.backend.controller;

import com.athlex.backend.entity.User;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.service.AiCoachService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/ai-coach")
public class AiCoachController {

    private final AiCoachService aiCoachService;
    private final UserRepository userRepository;

    public AiCoachController(AiCoachService aiCoachService, UserRepository userRepository) {
        this.aiCoachService = aiCoachService;
        this.userRepository = userRepository;
    }

    @GetMapping("/adaptive-plan")
    public ResponseEntity<String> getAdaptivePlan(Authentication authentication) {
        User user = userRepository.findByEmail(authentication.getName())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        return ResponseEntity.ok(aiCoachService.generateAdaptiveWorkoutPlan(user.getId()));
    }
}
