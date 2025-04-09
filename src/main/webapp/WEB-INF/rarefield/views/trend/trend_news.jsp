<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.List, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.ArrayList, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
<style>
    table {
        border: 1px solid black;
    }

    .nav-link {
        color: black;
    }


    #pages:active,
    #pages:hover {
        font-weight: bolder;
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
        <form id="newsForm" action="">
            <div class="container">
                <div>
                    <h2 class="text-center fw-bold"> <a href="/trend/news">news</a></h2>
                </div>
                <div style="height: 20px;"></div>

                <div class="row justify-content-center text-center">
                    <div class="row col-7 justify-content-center">
                        <div class="col-3">
                            <select style="border-radius: 25px;" id="keyNameSelect" class="form-control" name="key_name">
                                <option value="news_title" ${key_name eq 'news_title' ? 'selected' : '' }>
                                    제목
                                </option>
                                <option value="news_paper" ${key_name eq 'news_paper' ? 'selected' : '' }>
                                    언론사명
                                </option>
                            </select>
                        </div>
                        <div class="col-6">
                            <input id="searchWordInput" style="border-radius: 0px;" class="form-control" placeholder="Enter Search!" name="search_word" value="${search_word != null ? search_word : ''}">
                        </div>
                        <div class="col-2">
                            <button id="searchButton" type="submit" style="border:none; background: none;" formaction="/trend/news" formmethod="get">
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
                <br>
                <div style="width: 80%;" class="container">
                    <!-- 카테고리별 탭 -->
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" href="#category1" data-toggle="tab" data-category="전체">
                                전체
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#category2" data-toggle="tab" data-category="의료/법안">
                                의료/법안
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#category3" data-toggle="tab" data-category="신약/개발">
                                신약/개발
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#category4" data-toggle="tab" data-category="심포지엄/행사">
                                심포지엄/행사
                            </a>
                        </li>
                    </ul>
                    <!-- 탭 내용 -->
                    <hr>
                    <input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
                    <c:if test="${not empty category}">
                        <input type="hidden" id="category" name="category" value="${category}">
                    </c:if>
                    <c:forEach var="record" items="${result}" varStatus="status">
                        <fmt:parseDate value="${record.news_datetime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="date" />
                        <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="dateOnly" />
                                    
                        <div class="tab-content container" style="width: 80%; cursor: pointer;" 
                            onclick="setCurrentPageAndNavigate('${record._id}', '${currentPage}', 
                                '${key_name != null ? key_name : ""}', 
                                '${search_word != null ? search_word : ""}', 
                                '${category != null ? category : ""}')">
                            <h7 class="tab-pane fade show active">
                                <a href="javascript:void(0);" style="color: #4b4b4b;" class="">
                                    ${record.news_paper}
                                </a>
                            </h7>
                            <div class="tit">
                                <h5 class="">
                                    <a href="javascript:void(0);" class="">
                                        ${record.news_title}
                                    </a>
                                </h5>
                            </div>
                            <div class="row justify-content-end">
                                <h7 class="category col-2">
                                    <a href="javascript:void(0);" style="color: #4b4b4b;" class="">
                                        ${dateOnly}
                                    </a>
                                </h7>
                                <h7 class="category col-2">
                                    <a href="javascript:void(0);" style="color: #4b4b4b;" class="">
                                        ${record.news_topic}
                                    </a>
                                </h7>
                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                      
                </div>
                <div>총 갯수 :
                    <c:out value="${pagination.totalCount}" />
                </div>
                <div class="pagination justify-content-center">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item {{ '' if pagination.has_previous_block else 'disabled' }}">
                                <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${pagination.blockStart}); return false;">
                                    <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M18 3L12 9L18 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                        <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    </svg>
                                </a>
                            </li>
                            <li class="page-item {{ '' if pagination.has_previous_page else 'disabled' }}">
                                <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${currentPage}-1);return false;">
                                    <svg width="13" height="18" viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    </svg>
                                </a>
                            </li>
                            <c:forEach var="i" begin="${pagination.blockStart}" end="${pagination.blockEnd}">
                                <li class="page-item ${i == paginations.currentPage ? 'active' : ''}">
                                    <a style="border: none; background: none; color: black;" class="page-link" href="javascript:void(0);" onclick="goToPage(${i});return false;">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class=" page-item {{ '' if pagination.has_next_page else 'disabled' }}">
                                <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${pagination.nextPage});return false;">
                                    <svg width="13" height="18" viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    </svg>
                                        <path d="M4 0V22" stroke="#EDEDED" stroke-width="7" />
                                    </svg>
                                </a>
                            </li>
                            <li class=" page-item {{ '' if pagination.has_next_block else ' disabled' }}">
                                <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${pagination.totalPage});return false;">
                                    <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                        <path d="M11 15L17 9L11 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    </svg>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </form>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>

<hr>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>

<!-- jQuery를 불러오는 CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/readnews.js"></script>