package com.yojulab.study_springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.yojulab.study_springboot.service.rarefield.rest.RestTemplateService;
import com.yojulab.study_springboot.service.rarefield.users.UserService;

import java.util.Map;

@Controller
public class MainController {

    @Value("${remote.server.url}")
    private String remoteServerUrl;

    @Value("${root.file.folder}")
    private String rootFileFolder;
    
    @GetMapping("/index")
    public String index() {
        return "forward:/index.html";
    }

    @Autowired
    private UserService userService;

    @Autowired
    private RestTemplateService restTemplateService;

    @GetMapping({ "/", "/home", "/main" })
    public ModelAndView main(ModelAndView modelAndView) {
        // 현재 사용자 Authentication 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 사용자가 인증되었는지 확인
        if (authentication.isAuthenticated()) {
            // Principal 객체에서 UserDetails 인터페이스를 구현한 사용자 정보 가져오기
            Object principal = authentication.getPrincipal();
            UserDetails userDetails = (principal instanceof UserDetails) ? (UserDetails) principal : null;

            if (userDetails != null) {
                // 사용자 이름 가져오기
                String username = userDetails.getUsername();
                String authorities = authentication.getAuthorities().toString();
                // authorities에서 권한 정보 가져오기
                // StringBuilder authorities = new StringBuilder();
                // for (GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
                // authorities.append(grantedAuthority.getAuthority()).append(", ");
                // }
                // 사용자 ID로 뉴스 데이터 가져오기
                Map<String, Object> result = userService.getApiResponseUsingUserHope(username);
                modelAndView.addObject("result", result);
            }
        }
        // modelAndView.addObject("name", "Yojulab!");

        // modelAndView.addObject("remoteServerUrl", remoteServerUrl);
        // // modelAndView.addObject("myimage", "thermometer.png");

        // modelAndView.addObject("imageFolderPath", remoteServerUrl + rootFileFolder);

        modelAndView.setViewName("mainpage");
        return modelAndView;
    }

    // @GetMapping({ "/admin" }) // 관리자 접속하는 곳
    // public ModelAndView admin(ModelAndView modelAndView) {
    //     String viewName = "/WEB-INF/sample/views/admin.jsp";
    //     modelAndView.setViewName(viewName);
    //     return modelAndView;
    // }

    // @GetMapping({ "/manager/read" }) // 관리자 접속하는 곳
    // public ModelAndView manager(ModelAndView modelAndView) {
    //     String viewName = "/WEB-INF/sample/views/manager/read.jsp";
    //     modelAndView.setViewName(viewName);
    //     return modelAndView;
    // }
}
