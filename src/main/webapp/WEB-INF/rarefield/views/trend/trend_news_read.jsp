<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.List, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.Date, java.util.Map, java.net.URLEncoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
<!-- Quill 편집기의 스타일 지정 -->
<style>
    /* #editor {
        height: 35rem;
        overflow: auto;
    } */

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
            <%
                String updatedContents = (String) request.getAttribute("updatedContents");
                Integer currentPage = (Integer) session.getAttribute("currentPage");
                String keyName = (String) session.getAttribute("keyName");
                String searchWord = (String) session.getAttribute("searchWord");
                String category = (String) session.getAttribute("category");
                Map<String,Object> result = (Map<String,Object>) request.getAttribute("result");
                String newsDatetime = (String) result.get("news_datetime");
                SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = "";
                    try {
                        Date date = originalFormat.parse(newsDatetime);
                        formattedDate = newFormat.format(date);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
            %>
            <div >
                <div class="mt-4 mb-4">
                    <h2 style="margin-top: 40px;">
                        <%= result.get("news_title") %>
                    </h2>
                </div>
                <div class="row">
                    <div class="col-12 text-end">
                        언론사명 : <%= result.get("news_paper") %>
                    </div>
                    <div class="col-12 text-end">
                        날짜 : <%= formattedDate %>
                    </div>
                </div>
            </div>
            <hr>
            <div>
                <c:choose>
                    <c:when test="${empty result['news_image']}">
                    </c:when>
                    <c:otherwise>
                        <!-- news_image 값이 존재하는 경우 -->
                        <img src="${result['news_image']}" alt="" style="float: left; margin-right: 7px; margin-bottom: 5px;">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="lead" style="text-align:justify; font-size: 18px;" id="editor">
                <%= updatedContents %>
            </div>
            <hr>
            <div>뉴스 링크 :
                <a href="${result.news_url}" target="_blank">
                    <%= result.get("news_url") %>
                </a>
            </div>
            <hr>
            <div class="row">
                <div class="col-12 text-end">
                    <a href="/trend/news?currentPage=<%= currentPage %><%= (keyName != null && !keyName.isEmpty()) ? "&key_name=" + URLEncoder.encode(keyName, "UTF-8") : "" %><%= (searchWord != null && !searchWord.isEmpty()) ? "&search_word=" + URLEncoder.encode(searchWord, "UTF-8") : "" %><%= (category != null && !category.isEmpty()) ? "&category=" + URLEncoder.encode(category, "UTF-8") : "" %>"class="btn btn-primary">
                        목록
                    </a>
                </div>
            </div>
            
        </div>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>

<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>
