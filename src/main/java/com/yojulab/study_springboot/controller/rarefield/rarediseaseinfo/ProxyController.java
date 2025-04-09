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

    @Value("${google.maps.api.key}")
    private String googleApiKey;

    private final RestTemplate restTemplate;

    public ProxyController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/proxy/google-maps")
    public ResponseEntity<String> proxyGoogleMaps() {
        String apiUrl = "https://maps.googleapis.com/maps/api/js";
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("key", googleApiKey)
                .queryParam("language", "ko");


        HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(
                uriBuilder.toUriString(), HttpMethod.GET, entity, String.class);

        return ResponseEntity.ok()
                .header("Content-Type", "application/javascript")
                .body(response.getBody());
    }
}