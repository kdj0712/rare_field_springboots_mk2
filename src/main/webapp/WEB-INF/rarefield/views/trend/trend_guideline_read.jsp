<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap, java.util.List, com.yojulab.study_springboot.utils.Paginations" %>
<%@ page import="java.util.Map, java.util.Date, java.util.Map, java.net.URLEncoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>
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
    <div class="side-banner-left col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>
    </div>
    <div class="main-content col-8 row">
        <h2>고시·지침</h2>
        <table class="table table-hover">
            <thead>
                    <th>분류</th>
                    <th>제목</th>
                    <th>발령번호</th>
                    <th>제·개정일</th>
                    <th>시행일</th>
                </tr>
            </thead>
            <tbody>
                <tr onclick="location.href='/trend/trend_guideline_read/${result.id}'" style="cursor: pointer;">
                    <td>
                        ${result.post_cate}
                        <c:if test="${result.importance == '중요'}">
                            (${result.importance})
                        </c:if>
                    </td>
                    <td class="text-start">${result.post_title}</td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:trim(result.order_number) == ''}">
                                <div></div>
                            </c:when>
                            <c:otherwise>
                                ${result.order_number}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:trim(result.date_legislation) == ''}">
                                <div></div>
                            </c:when>
                            <c:otherwise>
                                ${result.date_legislation}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:trim(result.date_start) == ''}">
                                <div></div>
                            </c:when>
                            <c:otherwise>
                                ${result.date_start}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>