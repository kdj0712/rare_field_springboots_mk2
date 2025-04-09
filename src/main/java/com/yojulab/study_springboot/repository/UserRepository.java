package com.yojulab.study_springboot.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.yojulab.study_springboot.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUserID(String userID);
}
