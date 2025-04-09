package com.yojulab.study_springboot.restapis;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.yojulab.study_springboot.service.sample.CarInforsService;

@RestController
@RequestMapping("/r/commonsCode")
public class CommonsCodeRestController {
    @Autowired
    CarInforsService carInforsService;

    @GetMapping("/selectByUID/{UNIQUE_ID}")
    public ResponseEntity selectByUID(@PathVariable String UNIQUE_ID, @RequestBody Map paramMap) {
        Map result = null;
        try {
            result = new HashMap<>();
            result.put("YEAR","per YEAR");
            result.put("CAR_NAME","like CAR_NAME");

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(result);
        }
        return ResponseEntity.ok().body(result);
    }
}
