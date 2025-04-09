package com.yojulab.study_springboot.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Value("${remote.server.url}")
    private String remoteServerUrl;

    @Value("${root.file.folder}")
    private String rootFileFolder;

    // 모든 컨트롤러에서 접근 가능한 모델 속성 추가
    @ModelAttribute("remoteServerUrl")
    public String remoteServerUrl() {
        return remoteServerUrl;
    }

    @ModelAttribute("rootFileFolder")
    public String rootFileFolder() {
        return rootFileFolder;
    }
}