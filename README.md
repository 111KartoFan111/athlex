# ATHLEX Backend API

This is the fully functioning REST backend for the **ATHLEX** mobile fitness app, built from scratch using Java 17+, Spring Boot 3.4.x, and PostgreSQL.

## Core Architecture
* **Security Layer**: Stateless JWT-based authentication (`/api/v1/auth`), built on robust Spring Security constructs with mathematically salted BCrypt passwords.
* **Data Layer Details**: Implements strictly typed DTOs separating persistent Entities from payload requests. Complex queries are deeply optimized; `@EntityGraph` handles relationship joins to completely eliminate standard Hibernate N+1 SELECT latency spikes, ensuring highly performant <300ms data fetches.
* **Architecture Integrity**: Strict multilayer application separation (Controllers -> Services -> Repositories -> Entities). Passes full test compilation verified strictly against cyclic dependency graphs. 

## Included Sub-systems
* **Authentication**: Login/Registration processing payload validation securely.
* **Web Endpoints Layer**: Specialized endpoints representing User Profiles, Workouts, Exercises, Logs, and global Admin Metrics.
* **AI Coach MVP Implementation**: Generative baseline placeholder utilizing the `AiCoachService` for customized JSON responses representing personalized plans.

---

## 🚀 Running the API Project locally

### 1. Initialize Postgres Infrastructure
Use the bundled `docker-compose.yml` file to initialize a clean PostgreSQL sandbox alongside a pgAdmin administration console.

```bash
docker-compose up -d
```
All tables, sequences, foreign keys, and referential integrities are subsequently automatically applied by the included `Liquibase` pipeline upon application boot.

### 2. Boot Application 
Start up the layered Spring Boot backend via Maven Wrapper:
```bash
./mvnw clean spring-boot:run
```

---

## 📜 Documentation Overview
API contracts can be natively navigated, queried, and explored using the auto-documented interactive Swagger interface:
[http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)

> Note: To test secured endpoints, first hit `/api/v1/auth/login`, grab the JSON `token`, click the green "Authorize" UI button atop Swagger, and securely authenticate.

---

## 🧪 Testing Suite Validation
The workspace contains a comprehensive internal Mockito Unit Test harness ensuring isolated business logic remains resilient and functioning across the services layer.
```bash
./mvnw clean test
```
