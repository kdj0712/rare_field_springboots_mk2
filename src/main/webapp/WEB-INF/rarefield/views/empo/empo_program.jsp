<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>

<style>
    /* 전체 레이아웃 스타일 */
    .layout {
        display: flex;
        overflow: hidden;
    }

    /* 왼쪽 배너 스타일 */
    .side-banner-left {
        width: 16.66667%; /* 2/12의 너비 */
        left: 0;
        top: 0;
        overflow: auto; /* 배너 내용이 길어지면 스크롤 가능하게 */
        height: 100%;
        z-index: 1000; /* 다른 요소들 위에 배너가 위치하도록 */
        position: fixed;
    }
    .side-banner-right {
        position: fixed;
        top: 0;
        right: 0;
        width: 16.66667%;
        /* 2/12의 너비 */
        height: 100%;
        overflow: auto;
        /* 배너 내용이 길어지면 스크롤 가능하게 */
        z-index: 1000;
        /* 다른 요소들 위에 배너가 위치하도록 */
    }

    /* 메인 컨텐츠 스타일 조정 */
    .main-content {
        flex-grow: 1;
        overflow: auto; /* 메인 내용이 길어지면 스크롤 가능하게 */
    }

</style>

<main class="layout">
    <div class="side-banner-left">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>
    </div>
    <div class="main-content">
        <div class="container">
            <div class="row py-lg-5 justify-content-center">
                <div>
                    <div class="text-center" style="justify-content: center">
                        <img src="${remoteServerUrl}/data/img/RF_programmbanner.jpg" style="width: 100%; height: auto;">
                        <!-- <a href="/rarefield" class="btn btn-outline-primary" style="position: absolute; top: 65%; left: 50%; transform: translate(-50%, -50%); opacity: 0.8;">
                            Rare Field 소개
                        </a>                     -->
                    </div>
                </div>
            </div>
            <div class="album py-5">
                <div class="container">
                    <div class="row row-cols-md-3">
                        <div class="card col">
                            <img src="${remoteServerUrl}/data/img/program_thumnail.jpg" class="card-img-top" alt="썸네일 이미지">
                            <div class="card-body">
                                <p class="card-text">심리 안정 프로그램</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary">
                                            Apply
                                        </button>
                                    </div>
                                    <small class="text-body-secondary">월 84,800원</small>
                                </div>
                            </div>
                        </div>
                        <div class="card col">
                            <img src="${remoteServerUrl}/data/img/program_thumnail.jpg" class="card-img-top" alt="썸네일 이미지">
                            <div class="card-body">
                                <p class="card-text">상품설명</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary">
                                            Apply
                                        </button>
                                    </div>
                                    <small class="text-body-secondary">월 84,800원</small>
                                </div>
                            </div>
                        </div>
                        <div class="card col">
                            <img src="${remoteServerUrl}/data/img/program_thumnail.jpg" class="card-img-top" alt="썸네일 이미지">
                            <div class="card-body">
                                <p class="card-text">상품설명</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary">
                                            Apply
                                        </button>
                                    </div>
                                    <small class="text-body-secondary">월 84,800원</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="side-banner-right col-2">
        <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>
    </div>
</main>
<hr>
<%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>

<script integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>