<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.List, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <h4 class="text-center m-3 fw-bold" width="100%" height="100px"> <a href="/trend/guideline">고시·지침</a> </h4>

        <div class="justify-content-center row">
            <div class="row col-7 justify-content-center" style="align-items: center;">
                <div class="col-3">
                    <select class="form-control" style="border-radius: 25px;" name="key_name">
                        <option value="dise_name_kr"> 제목</option>
                    </select>
                </div>
                <div class="col-6">
                    <input class="form-control" style="border-radius: 0px;" placeholder="Enter Search!" name="search_word"
                        value="">
                </div>
                <div class="col-2">
                    <button type="submit" style="border:none; background: none;" formaction="" formmethod="get">
                        <svg width="32" height="32" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <g filter="url(#filter0_d_7_45)">
                                <path d="M5 40C5 20.67 20.67 5 40 5C59.33 5 75 20.67 75 40C75 59.33 59.33 75 40 75C20.67 75 5 59.33 5 40Z" fill="#04CBFC" fill-opacity="0.47" shape-rendering="crispEdges" />
                            </g>
                            <path d="M35 50L45 40L35 30" stroke="white" stroke-width="5" stroke-linecap="round" />
                            <defs>
                                <filter id="filter0_d_7_45" x="0" y="0" width="80" height="80" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                                    <feFlood flood-opacity="0" result="BackgroundImageFix" />
                                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha" />
                                    <feOffset />
                                    <feGaussianBlur stdDeviation="2.5" />
                                    <feComposite in2="hardAlpha" operator="out" />
                                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0" />
                                    <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_7_45" />
                                    <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_7_45" result="shape" />
                                </filter>
                            </defs>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <% 
            List<Map<String,Object>> resultList = (List<Map<String,Object>>) request.getAttribute("result");
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <div class="container" style="width: 80%">
            <hr>
            <c:if test="${empty result}">         
                검색 결과가 없습니다.
            </c:if>
            <c:forEach var="record" items="${result}" varStatus="status">
                <div class="container" style="width: 80%;" onclick="location.href='/trend/trend_guideline_read/${record._id}'">
                    <h7 class="category">
                        <c:if test="${not empty record.post_cate}">
                            분류 : ${record.post_cate}
                        </c:if>
                    </h7>
                    <div class="tit">
                        <h5 class="">
                            <c:if test="${not empty record.post_title}">
                                분류 : ${record.post_title}
                            </c:if>
                        </h5>
                    </div>
                    <div class="sub row justify-content-between">
                        <h7 class="name col-5">
                            <c:if test="${not empty record.order_number}">
                                발령번호 : ${record.order_number}
                            </c:if>
                        </h7>
                        <h7 class="name col-3">
                            <c:if test="${not empty record.date_legislation}">
                                제·개정일 : ${record.date_legislation}
                            </c:if>
                        </h7>
                        <h7 class="name col-3">
                            <c:if test="${not empty record.date_start}">
                                시행일 : ${record.date_start}
                            </c:if>
                        </h7>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </div>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>
<hr>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>