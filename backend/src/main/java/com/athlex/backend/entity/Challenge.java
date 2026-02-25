package com.athlex.backend.entity;

import jakarta.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "challenges")
public class Challenge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "duration_days", nullable = false)
    private Integer durationDays;

    @Column(name = "target_metric", nullable = false)
    private String targetMetric;

    public Challenge() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(Integer durationDays) {
        this.durationDays = durationDays;
    }

    public String getTargetMetric() {
        return targetMetric;
    }

    public void setTargetMetric(String targetMetric) {
        this.targetMetric = targetMetric;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Challenge challenge = (Challenge) o;
        return Objects.equals(id, challenge.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
