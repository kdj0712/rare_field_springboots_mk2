package com.yojulab.study_springboot.configs;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import java.nio.charset.StandardCharsets;

@Configuration
public class RestTemplateConfig {
 

    @Bean
    public RestTemplate restTemplate() {

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters()
        .add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    
        return restTemplate;
        
    }

    class RequestResponseLoggingInterceptor implements ClientHttpRequestInterceptor {

    @Override
    public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution) throws IOException {

        ClientHttpResponse response = execution.execute(request, body);


        return response;
        }

    }
}
