package com.athlex.backend.service;

import com.athlex.backend.dto.auth.AuthRequest;
import com.athlex.backend.dto.auth.RegisterRequest;
import com.athlex.backend.entity.User;
import com.athlex.backend.repository.UserRepository;
import com.athlex.backend.security.JwtService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AuthServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private JwtService jwtService;
    @Mock
    private AuthenticationManager authenticationManager;

    @InjectMocks
    private AuthService authService;

    @Test
    void register_success() {
        RegisterRequest request = new RegisterRequest("test@test.com", "password");
        when(userRepository.existsByEmail(request.email())).thenReturn(false);
        when(passwordEncoder.encode(request.password())).thenReturn("hashed");
        when(jwtService.generateToken(any())).thenReturn("token");

        var response = authService.register(request);

        assertNotNull(response.token());
        assertEquals("token", response.token());
        verify(userRepository).save(any(User.class));
    }

    @Test
    void login_success() {
        AuthRequest request = new AuthRequest("test@test.com", "password");
        User user = new User();
        user.setEmail(request.email());
        user.setPasswordHash("hashed");

        when(userRepository.findByEmail(request.email())).thenReturn(Optional.of(user));
        when(jwtService.generateToken(any())).thenReturn("token");

        var response = authService.login(request);

        assertNotNull(response.token());
        assertEquals("token", response.token());
        verify(authenticationManager).authenticate(any());
    }
}
