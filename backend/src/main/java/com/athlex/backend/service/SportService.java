package com.athlex.backend.service;

import com.athlex.backend.entity.Sport;
import com.athlex.backend.repository.SportRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SportService {

    private final SportRepository sportRepository;

    public SportService(SportRepository sportRepository) {
        this.sportRepository = sportRepository;
    }

    public List<Sport> getAllSports() {
        return sportRepository.findAll();
    }
}
