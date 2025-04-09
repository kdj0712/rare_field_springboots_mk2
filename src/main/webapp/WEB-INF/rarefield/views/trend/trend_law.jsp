<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.List, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
<style>
    * {
        border-style: dotted 1px black;
        font-family: "Noto Sans KR", sans-serif;
        font-optical-sizing: auto;
        list-style-type: none;
        text-decoration: none;
        color: black;
        text-decoration-line: none;
    }

    #field {
        font-size: larger;
        font-weight: bold;
    }

    a,
    li * {
        text-decoration: none;
        color: black;
        text-decoration-line: none;
        ;
    }

    /* 왼쪽 배너 스타일 */
    .side-banner-left {
        position: fixed;
        top: 0;
        left: 0;
        width: 16.66667%;
        /* 2/12의 너비 */
        height: 100%;
        /* 배너가 화면 전체 높이를 차지하도록 */
        overflow: auto;
        /* 배너 내용이 길어지면 스크롤 가능하게 */
        z-index: 1000;
        /* 다른 요소들 위에 배너가 위치하도록 */
    }

    /* 오른쪽 배너 스타일 */
    .side-banner-right {
        position: fixed;
        top: 0;
        right: 0;
        width: 16.66667%;
        /* 2/12의 너비 */
        height: 100%;
        /* 배너가 화면 전체 높이를 차지하도록 */
        overflow: auto;
        /* 배너 내용이 길어지면 스크롤 가능하게 */
        z-index: 1000;
        /* 다른 요소들 위에 배너가 위치하도록 */
    }
    .resultList {
        margin-bottom: 20px; /* 각 항목 사이의 간격 조절 */
    }
    /* 메인 컨텐츠 스타일 조정 */
    .main-content {
        margin-left: 16.66667%;
        /* 왼쪽 배너의 너비만큼 여백 추가 */
        margin-right: 16.66667%;
        /* 오른쪽 배너의 너비만큼 여백 추가 */
    }
</style>
<main class="row justify-content-between">
    <div class="side-banner-left col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>
    </div>
    <div class="main-content col-8 row">
        <div class="container">
            <div class="container">
                <h4 class="text-center m-3 fw-bold" width="100%" height="50px">
                    <a href="/trend/law">
                        법/시행령/시행규칙
                    </a>
                </h4>
                <div style="width: 80%;" class="container resultList">
                    <hr>
                    <% 
                        List<Map<String,Object>> resultList = (List<Map<String,Object>>) request.getAttribute("result");
                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
                        for(int i = 0 ; i < resultList.size() ; i=i+1) {
                            HashMap<String, Object> record = (HashMap<String, Object>) resultList.get(i);
                            Date promulgation_date = inputFormat.parse((String) record.get("promulgation_date"));
                            Date start_date = inputFormat.parse((String) record.get("start_date"));
                    %>
                    <a href='<%= record.get("link") %>' target="_blank" class="container" style="width: 80%; color: inherit;">
                        <div class="tit">
                            <h5 class="">
                                <%= record.get("law_name") %>
                            </h5>
                        </div>
                        <div class="sub row justify-content-between">
                            <h7 class="name col-3">
                                공포번호 : <%= record.get("promulgation_number") %>
                            </h7>
                            <h7 class="name col-3">
                                공포일자 : <%= outputFormat.format(promulgation_date) %>
                            </h7>
                            <h7 class="name col-3">
                                시행일자 : <%= outputFormat.format(start_date) %>
                            </h7>
                        </div>
                    </a>
                    <hr>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>