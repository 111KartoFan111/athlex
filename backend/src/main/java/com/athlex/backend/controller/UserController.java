package com.athlex.backend.controller;

import com.athlex.backend.dto.user.DashboardStatsResponse;
import com.athlex.backend.dto.user.UserProfileSetupRequest;
import com.athlex.backend.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/profile")
    public ResponseEntity<Void> setupProfile(Authentication authentication, @RequestBody UserProfileSetupRequest request) {
        String email = authentication.getName();
        userService.setupProfile(email, request);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/dashboard")
    public ResponseEntity<DashboardStatsResponse> getDashboard(Authentication authentication) {
        String email = authentication.getName();
        return ResponseEntity.ok(userService.getDashboardStats(email));
    }
}
