package com.athlex.backend.repository;

import com.athlex.backend.entity.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    @EntityGraph(attributePaths = {"primarySport"})
    Optional<User> findByEmail(String email);

    @Override
    @EntityGraph(attributePaths = {"primarySport"})
    List<User> findAll();

    boolean existsByEmail(String email);
}
