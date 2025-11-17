package com.yojulab.study_springboot.controller.rarefield.rarediseaseinfo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Controller
public class ProxyController {

    @Value("${naver.client.id}")
    private String naverClientId;

    private final RestTemplate restTemplate;

    public ProxyController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/proxy/naver-maps")
    public ResponseEntity<String> proxyNaverMaps() {
        String apiUrl =  "https://oapi.map.naver.com/openapi/v3/maps.js";
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("ncpClientId", naverClientId);

        HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        ResponseEntity<String> response = restTemplate.exchange(
                uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);

        return ResponseEntity.ok()
                .header("Content-Type", "application/javascript")
                .body(response.getBody());
    }
}