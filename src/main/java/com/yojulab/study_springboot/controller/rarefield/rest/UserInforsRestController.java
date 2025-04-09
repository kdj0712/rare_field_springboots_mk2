package com.yojulab.study_springboot.controller.rarefield.rest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.yojulab.study_springboot.service.rarefield.users.UserService;

@RestController
@RequestMapping("/r/UserInfors")
public class UserInforsRestController {

    @Autowired
    UserService userService;

    @GetMapping("/selectAll/{user_ID}")
    public ResponseEntity selectAll(@PathVariable String user_ID) {
        Object result = userService.selectAll(user_ID);
        return ResponseEntity.ok().body(result);
    }
}
