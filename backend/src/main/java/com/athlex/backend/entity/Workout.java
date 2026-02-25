package com.athlex.backend.entity;

import com.athlex.backend.entity.enums.Level;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "workouts")
public class Workout {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sport_id", nullable = false)
    private Sport sport;

    @Column(nullable = false)
    private String title;

    @Column(name = "duration_min", nullable = false)
    private Integer durationMin;

    @Column(name = "calories")
    private Integer calories;

    @Enumerated(EnumType.STRING)
    @Column(name = "level")
    private Level level;

    @Column(name = "equipment_needed")
    private String equipmentNeeded;

    @Column(name = "is_ai_generated")
    private Boolean isAiGenerated = false;

    @OneToMany(mappedBy = "workout", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Exercise> exercises = new ArrayList<>();

    public Workout() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Sport getSport() {
        return sport;
    }

    public void setSport(Sport sport) {
        this.sport = sport;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getDurationMin() {
        return durationMin;
    }

    public void setDurationMin(Integer durationMin) {
        this.durationMin = durationMin;
    }

    public Integer getCalories() {
        return calories;
    }

    public void setCalories(Integer calories) {
        this.calories = calories;
    }

    public Level getLevel() {
        return level;
    }

    public void setLevel(Level level) {
        this.level = level;
    }

    public String getEquipmentNeeded() {
        return equipmentNeeded;
    }

    public void setEquipmentNeeded(String equipmentNeeded) {
        this.equipmentNeeded = equipmentNeeded;
    }

    public Boolean getAiGenerated() {
        return isAiGenerated;
    }

    public void setAiGenerated(Boolean aiGenerated) {
        isAiGenerated = aiGenerated;
    }

    public List<Exercise> getExercises() {
        return exercises;
    }

    public void setExercises(List<Exercise> exercises) {
        this.exercises = exercises;
    }

    public void addExercise(Exercise exercise) {
        exercises.add(exercise);
        exercise.setWorkout(this);
    }

    public void removeExercise(Exercise exercise) {
        exercises.remove(exercise);
        exercise.setWorkout(null);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Workout workout = (Workout) o;
        return Objects.equals(id, workout.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
