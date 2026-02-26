package com.athlex.backend.controller;

import com.athlex.backend.entity.User;
import com.athlex.backend.entity.enums.Role;
import com.athlex.backend.service.AdminService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @PutMapping("/users/{id}/role")
    public ResponseEntity<Void> updateUserRole(@PathVariable Long id, @RequestParam Role role) {
        adminService.updateUserRole(id, role);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/users/{id}/block")
    public ResponseEntity<Void> blockUser(@PathVariable Long id) {
        adminService.blockUser(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/users/{id}/unblock")
    public ResponseEntity<Void> unblockUser(@PathVariable Long id) {
        adminService.unblockUser(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/users/{id}/stats")
    public ResponseEntity<Map<String, Object>> getUserStats(@PathVariable Long id) {
        return ResponseEntity.ok(adminService.getUserStats(id));
    }

    @GetMapping("/analytics/dashboard")
    public ResponseEntity<Map<String, Object>> getDashboardAnalytics() {
        return ResponseEntity.ok(Map.of(
            "totalUsers", adminService.getTotalUsersCount(),
            "activeUsers", adminService.getActiveUsersCount(),
            "completedWorkouts", adminService.getCompletedWorkoutsCount()
        ));
    }
}
