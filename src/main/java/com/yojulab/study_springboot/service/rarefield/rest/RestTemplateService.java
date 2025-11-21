package com.yojulab.study_springboot.service.rarefield.rest;
import com.yojulab.study_springboot.utils.Paginations;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.json.JSONArray;
import org.json.JSONObject;


@SuppressWarnings("deprecation")
@Service
public class RestTemplateService {
    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private ObjectMapper mapper;


    public List<Map<String,Object>> lawPostRequest() {
    	// 요청을 보낼 URL
        String apiUrl = "http://rare-field.co.kr/trend/trend_law_data";

		// HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
		
        // 요청 데이터 생성
        MultiValueMap<String, String> requestData = new LinkedMultiValueMap<>();
		    requestData.add("key", "value");

		// HTTP POST 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, requestData, String.class);
        
        // 응답 값
        String responseBody = responseEntity.getBody();
        // System.out.println("POST Response: " + responseBody);

        String jsonString = responseBody;
    
        // 가장 큰 JSONObject를 가져옵니다.
        JSONObject jObject = new JSONObject(jsonString);
        // 배열을 가져옵니다.
        JSONArray jArray = jObject.getJSONArray("trend_law");
       
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

        for (int i = 0; i < jArray.length(); i++) {
            JSONObject obj = jArray.getJSONObject(i);
            Map<String, Object> map = new HashMap<>();
        
            for(String key : obj.keySet()) {
                Object value = obj.get(key);
                map.put(key, value);
            }
        
            list.add(map);
        }
        return list;
    }

    
    public Map<String,Object> newsPostRequest(String key_name, String search_word,Integer currentPage, String category) throws JsonProcessingException {
    	// 요청을 보낼 URL
        String baseUrl = "http://rare-field.co.kr/trend/trend_news_data?";

        // page_number=" + currentPage;
        String decodedBaseUrl = URLDecoder.decode(baseUrl, StandardCharsets.UTF_8);

        // UriComponentsBuilder 초기화
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(decodedBaseUrl);
        
        // 조건에 따라 URL에 파라미터 추가
        if (key_name != null && !key_name.isEmpty()) {
            builder.queryParam("key_name", key_name);
        }
        if (search_word != null && !search_word.isEmpty()) {
            builder.queryParam("search_word", search_word);
        }
        if (currentPage != null) {
            builder.queryParam("page_number", currentPage);
        }
        if (category != null) {
            builder.queryParam("category", category);
        }

		// HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");
        // HttpEntity 객체 생성 (여기서는 본문을 비워둘 수 있습니다)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate 초기화
        RestTemplate restTemplate = new RestTemplate();

        // 결과를 저장할 Map 생성
        Map<String, Object> result = new HashMap<>();
        String encodedUrl = builder.toUriString();
        
        // 요청 및 응답
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(encodedUrl, entity, String.class);
        String responseBody = responseEntity.getBody();

        // ObjectMapper 초기화 및 설정
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);

        if (responseMap.containsKey("news")) {
            List<Map<String, Object>> resultList = (List<Map<String, Object>>) responseMap.get("news");
            result.put("newsresult", resultList);
        }
        if (responseMap.containsKey("pagination")) {
            Map<String, Object> paginationMap = (Map<String, Object>) responseMap.get("pagination");
            result.put("pagination", paginationMap);
        }            
        // selected_category와 search_word를 category와 search_word로 변환하여 처리
        if (responseMap.containsKey("selected_category")) {
            String selectedCategory = (String) responseMap.get("selected_category");
            if (selectedCategory != null) {
                result.put("category", selectedCategory);
            } else {
                // selected_category가 null인 경우의 처리
                result.put("category", null);
            }
        } else {
            // 응답에 selected_category가 없는 경우의 처리
            result.put("category", null);
        }

        if (responseMap.containsKey("search_word")) {
            String responseSearchWord = (String) responseMap.get("search_word");
            if (responseSearchWord != null) {
                result.put("search_word", responseSearchWord);
            } else {
                // search_word가 null인 경우의 처리
                result.put("search_word", "No search word provided");
            }
        } else {
            // 응답에 search_word가 없는 경우의 처리
            result.put("search_word", "Search word not found in response");
        }

        return result;
    }

    public Map<String,Object> mainnewsPostRequest(String userhope) {
    	// 요청을 보낼 URL
        String category = null;
        if (userhope.equals("관련 법 사항") || userhope.equals("관련 정책 사항")) {
            category = "의료/법안";
        } else if (userhope.equals("관련 뉴스") || userhope.equals("관련 학술정보")) {
            category = "신약/개발";
        } else if (userhope.equals("프로그램 참여") || userhope.equals("커뮤니티 소통")) {
            category = "심포지엄/행사";
        }

        String apiUrl = "http://rare-field.co.kr/trend/trend_news_data?page_number=1&category=" + category;

		// HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
		
        // 요청 데이터 생성
        MultiValueMap<String, String> requestData = new LinkedMultiValueMap<>();

		requestData.add("key", "value");

		// HTTP POST 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, requestData, String.class);
        
        // 응답 값
        String responseBody = responseEntity.getBody();
        // System.out.println("POST Response: " + responseBody);

        String jsonString = responseBody;
       
        JSONObject jObject = new JSONObject(jsonString);
        JSONArray jArray = jObject.getJSONArray("news");
    
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

        for (int i = 0; i < jArray.length(); i++) {
            JSONObject obj = jArray.getJSONObject(i);
            Map<String, Object> map = new HashMap<>();
        
            for(String key : obj.keySet()) {
                Object value = obj.get(key);
                map.put(key, value);
            }
        
            list.add(map);
        }

        Map<String,Object> result = new HashMap<>();
        result.put("news",list);
        return result;
    }


    public Map<String,Object> newsReadGetRequest(String id) {
    	// 요청을 보낼 URL
        String apiUrl = "http://rare-field.co.kr/trend/trend_news_data/" + id;

		// HTTP POST 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiUrl, String.class);
        
        // 응답 값
        String responseBody = responseEntity.getBody();
        String jsonString = responseBody;
       
        // 가장 큰 JSONObject를 가져옵니다.
        JSONObject jObject = new JSONObject(jsonString);
        JSONObject newsObject = jObject.getJSONObject("news");

        Map<String,Object> result = new HashMap<>();
        result.put("id",newsObject.optString("_id"));
        result.put("news_title",newsObject.optString("news_title"));
        result.put("news_datetime",newsObject.optString("news_datetime"));
        result.put("news_contents", newsObject.optString("news_contents"));
        result.put("news_url",newsObject.optString("news_url"));
        result.put("news_topic",newsObject.optString("news_topic"));
        result.put("news_paper",newsObject.optString("news_paper"));
        result.put("news_image",newsObject.optString("news_image"));

        return result;

    }
    
    public Map<String,Object> readguideline(String id) {
    	// 요청을 보낼 URL
        String apiUrl = "http://rare-field.co.kr/trend/guideline_read/" + id;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");

        // HttpEntity 객체 생성 (여기서는 본문을 비워둘 수 있습니다)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate 초기화
        RestTemplate restTemplate = new RestTemplate();

        // 결과를 저장할 Map 생성
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, entity, String.class);
        String responseBody = responseEntity.getBody();

        String jsonString = responseBody;
       
        // 가장 큰 JSONObject를 가져옵니다.
        JSONObject jObject = new JSONObject(jsonString);
        JSONObject guideObject = jObject.getJSONObject("guidelines");

        Map<String,Object> result = new HashMap<>();
        result.put("id",guideObject.optString("_id"));
        result.put("importance",guideObject.optString("importance"));
        result.put("post_cate",guideObject.optString("post_cate"));
        result.put("post_title", guideObject.optString("post_title"));
        result.put("order_number",guideObject.optString("order_number"));
        result.put("post_file_name",guideObject.optString("post_file_name"));
        result.put("post_contents",guideObject.optString("post_contents"));
        result.put("date_legislation",guideObject.optString("date_legislation"));
        result.put("date_start",guideObject.optString("date_start"));

        return result;

    }
    


    public Map<String, Object> institutionSearch(Integer currentPage, String keyword, String pos) throws Exception {
        String baseUrl = "http://rare-field.co.kr/info/institution?";

        String decodedBaseUrl = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("page_number", currentPage)
                .queryParam("keyword", keyword)
                .queryParam("pos", pos)
                .toUriString();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");

        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<String> responseEntity = restTemplate.postForEntity(decodedBaseUrl, entity, String.class);
        String responseBody = responseEntity.getBody();

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);

        Map<String, Object> result = new HashMap<>();
        if (responseMap.containsKey("results")) {
            List<Map<String, Object>> results = (List<Map<String, Object>>) responseMap.get("results");
            result.put("results", results);
        }

        if (responseMap.containsKey("pagination")) {
            Map<String, Object> paginationMap = (Map<String, Object>) responseMap.get("pagination");
            result.put("pagination", paginationMap);
        }

        result.put("responseBody",responseBody);

        return result;
    }


    public Map<String, Object> dise_search(Integer currentPage, String key_name, String search_word) throws JsonProcessingException {
        // 기본 URL 설정
        String baseUrl = "http://rare-field.co.kr/info/raredisease?";
        
        // URL 디코딩
        String decodedBaseUrl = URLDecoder.decode(baseUrl, StandardCharsets.UTF_8);

        // UriComponentsBuilder 초기화
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(decodedBaseUrl);

        // 조건에 따라 URL에 파라미터 추가
        if (currentPage != null) {
            builder.queryParam("page_number", currentPage);
        }
        if (key_name != null && !key_name.isEmpty()) {
            builder.queryParam("key_name", key_name);
        }
        if (search_word != null && !search_word.isEmpty()) {
            builder.queryParam("search_word", search_word);
        }

        // HttpHeaders 객체 생성 및 Content-Type 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");

        // HttpEntity 객체 생성 (여기서는 본문을 비워둘 수 있습니다)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate 초기화
        RestTemplate restTemplate = new RestTemplate();

        // 결과를 저장할 Map 생성
        Map<String, Object> result = new HashMap<>();
        String encodedUrl = builder.toUriString();

        try {
            // 요청 및 응답
            ResponseEntity<String> responseEntity = restTemplate.postForEntity(encodedUrl, entity, String.class);
            String responseBody = responseEntity.getBody();

            // ObjectMapper 초기화 및 설정
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

            Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);

            if (responseMap.containsKey("dise_list")) {
                List<Map<String, Object>> resultList = (List<Map<String, Object>>) responseMap.get("dise_list");
                result.put("results", resultList);
            }
            if (responseMap.containsKey("pagination")) {
                Map<String, Object> paginationMap = (Map<String, Object>) responseMap.get("pagination");
                result.put("pagination", paginationMap);
            }
        } catch (RestClientException e) {
            // 예외 처리
            result.put("error", "Failed to fetch data: " + e.getMessage());
        }

        return result;
    }

    public List<Map<String, Object>> guideLine() {
        // 요청을 보낼 URL
        String apiUrl = "http://rare-field.co.kr/trend/trend_guideline_data";

        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 요청 데이터 생성
        MultiValueMap<String, String> requestData = new LinkedMultiValueMap<>();
        requestData.add("key", "value");

        // HTTP POST 요청 보내기
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestData, headers);
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, request, String.class);

        // 응답 값
        String responseBody = responseEntity.getBody();

        // 가장 큰 JSONObject를 가져옵니다.
        JSONObject jObject = new JSONObject(responseBody);
        // 배열을 가져옵니다.
        JSONArray jArray = jObject.getJSONArray("trend_guideline");

        List<Map<String, Object>> list = new ArrayList<>();

        for (int i = 0; i < jArray.length(); i++) {
            JSONObject obj = jArray.getJSONObject(i);
            Map<String, Object> map = new HashMap<>();

            for (String key : obj.keySet()) {
                Object value = obj.opt(key); // opt를 사용하여 key가 없을 경우 null 반환
                if (value != JSONObject.NULL) { // null이 아닌 값만 추가
                    map.put(key, value);
                }
            }

            list.add(map);
        }
        return list;
    }


    public Map<String, Object> riss_search(Integer currentPage, String key_name, String search_word) throws JsonProcessingException {
        // 기본 URL 설정
        String baseUrl = "http://rare-field.co.kr/info/academicinfo?";
        
        // URL 디코딩
        String decodedBaseUrl = URLDecoder.decode(baseUrl, StandardCharsets.UTF_8);

        // UriComponentsBuilder 초기화
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(decodedBaseUrl);

        // 조건에 따라 URL에 파라미터 추가
        if (currentPage != null) {
            builder.queryParam("page_number", currentPage);
        }
        if (key_name != null && !key_name.isEmpty()) {
            builder.queryParam("key_name", key_name);
        }
        if (search_word != null && !search_word.isEmpty()) {
            builder.queryParam("search_word", search_word);
        }

        // HttpHeaders 객체 생성 및 Content-Type 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");

        // HttpEntity 객체 생성 (여기서는 본문을 비워둘 수 있습니다)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate 초기화
        RestTemplate restTemplate = new RestTemplate();

        // 결과를 저장할 Map 생성
        Map<String, Object> result = new HashMap<>();
        String encodedUrl = builder.toUriString();

        try {
            // 요청 및 응답
            ResponseEntity<String> responseEntity = restTemplate.postForEntity(encodedUrl, entity, String.class);
            String responseBody = responseEntity.getBody();

            // ObjectMapper 초기화 및 설정
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

            Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);

            if (responseMap.containsKey("papers")) {
                List<Map<String, Object>> resultList = (List<Map<String, Object>>) responseMap.get("papers");
                result.put("results", resultList);
            }
            if (responseMap.containsKey("pagination")) {
                Map<String, Object> paginationMap = (Map<String, Object>) responseMap.get("pagination");
                result.put("pagination", paginationMap);
            }
        } catch (RestClientException e) {
            // 예외 처리
            result.put("error", "Failed to fetch data: " + e.getMessage());
        }

        return result;
    }
    public Map<String, Object> pubmed_search(Integer currentPage, String key_name, String search_word) throws JsonProcessingException {
        // 기본 URL 설정
        String baseUrl = "http://rare-field.co.kr/info/academicinfo_pub_med?";
        
        // URL 디코딩
        String decodedBaseUrl = URLDecoder.decode(baseUrl, StandardCharsets.UTF_8);

        // UriComponentsBuilder 초기화
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(decodedBaseUrl);

        // 조건에 따라 URL에 파라미터 추가
        if (currentPage != null) {
            builder.queryParam("page_number", currentPage);
        }
        if (key_name != null && !key_name.isEmpty()) {
            builder.queryParam("key_name", key_name);
        }
        if (search_word != null && !search_word.isEmpty()) {
            builder.queryParam("search_word", search_word);
        }

        // HttpHeaders 객체 생성 및 Content-Type 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.set("Accept-Encoding", "gzip, deflate, br");
        headers.set("Connection", "keep-alive");

        // HttpEntity 객체 생성 (여기서는 본문을 비워둘 수 있습니다)
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // RestTemplate 초기화
        RestTemplate restTemplate = new RestTemplate();

        // 결과를 저장할 Map 생성
        Map<String, Object> result = new HashMap<>();
        String encodedUrl = builder.toUriString();

        try {
            // 요청 및 응답
            ResponseEntity<String> responseEntity = restTemplate.postForEntity(encodedUrl, entity, String.class);
            String responseBody = responseEntity.getBody();

            // ObjectMapper 초기화 및 설정
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

            Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);

            if (responseMap.containsKey("papers")) {
                List<Map<String, Object>> resultList = (List<Map<String, Object>>) responseMap.get("papers");
                result.put("results", resultList);
            }
            if (responseMap.containsKey("pagination")) {
                Map<String, Object> paginationMap = (Map<String, Object>) responseMap.get("pagination");
                result.put("pagination", paginationMap);
            }
        } catch (RestClientException e) {
            // 예외 처리
            result.put("error", "Failed to fetch data: " + e.getMessage());
        }

        return result;
    }
}
