package com.athlex.backend.service;

import com.athlex.backend.dto.AdminChallengeRequest;
import com.athlex.backend.entity.Challenge;
import com.athlex.backend.repository.ChallengeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChallengeService {

    private final ChallengeRepository challengeRepository;

    public ChallengeService(ChallengeRepository challengeRepository) {
        this.challengeRepository = challengeRepository;
    }

    @Transactional
    public Challenge createChallenge(AdminChallengeRequest request) {
        Challenge challenge = new Challenge();
        challenge.setTitle(request.getTitle());
        challenge.setDescription(request.getDescription());
        challenge.setDurationDays(request.getDurationDays());
        challenge.setTargetMetric(request.getTargetMetric());

        return challengeRepository.save(challenge);
    }

    @Transactional
    public Challenge updateChallenge(Long id, AdminChallengeRequest request) {
        Challenge challenge = challengeRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Challenge not found"));

        challenge.setTitle(request.getTitle());
        challenge.setDescription(request.getDescription());
        challenge.setDurationDays(request.getDurationDays());
        challenge.setTargetMetric(request.getTargetMetric());

        return challengeRepository.save(challenge);
    }

    @Transactional
    public void deleteChallenge(Long id) {
        if (!challengeRepository.existsById(id)) {
            throw new IllegalArgumentException("Challenge not found");
        }
        challengeRepository.deleteById(id);
    }
}
