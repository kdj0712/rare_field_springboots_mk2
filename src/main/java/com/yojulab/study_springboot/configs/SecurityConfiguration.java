package com.yojulab.study_springboot.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    public String[] ENDPOINTS_WHITELIST = {
            "/css/**", "/js/**", "/", "/home", "/main"
    };

    @SuppressWarnings("removal")
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        // None using csrf protection
        httpSecurity.csrf().disable();
        
        // CORS 설정 추가
        httpSecurity.cors();

        // 권한에 대한 부분 : url & roles : user url & roles
        // url, roles from Dao
        httpSecurity.authorizeHttpRequests() // 로그인
                .requestMatchers("/manager*").hasAnyRole("ADMIN", "MANAGER")
                .requestMatchers("/admin*").hasRole("ADMIN")
                .requestMatchers("/empo_community/insert", "/empo_community/updateread", 
                                 "/empo_community/update", "/empo_community/list_pagination").authenticated()
                .requestMatchers("/carInfor/map/*").hasRole("USER")
                .anyRequest().permitAll();
        
        httpSecurity.formLogin(login -> login.loginPage("/user_login")
                        .failureUrl("/login?fail=true")
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/"));
        httpSecurity.logout(logout -> logout
                        .logoutSuccessUrl("/main")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID"));

        return httpSecurity.build();
    }

    @Bean
    public BCryptPasswordEncoder encoderPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOriginPatterns("*")
                        .allowedMethods("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS")
                        .allowedHeaders("*")
                        .allowCredentials(true)
                        .maxAge(3600);
            }
        };
    }
    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true);
        return firewall;
    }
}
