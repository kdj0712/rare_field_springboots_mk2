package com.yojulab.study_springboot.controller.rarefield.rest;

import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.safety.Whitelist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yojulab.study_springboot.service.rarefield.rest.RestTemplateService;
import com.yojulab.study_springboot.utils.Paginations;

import jakarta.servlet.http.HttpSession;

@SuppressWarnings({ "deprecation", "unused" })
@RestController
@RequestMapping("/trend")
public class RestTemplateController {

  @Autowired
  RestTemplateService restTemplateService;

  @GetMapping(value = "/law")
  public ModelAndView law(ModelAndView modelAndView) {
    List<Map<String, Object>> result = restTemplateService.lawPostRequest();
    String viewPath = "trend/trend_law";
    modelAndView.setViewName(viewPath);
    modelAndView.addObject("result", result);
    return modelAndView;
  }


  @GetMapping(value = "/news")
  public ModelAndView news(
      @RequestParam(required = false) String key_name,
      @RequestParam(required = false) String search_word,
      @RequestParam(required = false) String category,
      @RequestParam(required = false) Integer currentPage,
      ModelAndView modelAndView) {

    Integer page = (currentPage != null) ? currentPage : 1;
    Map<String, Object> result = null;

    try {
      result = restTemplateService.newsPostRequest(key_name, search_word, page, category);
    } catch (JsonProcessingException e) {
      e.printStackTrace();
      modelAndView.addObject("error", "데이터 처리 중 오류가 발생했습니다.");
      modelAndView.setViewName("error");
      return modelAndView;
    }

    List<Map<String, Object>> newsresults = (List<Map<String, Object>>) result.get("newsresult");
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

    String viewPath = "trend/trend_news";
    modelAndView.setViewName(viewPath);
    modelAndView.addObject("key_name", key_name);
    modelAndView.addObject("search_word", search_word);
    modelAndView.addObject("result", newsresults);
    modelAndView.addObject("currentPage", currentPage);
    modelAndView.addObject("pagination", Paginations);
    modelAndView.addObject("category", category);
    return modelAndView;
  }

  @PostMapping("/saveSessionData")
  @ResponseBody
  public void saveSessionData(HttpSession session, @RequestBody Map<String, Object> params) {
      if (params.containsKey("currentPage")) {
          try {
              Integer currentPage = Integer.parseInt(params.get("currentPage").toString());
              session.setAttribute("currentPage", currentPage);
          } catch (NumberFormatException e) {
              // 변환에 실패한 경우의 처리
              System.err.println("Invalid currentPage format: " + params.get("currentPage"));
          }
      }
  
      if (params.containsKey("keyName")) {
          session.setAttribute("keyName", params.get("keyName"));
      } else {
          session.removeAttribute("keyName");
      }
  
      if (params.containsKey("searchWord")) {
          session.setAttribute("searchWord", params.get("searchWord"));
      } else {
          session.removeAttribute("searchWord");
      }
  
      if (params.containsKey("category")) {
          session.setAttribute("category", params.get("category"));
      } else {
          session.removeAttribute("category");
      }
  }
  
  @GetMapping("/read/{id}")
  public ModelAndView newsRead(HttpSession session, @PathVariable String id) throws Exception {
      Integer currentPage = (Integer) session.getAttribute("currentPage");
  
      String keyName = (String) session.getAttribute("keyName");
      String searchWord = (String) session.getAttribute("searchWord");
      String category = (String) session.getAttribute("category");
  
      Map<String, Object> result = restTemplateService.newsReadGetRequest(id);
  
      String newsContents = (String) result.get("news_contents");
      String updatedContents = addSpacingToParagraphs(newsContents);
  
      String viewPath = "trend/trend_news_read";
      ModelAndView modelAndView = new ModelAndView(viewPath);
      modelAndView.addObject("result", result);
      modelAndView.addObject("_id", id);
      modelAndView.addObject("currentPage", currentPage);
      modelAndView.addObject("keyName", keyName);
      modelAndView.addObject("searchWord", searchWord);
      modelAndView.addObject("category", category);
      modelAndView.addObject("updatedContents", updatedContents);
      return modelAndView;
  }
  

  private String addSpacingToParagraphs(String contents) {
    // Jsoup을 사용하여 HTML을 파싱합니다.
    Document doc = Jsoup.parse(contents, "", Parser.htmlParser());

    // <p> 태그를 줄바꿈 문자로 대체합니다.
    for (Element element : doc.select("p")) {
      element.before("\n");
      element.after("\n");
    }

    // 변환된 HTML 내용을 문자열로 반환합니다.
    String updatedContents = doc.body().html();
    return updatedContents;
  }

  @GetMapping(value = "/guideline")
    public ModelAndView guideline(ModelAndView modelAndView) {
    List<Map<String,Object>> result = restTemplateService.guideLine();
    String viewPath = "trend/trend_guideline";
    modelAndView.setViewName(viewPath);
    modelAndView.addObject("result", result);
    return modelAndView;
  }

  @GetMapping("/trend_guideline_read/{id}")
  public ModelAndView guidelineRead(@PathVariable String id,
                                    ModelAndView modelAndView) throws Exception {

      Map<String, Object> result = restTemplateService.readguideline(id);
  
      String viewPath = "trend/trend_guideline_read";
      modelAndView.setViewName(viewPath);
      modelAndView.addObject("result", result);
      modelAndView.addObject("_id", id);
      return modelAndView;
  }
  

}
