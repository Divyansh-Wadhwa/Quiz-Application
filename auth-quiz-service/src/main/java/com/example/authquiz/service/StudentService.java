package com.example.authquiz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.authquiz.model.Student;
import com.example.authquiz.repository.StudentRepository;

@Service
public class StudentService {
    @Autowired
    private StudentRepository repo;

    public Student save(Student student) {
        return repo.save(student);
    }

    public Student findByUsername(String username) {
        return repo.findByUsername(username);
    }

    public Student findByEmail(String email) {
        return repo.findByEmail(email);
    }

    public List<Student> findAll() {
        return repo.findAll();
    }

    public long count() {
        return repo.count();
    }

    public Student findById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public Student update(Student updatedStudent) {
        // First get the existing student
        Student existingStudent = repo.findById(updatedStudent.getId()).orElse(null);
        if (existingStudent == null) {
            return null;
        }

        // Only update fields that are provided (not null)
        if (updatedStudent.getUsername() != null && !updatedStudent.getUsername().trim().isEmpty()) {
            existingStudent.setUsername(updatedStudent.getUsername());
        }

        if (updatedStudent.getPassword() != null && !updatedStudent.getPassword().trim().isEmpty()) {
            existingStudent.setPassword(updatedStudent.getPassword());
        }

        if (updatedStudent.getEmail() != null && !updatedStudent.getEmail().trim().isEmpty()) {
            existingStudent.setEmail(updatedStudent.getEmail());
        }

        // Update any other fields if they exist
        // Note: Add other field updates here as needed

        return repo.save(existingStudent);
    }

    public void deleteById(Long id) {
        repo.deleteById(id);
    }

    public boolean existsById(Long id) {
        return repo.existsById(id);
    }
}
