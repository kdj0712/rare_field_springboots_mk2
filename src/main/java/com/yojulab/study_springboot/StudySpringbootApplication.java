package com.yojulab.study_springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication
@ServletComponentScan
@EnableJpaRepositories
public class StudySpringbootApplication {
	public static void main(String[] args) {
		SpringApplication.run(StudySpringbootApplication.class, args);
	}

}
