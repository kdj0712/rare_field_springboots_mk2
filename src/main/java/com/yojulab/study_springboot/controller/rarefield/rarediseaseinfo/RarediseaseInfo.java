package com.yojulab.study_springboot.controller.rarefield.rarediseaseinfo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.Gson;
import com.yojulab.study_springboot.utils.Paginations;
import com.yojulab.study_springboot.service.rarefield.rest.RestTemplateService;

@RestController
@RequestMapping("/info")
public class RarediseaseInfo {

    @Autowired
    RestTemplateService restTemplateService;

    @GetMapping("/info_institution")
    public ModelAndView institutionSearch(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String pos,
            @RequestParam(required = false) Integer currentPage) throws Exception {

        ModelAndView modelAndView = new ModelAndView("info/info_institution");
        
        // ⭐ keyword가 없으면 초기 화면
        if (keyword == null || keyword.trim().isEmpty()) {
            modelAndView.addObject("results", new ArrayList<>());
            modelAndView.addObject("jsonResults", "[]");
            modelAndView.addObject("keyword", "");
            modelAndView.addObject("pos", pos != null ? pos : "");
            modelAndView.addObject("paginations", new Paginations(0, 1));
            return modelAndView;
        }

        Integer page = (currentPage != null) ? currentPage : 1;

        System.out.println("========== 검색 시작 ==========");
        System.out.println("keyword: " + keyword);
        System.out.println("pos (original): " + pos);
        System.out.println("currentPage: " + page);

        // ⭐ 핵심: pos를 xPos와 yPos로 분리
        String xPosStr = null;
        String yPosStr = null;
        
        if (pos != null && !pos.trim().isEmpty() && pos.contains(",")) {
            String[] coords = pos.split(",");
            if (coords.length == 2) {
                xPosStr = coords[0].trim();  // 위도
                yPosStr = coords[1].trim();  // 경도
                System.out.println("xPos (위도): " + xPosStr);
                System.out.println("yPos (경도): " + yPosStr);
            }
        }

        // ⭐ RestTemplateService 호출 시 xPos, yPos 전달
        Map<String, Object> result = restTemplateService.institutionSearch(
            page, 
            keyword, 
            xPosStr,  // 위도
            yPosStr   // 경도
        );

        System.out.println("result: " + (result != null ? "존재함" : "null"));

        List<Map<String, Object>> results = null;
        if (result != null) {
            results = (List<Map<String, Object>>) result.get("results");
            System.out.println("검색 결과 개수: " + (results != null ? results.size() : "null"));
        }

        // excellent_info 처리
        if (results != null) {
            for (Map<String, Object> item : results) {
                if (item.containsKey("excellent_info")) {
                    String excellentInfoJson = new Gson().toJson(item.get("excellent_info"));
                    modelAndView.addObject("excellentInfoJson", excellentInfoJson);
                    break;
                }
            }
        }

        // pagination 처리
        int startRecordNumber = 0;
        int totalItems = 0;

        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null) {
                if (pagination.containsKey("start_record_number")) {
                    Object startRecordNumberObj = pagination.get("start_record_number");
                    if (startRecordNumberObj instanceof Number) {
                        startRecordNumber = ((Number) startRecordNumberObj).intValue();
                    }
                }
                if (pagination.containsKey("total_records")) {
                    Object totalRecordsObj = pagination.get("total_records");
                    if (totalRecordsObj instanceof Number) {
                        totalItems = ((Number) totalRecordsObj).intValue();
                    }
                }
            }
        }

        Paginations paginations = new Paginations(totalItems, page);

        String responseBody = (String) result.get("responseBody");
        modelAndView.setViewName("info/info_institution");
        modelAndView.addObject("responseBody", responseBody);
        modelAndView.addObject("StartRecordNumber", startRecordNumber);
        modelAndView.addObject("paginations", paginations);
        modelAndView.addObject("results", results != null ? results : new ArrayList<>());
        modelAndView.addObject("keyword", keyword);
        modelAndView.addObject("pos", pos);
        
        Gson gson = new Gson();
        String jsonResults = gson.toJson(results != null ? results : new ArrayList<>());
        modelAndView.addObject("jsonResults", jsonResults);
        
        System.out.println("jsonResults 길이: " + (results != null ? results.size() : 0));
        System.out.println("========== 검색 완료 ==========");
        
        return modelAndView;
    }

    @GetMapping(value = "/info_raredisease")
    public ModelAndView dise_search(
            @RequestParam(required = false) String key_name,
            @RequestParam(required = false) String search_word,
            @RequestParam(required = false) Integer currentPage,
            ModelAndView modelAndView) {

        Integer page = (currentPage != null) ? currentPage : 1;
        Map<String, Object> result = null;

        int startRecordNumber = 0;
        try {
            result = restTemplateService.dise_search(page, key_name, search_word);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            modelAndView.addObject("error", "데이터 처리 중 오류가 발생했습니다.");
            modelAndView.setViewName("error");
            return modelAndView;
        }

        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("start_record_number")) {
                Object startRecordNumberObj = pagination.get("start_record_number");
                if (startRecordNumberObj instanceof Number) {
                    startRecordNumber = ((Number) startRecordNumberObj).intValue();
                }
            }
        }

        List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");
        int totalItems = 0;
        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("total_records")) {
                Object totalRecordsObj = pagination.get("total_records");
                if (totalRecordsObj instanceof Number) {
                    totalItems = ((Number) totalRecordsObj).intValue();
                }
            }
        }

        Paginations Paginations = new Paginations(totalItems, page);

        String viewPath = "info/info_raredisease";
        modelAndView.setViewName(viewPath);
        modelAndView.addObject("key_name", key_name);
        modelAndView.addObject("search_word", search_word);
        modelAndView.addObject("StartRecordNumber", startRecordNumber);
        modelAndView.addObject("resultList", results);
        modelAndView.addObject("paginations", Paginations);
        return modelAndView;
    }

    @GetMapping(value = "/info_academicinfo")
    public ModelAndView aca_search(
            @RequestParam(required = false) String key_name,
            @RequestParam(required = false) String search_word,
            @RequestParam(required = false) Integer currentPage,
            ModelAndView modelAndView) {

        Integer page = (currentPage != null) ? currentPage : 1;
        Map<String, Object> result = null;

        int startRecordNumber = 0;
        try {
            result = restTemplateService.riss_search(page, key_name, search_word);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            modelAndView.addObject("error", "데이터 처리 중 오류가 발생했습니다.");
            modelAndView.setViewName("error");
            return modelAndView;
        }

        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("start_record_number")) {
                Object startRecordNumberObj = pagination.get("start_record_number");
                if (startRecordNumberObj instanceof Number) {
                    startRecordNumber = ((Number) startRecordNumberObj).intValue();
                }
            }
        }

        List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");
        int totalItems = 0;
        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("total_records")) {
                Object totalRecordsObj = pagination.get("total_records");
                if (totalRecordsObj instanceof Number) {
                    totalItems = ((Number) totalRecordsObj).intValue();
                }
            }
        }

        Paginations Paginations = new Paginations(totalItems, page);

        String viewPath = "info/info_academicinfo";
        modelAndView.setViewName(viewPath);
        modelAndView.addObject("key_name", key_name);
        modelAndView.addObject("search_word", search_word);
        modelAndView.addObject("StartRecordNumber", startRecordNumber);
        modelAndView.addObject("resultList", results);
        modelAndView.addObject("paginations", Paginations);
        return modelAndView;
    }
    
    @GetMapping(value = "/info_academicinfo_pub_med")
    public ModelAndView aca_pubmed_search(
            @RequestParam(required = false) String key_name,
            @RequestParam(required = false) String search_word,
            @RequestParam(required = false) Integer currentPage,
            ModelAndView modelAndView) {

        Integer page = (currentPage != null) ? currentPage : 1;
        Map<String, Object> result = null;

        int startRecordNumber = 0;
        try {
            result = restTemplateService.pubmed_search(page, key_name, search_word);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            modelAndView.addObject("error", "데이터 처리 중 오류가 발생했습니다.");
            modelAndView.setViewName("error");
            return modelAndView;
        }

        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("start_record_number")) {
                Object startRecordNumberObj = pagination.get("start_record_number");
                if (startRecordNumberObj instanceof Number) {
                    startRecordNumber = ((Number) startRecordNumberObj).intValue();
                }
            }
        }

        List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");
        int totalItems = 0;
        if (result != null && result.containsKey("pagination")) {
            Map<String, Object> pagination = (Map<String, Object>) result.get("pagination");
            if (pagination != null && pagination.containsKey("total_records")) {
                Object totalRecordsObj = pagination.get("total_records");
                if (totalRecordsObj instanceof Number) {
                    totalItems = ((Number) totalRecordsObj).intValue();
                }
            }
        }

        Paginations Paginations = new Paginations(totalItems, page);

        String viewPath = "info/info_academicinfo_pubmed";
        modelAndView.setViewName(viewPath);
        modelAndView.addObject("key_name", key_name);
        modelAndView.addObject("search_word", search_word);
        modelAndView.addObject("StartRecordNumber", startRecordNumber);
        modelAndView.addObject("resultList", results);
        modelAndView.addObject("paginations", Paginations);
        return modelAndView;
    }
}