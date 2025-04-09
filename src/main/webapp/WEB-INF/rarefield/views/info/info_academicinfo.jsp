<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
<%@ page import="java.util.HashMap, java.util.ArrayList, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.List" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
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
    <div class="side-banner-left">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>
    </div>
    <div class="main-content col-8 row">
        <form id="searchForm" method="get">
            <% HashMap<String, Object> dataMap = (HashMap<String, Object>) request.getAttribute("dataMap");
                if (dataMap == null) {
                    dataMap = new HashMap<>();
                }
                String searchStr = (String) dataMap.getOrDefault("search", "");
                HashMap<String, Object> result = (HashMap<String, Object>) request.getAttribute("results");
                List<Map<String, Object>> resultList = null;
                if (result != null) {
                    resultList = (List<Map<String, Object>>) result.get("results");
                    if (resultList == null) {
                        resultList = new ArrayList<>();
                    }
                    Object someValue = result.get("someKey");
                } else {
                }
                Paginations paginations = null;
                if (result != null) {
                    paginations = (Paginations) result.get("paginations");
                }

                int startRecordNumber = 1;
                if (dataMap.containsKey("StartRecordNumber")) {
                    startRecordNumber = (int) dataMap.get("StartRecordNumber");
                }

                String keyName = request.getParameter("key_name");
                String searchWord = request.getParameter("search_word");
            %>
            <div>
                <h2 class="text-center fw-bold"> <a href="/info/info_academicinfo">학술정보</a></h2>
            </div>
            <div style="height: 20px;"></div>

            <div class="row justify-content-center text-center">
                <div class="row col-7 justify-content-center">
                    <div class="col-2">
                        <select class="form-control" id="keyNameSelect" name="key_name">
                            <option value="thesis_name"  ${key_name eq 'thesis_name' ? 'selected' : '' }>
                                제목
                            </option>
                            <option value="thesis_date"  ${key_name eq'thesis_date' ? 'selected' : '' }>
                                연도
                            </option>
                        </select>
                    </div>
                    <div class="col-6">
                        <input id="searchWordInput" style="border-radius: 0px;" class="form-control" placeholder="검색할 내용을 입력하세요" name="search_word" value="${search_word != null ? search_word : ''}">
                    </div>
                    <div class="col-2">
                        <button id="searchButton" style="border: none; background: none;" type="submit" style="border:none; background: none;" formaction="/info/info_academicinfo">
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
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link" href="/info/info_academicinfo" data-toggle="tab" data-category="riss">
                            RISS
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/info/info_academicinfo_pub_med" data-toggle="tab" data-category="pub_med">
                            PUB-MED
                        </a>
                    </li>
                </ul>
                <br>
                <c:if test="${empty resultList}">
                    <div colspan="8" class="center-fixed">검색 결과가 없습니다.</td>
                </c:if>
                <c:forEach var="record" items="${resultList}" varStatus="status">
                    <div class="tab-content container" style="width: 90%;" style="cursor: pointer;">
                        <p class="tab-pane fade show active">
                            <a href="${record.research_url}" style="color: #4b4b4b;" class="" target="_blank">
                                원문출처
                            </a>
                        </p>
                        <div class="tit">
                            <p class="fw-bold">
                                <a style="color: #4b4b4b;" class="">
                                    ${record.research_title}
                                </a>
                            </p>
                        </div>
                        <div class="row justify-content-end text-end">
                            <p class="category col-2">
                                <a style="color: #4b4b4b;" class="">
                                    ${record.research_year}
                                </a>
                            </p>
                            <p class="category col-6 text-end">
                                <a style="color: #4b4b4b;" class="">
                                    ${record.research_institution}
                                </a>
                            </p>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
                <div>
                    <div>총 갯수 :
                        <c:out value="${paginations.totalCount}" />
                    </div>
                </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item {{ '' if pagination.has_previous_block else 'disabled' }}">
                            <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${paginations.previousPage});return false;">
                                <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M18 3L12 9L18 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                            </a>
                        </li>
                        <li class="page-item {{ '' if pagination.has_previous_page else 'disabled' }}">
                            <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${paginations.blockStart});return false;">
                                <svg width="13" height="18" viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                            </a>
                        </li>
                        <c:forEach var="i" begin="${paginations.blockStart}" end="${paginations.blockEnd}">
                            <li class="page-item ${i == paginations.currentPage ? 'active' : ''}">
                                <a style="border: none; background: none; color: black;" class="page-link" href="javascript:void(0);" onclick="goToPage(${i});return false;">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>
                        <li class=" page-item {{ '' if pagination.has_next_page else 'disabled' }}">
                            <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${paginations.blockEnd});return false;">
                                <svg width="13" height="18" viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                                    <path d="M4 0V22" stroke="#EDEDED" stroke-width="7" />
                                </svg>
                            </a>
                        </li>
                        <li class=" page-item {{ '' if pagination.has_next_block else ' disabled' }}">
                            <a style="border: none; background: none;" class="page-link" href="javascript:void(0);" onclick="goToPage(${paginations.nextPage});return false;">
                                <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    <path d="M11 15L17 9L11 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div style="height: 20px;"></div>
        </form>
    </div>
    <div class="side-banner-right">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>
<hr>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/info_academicinfo.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

