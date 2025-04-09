package com.yojulab.study_springboot.security;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.yojulab.study_springboot.entity.User;
import com.yojulab.study_springboot.service.rarefield.users.UserService;

@Service
public class PrincipalUserService implements UserDetailsService {

    @Autowired
    UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // query select with ID
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("user_ID", username);
        Map<String, Object> resultMap = (Map<String, Object>) userService.selectByUIDWithAuths(dataMap);

        if (resultMap == null || resultMap.isEmpty()) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }

        // User 객체 생성
        User user = new User(resultMap);

        return user;
    }
}
