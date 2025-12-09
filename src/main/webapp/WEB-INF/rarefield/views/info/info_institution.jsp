<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=w8z9acdzar&submodules=geocoder,service"></script>
<script src="/proxy/naver-maps" async defer onload="initMap()"></script>
<script src="${pageContext.request.contextPath}/js/info_institution.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.ArrayList, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.List" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
<style>
  .name {
    max-width: 250px;
    /* 최대 너비 설정 */
    word-wrap: break-word;
    /* 길이가 최대 너비를 넘어가면 줄바꿈 */
  }

  .address {
    max-width: 450px;
    /* 최대 너비 설정 */
    word-wrap: break-word;
    /* 길이가 최대 너비를 넘어가면 줄바꿈 */
  }

  .excellent-info {
    display: none;
    /* 기본적으로 우수 정보를 숨김 */
  }

  .td {
    text-align: center;
  }

  .hidden {
    display: none;
  }

  .visible {
    display: block;
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
  <%
    String keyword=(String) request.getAttribute("keyword");
    String pos=(String) request.getAttribute("pos"); 
    int startRecordNumber=(request.getAttribute("StartRecordNumber")!=null) ? (int) request.getAttribute("StartRecordNumber") : 1; 
    List<Map<String, Object>> results = (List<Map<String, Object>>) request.getAttribute("results");
    Paginations paginations = (Paginations) request.getAttribute("paginations");
    String responseBody = (String) request.getAttribute("responseBody");
    String jsonResults = (String) request.getAttribute("jsonResults");
    if (results == null) {
      results = new ArrayList<>();
      }
    if (responseBody == null) {
      responseBody = "{}";
      } else {
        Gson gson = new Gson();
        responseBody = gson.toJson(responseBody);
      }

    if (jsonResults == null) {
    jsonResults = "[]";
    }
  %>
  <div class="main-content col-8 row">
    <div class="col" style="justify-items: center; width: 100%;">
      <form action="${pageContext.request.contextPath}/info/info_institution" method="get" id="maps" class="container">
        <div class="row">
          <div class="col-12" id="map" style="width: 100%; height: 600px;"></div>
          <div class="col-12">
            <label for="keyword">검색할 장소를 입력하세요</label>
            <input type="text" id="keyword" name="keyword" class="controls" placeholder="입력하기" value="${param.keyword}">
            <input type="hidden" id="pos" name="pos" value="${param.pos}">
            <button id="getLocation" style="display:none;">위치 정보 제공</button>
            <button type="submit" formmethod="get"  style="border:none; background: none;" onclick="getLocationAndSubmit()">
              <svg width="50" height="50" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
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
            <div class="row">
              <table id="places">
                <thead>
                  <tr>
                    <th class="td">Name</th>
                    <th class="td">Address</th>
                    <th class="td">Tel Num</th>
                    <th class="td">자세히 보기</th>
                  </tr>
                </thead>
                <tbody id="tbody">
                  <c:if test="${empty results}">
                    <tr>
                      <td colsp an="8" class="center-fixed">검색 결과가 없습니다.</td>
                    </tr>
                  </c:if>
                  <c:forEach var="result" items="${results}" varStatus="status">
                    <tr>
                      <td class="name">
                        ${result.yadmNm}
                        <c:if test="${not empty result.excellent_info and result.excellent_info ne '없음'}">
                          <button type="button" onclick="showExcellentInfoPopup(${status.index});" class="btn btn-primary" style="font-size: 10px; width: 70px; height: 25px; padding: 5px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                              <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"></path>
                            </svg>우수 정보
                          </button>
                          <div id="excellent-info-${status.index}" class="excellent-info" style="display: none;">
                            <ul>
                              <c:forEach var="entry" items="${result.excellent_info}">
                                <li>${entry.asmGrdNm} - ${entry.asmNm}</li>
                              </c:forEach>
                            </ul>
                          </div>
                        </c:if>
                      </td>
                      <td class="address">
                        ${result.addr}
                      </td>
                      <td class="td">
                        ${result.telno}
                      </td>
                      <td class="td">
                        <c:if test="${not empty result.YPos && not empty result.XPos}">
                          <a href="#" onclick="focusOnMap(${result.YPos}, ${result.XPos},${status.index}); return false;" data-result-id=${result.ykiho}>
                            보기
                          </a>
                        </c:if>
                        <c:if test="${empty result.YPos || empty result.XPos}">
                          데이터 없음
                        </c:if>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
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
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="side-banner-right col-2">
    <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
  </div>
</main>
<hr>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>
<script>
  var jsonResults = <%= jsonResults %>;
</script>