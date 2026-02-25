package com.athlex.backend.service;

import org.springframework.stereotype.Service;

@Service
public class AiCoachService {

    // MVP Implementation returning a mock JSON adaptive plan
    public String generateAdaptiveWorkoutPlan(Long userId) {
        return """
        {
            "planName": "AI Adaptive Session",
            "sessions": [
                {"name": "Warm-up", "duration": "5 min"},
                {"name": "Main Set", "duration": "30 min", "exercises": ["Push-ups", "Squats"]},
                {"name": "Finisher", "duration": "10 min", "exercises": ["Plank"]}
            ]
        }
        """;
    }
}
