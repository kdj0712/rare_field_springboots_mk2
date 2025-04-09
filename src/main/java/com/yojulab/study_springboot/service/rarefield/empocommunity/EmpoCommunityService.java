package com.yojulab.study_springboot.service.rarefield.empocommunity;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.Authentication;
import com.yojulab.study_springboot.dao.RareSharedDao;
import com.yojulab.study_springboot.utils.Commons;
import com.yojulab.study_springboot.utils.Paginations;

@Service
@Transactional
public class EmpoCommunityService {

    @Autowired
    RareSharedDao RaresharedDao;

    @Autowired
    Commons commons;

    public Object insert(Map dataMap) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // user_ID 가져오기
        Object principal = authentication.getPrincipal();
        UserDetails userDetails = (principal instanceof UserDetails) ? (UserDetails) principal : null;
        String user_ID = userDetails.getUsername();
        String authorities = authentication.getAuthorities().toString();
        
        dataMap.put("user_ID",user_ID);

        // community_ID 번호를 생성 + insert 쿼리문 불러오고 대입
        String sqlMapId = "RarefieldEmpocommunity.insert";
        String community_ID = commons.getUniqueSequence();
        dataMap.put("community_ID",community_ID);

        // community_comment 처음값 null 일 경우 글 생성
        // if(dataMap.containsKey("community_comment")){
            
        // }

        Object result = RaresharedDao.insert(sqlMapId, dataMap);
        return result;
                    
    }

    public Object read(HashMap<String, Object> dataMap){
        String sqlMapId = "RarefieldEmpocommunity.selectByOneUID";
        Object one = RaresharedDao.getOne(sqlMapId, dataMap);
        return one;
    }

    public int update(HashMap<String, Object> dataMap){
        String sqlMapId = "RarefieldEmpocommunity.update";
        Object update = RaresharedDao.update(sqlMapId, dataMap);
        return dataMap.size();
    }

    

    public Object deleteWithIn(Map dataMap){
        String sqlMapId = "RarefieldEmpocommunity.delete";
        Object count = RaresharedDao.delete(sqlMapId, dataMap);
        return count;
    }

    public Object selectTotal(Map dataMap) {
        String sqlMapId = "RarefieldEmpocommunity.selectTotal";

        Object result = RaresharedDao.getOne(sqlMapId, dataMap);
        return result;
    }    

    public Map selectSearchWithPaginationAndDeletes(Map dataMap) {

        if (dataMap.get("deleteIds") != null){
            Object count = this.deleteWithIn(dataMap);
        }

        // 페이지 형성 위한 계산
        int totalCount = (int) this.selectTotal(dataMap);
        
        int currentPage = 1;
        if(dataMap.get("currentPage") != null) {
            currentPage = Integer.parseInt((String)dataMap.get("currentPage"));    // from client in param
        }

        Paginations paginations = new Paginations(totalCount, currentPage);
        HashMap result = new HashMap<>();
        result.put("paginations", paginations); // 페이지에 대한 정보

        // page record 수
        String sqlMapId = "RarefieldEmpocommunity.selectSearchWithPagination";
        dataMap.put("pageScale", paginations.getPageScale());
        dataMap.put("pageBegin", paginations.getPageBegin());
        
        result.put("resultList", RaresharedDao.getList(sqlMapId, dataMap)); // 표현된 레코드 정보
        return result;
    }

    // 검색(조건-search : YEAR, CAR_NAME)
    public Map selectSearchWithPagination(Map dataMap) {
        // 페이지 형성 위한 계산
        int totalCount = (int) this.selectTotal(dataMap);
        
        int currentPage = 1;
        if(dataMap.get("currentPage") != null) {
            currentPage = Integer.parseInt((String)dataMap.get("currentPage"));    // from client in param
        }

        Paginations paginations = new Paginations(totalCount, currentPage);
        HashMap result = new HashMap<>();
        result.put("paginations", paginations); // 페이지에 대한 정보

        // page record 수
        String sqlMapId = "RarefieldEmpocommunity.selectSearchWithPagination";
        dataMap.put("pageScale", paginations.getPageScale());
        dataMap.put("pageBegin", paginations.getPageBegin());
        
        result.put("resultList", RaresharedDao.getList(sqlMapId, dataMap)); // 표현된 레코드 정보
        return result;
    }

    // // MVC view
    // public Object deleteAndSelectSearch(String UNIQUE_ID, Map dataMap) {
    //     dataMap.put("", UNIQUE_ID);

    //     HashMap result = new HashMap<>();
    //     result.put("deleteCount", this.delete(dataMap));

    //     result.putAll(this.selectSearchWithPagination(dataMap));
    //     return result;
    // }

    // public Object selectDetail(String CAR_INFOR_ID, Map dataMap) {
    //     // Object getOne(String sqlMapId, Object dataMap)
    //     String sqlMapId = "";
    //     dataMap.put("", CAR_INFOR_ID);

    //     Object result = RaresharedDao.getOne(sqlMapId, dataMap);
    //     return result;
    // }

    // public Object selectTotal(Map dataMap) {
    //     String sqlMapId = "";

    //     Object result = RaresharedDao.getOne(sqlMapId, dataMap);
    //     return result;
    // }    

    // // MVC view
    // public Object delete(Map dataMap) {
    //     String sqlMapId = "";

    //     Object result = RaresharedDao.delete(sqlMapId, dataMap);
    //     return result;
    // }
}
