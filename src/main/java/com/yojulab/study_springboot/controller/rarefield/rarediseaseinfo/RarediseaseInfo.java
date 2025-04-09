package com.yojulab.study_springboot.controller.rarefield.rarediseaseinfo;

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

        if ((keyword == null || keyword.isEmpty()) && (pos == null || pos.isEmpty())) {
            return modelAndView;
        }

        int startRecordNumber = 0;
        Integer page = (currentPage != null) ? currentPage : 1;

        Map<String, Object> result = restTemplateService.institutionSearch(page, keyword, pos);

        List<Map<String, Object>> results = (List<Map<String, Object>>) result.get("results");

        // results 리스트를 순회하면서 각 항목에서 excellent_info 추출
        if (results != null) {
            for (Map<String, Object> item : results) {
                if (item.containsKey("excellent_info")) {
                    String excellentInfoJson = new Gson().toJson(item.get("excellent_info"));
                    modelAndView.addObject("excellentInfoJson", excellentInfoJson);
                    break; // 첫 번째 excellent_info를 찾으면 반복문을 종료합니다.
                }
            }
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

        Paginations paginations = new Paginations(totalItems, page);

        String responseBody = (String) result.get("responseBody");
        String viewPath = "info/info_institution";
        modelAndView.setViewName(viewPath);
        modelAndView.addObject("responseBody", responseBody);
        modelAndView.addObject("StartRecordNumber", startRecordNumber);
        modelAndView.addObject("paginations", paginations);
        modelAndView.addObject("results", results); // Set results as a list
        modelAndView.addObject("keyword", keyword);
        modelAndView.addObject("pos", pos);
        Gson gson = new Gson();
        String jsonResults = gson.toJson(results);
        modelAndView.addObject("jsonResults", jsonResults);
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