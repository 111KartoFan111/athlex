package com.athlex.backend.controller;

import com.athlex.backend.dto.AdminChallengeRequest;
import com.athlex.backend.entity.Challenge;
import com.athlex.backend.service.ChallengeService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/admin/challenges")
@PreAuthorize("hasRole('ADMIN')")
public class AdminChallengeController {

    private final ChallengeService challengeService;

    public AdminChallengeController(ChallengeService challengeService) {
        this.challengeService = challengeService;
    }

    @GetMapping
    public ResponseEntity<List<Challenge>> getAllChallenges() {
        return ResponseEntity.ok(challengeService.getAllChallenges());
    }

    @PostMapping
    public ResponseEntity<Challenge> createChallenge(@Valid @RequestBody AdminChallengeRequest request) {
        Challenge challenge = challengeService.createChallenge(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(challenge);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Challenge> updateChallenge(@PathVariable Long id, @Valid @RequestBody AdminChallengeRequest request) {
        Challenge challenge = challengeService.updateChallenge(id, request);
        return ResponseEntity.ok(challenge);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteChallenge(@PathVariable Long id) {
        challengeService.deleteChallenge(id);
        return ResponseEntity.noContent().build();
    }
}
