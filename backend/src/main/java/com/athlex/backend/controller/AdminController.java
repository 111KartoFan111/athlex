package com.athlex.backend.controller;

import com.athlex.backend.entity.enums.Role;
import com.athlex.backend.service.AdminService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @PutMapping("/users/{id}/role")
    public ResponseEntity<Void> updateUserRole(@PathVariable Long id, @RequestParam Role role) {
        adminService.updateUserRole(id, role);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/analytics/users/active")
    public ResponseEntity<Map<String, Long>> getActiveUsersCount() {
        return ResponseEntity.ok(Map.of("activeUsers", adminService.getActiveUsersCount()));
    }
}
