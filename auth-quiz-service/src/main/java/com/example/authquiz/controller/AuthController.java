package com.example.authquiz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.authquiz.model.Student;
import com.example.authquiz.security.JwtUtil;
import com.example.authquiz.service.StudentService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private StudentService service;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Student student) {
        try {
            // Check if username already exists
            if (service.findByUsername(student.getUsername()) != null) {
                return ResponseEntity.status(409)
                        .body(java.util.Collections.singletonMap("error", "Username already exists"));
            }

            // Check if email already exists
            if (service.findByEmail(student.getEmail()) != null) {
                return ResponseEntity.status(409)
                        .body(java.util.Collections.singletonMap("error", "Email already exists"));
            }

            Student saved = service.save(student);
            return ResponseEntity.ok(java.util.Collections.singletonMap("message", "Registration successful"));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(java.util.Collections.singletonMap("error", "Registration failed"));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Student student) {
        Student dbStudent = service.findByUsername(student.getUsername());
        if (dbStudent != null && dbStudent.getPassword() != null
                && dbStudent.getPassword().equals(student.getPassword())) {
            String token = jwtUtil.generateToken(dbStudent.getUsername());
            return ResponseEntity.ok(java.util.Collections.singletonMap("token", token));
        }
        return ResponseEntity.status(401).body(java.util.Collections.singletonMap("error", "Invalid credentials"));
    }

    // Admin endpoints for user management
    @GetMapping("/admin/users")
    public ResponseEntity<?> getAllUsers() {
        try {
            List<Student> users = service.findAll();
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(java.util.Collections.singletonMap("error", "Failed to fetch users"));
        }
    }

    @GetMapping("/admin/users/count")
    public ResponseEntity<?> getUserCount() {
        try {
            Map<String, Object> response = new HashMap<>();
            response.put("count", service.count());
            response.put("total", service.count());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(java.util.Collections.singletonMap("error", "Failed to get user count"));
        }
    }

    // Get specific user by ID
    @GetMapping("/admin/users/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        try {
            Student user = service.findById(id);
            if (user != null) {
                return ResponseEntity.ok(user);
            } else {
                return ResponseEntity.status(404).body(java.util.Collections.singletonMap("error", "User not found"));
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).body(java.util.Collections.singletonMap("error", "Failed to fetch user"));
        }
    }

    // Update user
    @PutMapping("/admin/users/{id}")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @RequestBody Student updatedUser) {
        try {
            if (!service.existsById(id)) {
                return ResponseEntity.status(404).body(java.util.Collections.singletonMap("error", "User not found"));
            }

            updatedUser.setId(id); // Ensure the ID is set
            Student savedUser = service.update(updatedUser);
            return ResponseEntity.ok(savedUser);
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(java.util.Collections.singletonMap("error", "Failed to update user"));
        }
    }

    // Delete user
    @DeleteMapping("/admin/users/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Long id) {
        try {
            if (!service.existsById(id)) {
                return ResponseEntity.status(404).body(java.util.Collections.singletonMap("error", "User not found"));
            }

            service.deleteById(id);
            return ResponseEntity.ok(java.util.Collections.singletonMap("message", "User deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(java.util.Collections.singletonMap("error", "Failed to delete user"));
        }
    }

    // Toggle user status (placeholder - since we don't have status field yet)
    @PutMapping("/admin/users/{id}/toggle-status")
    public ResponseEntity<?> toggleUserStatus(@PathVariable Long id) {
        try {
            if (!service.existsById(id)) {
                return ResponseEntity.status(404).body(java.util.Collections.singletonMap("error", "User not found"));
            }

            // For now, just return success since we don't have status field in the model
            return ResponseEntity.ok(java.util.Collections.singletonMap("message", "User status updated"));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(java.util.Collections.singletonMap("error", "Failed to update user status"));
        }
    }

    @Configuration
    public class WebConfig implements WebMvcConfigurer {
        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry.addMapping("/**")
                    .allowedOrigins("http://127.0.0.1:3000", "http://localhost:5500", "http://127.0.0.1:5500")
                    .allowedMethods("GET", "POST", "PUT", "DELETE")
                    .allowedHeaders("*")
                    .allowCredentials(true);
        }
    }

}
