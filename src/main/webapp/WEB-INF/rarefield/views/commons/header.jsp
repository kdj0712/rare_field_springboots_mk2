<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>희귀질환정보 공유 플랫폼 Rare Field</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${remoteServerUrl}/data/img/favicon.ico">
    <style>
        #maps >*{
            border-style: dotted 1px black;
        }
        * {
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

        a {
            text-decoration: none;
            color: black;
            text-decoration-line: none;
        }
        /* li 요소를 블록으로 처리하여 클릭 영역을 확장 */
        .menu_li, .th2_in {
            cursor: pointer;
        }

        /* li 요소에 스타일을 추가하여 링크처럼 보이도록 설정 */
        .menu_li:hover, .th2_in:hover {
            background-color: #f0f0f0;
        }

    </style>
</head>
<script>
    document.addEventListener('DOMContentLoaded', function () {
    var menuItems = document.querySelectorAll('.menu_li, .th2_in');
    menuItems.forEach(function (item) {
        item.addEventListener('click', function () {
            var url = item.getAttribute('data-url');
            if (url) {
                window.location.href = url;
            }
        });
    });
});
</script>
<header>
    <sec:authentication property="principal" var="userDetailsBean" />
    <div class="container-fluid">
        <div class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom navbar navbar-expand-lg bd-navbar sticky-top justify-content-center">
            <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
                <svg class="bi me-2" width="40" height="32">
                    <use xlink:href="#bootstrap"></use>
                </svg>
                <span class="fs-4"><img width="200" src="${remoteServerUrl}/data/img/RDS_logo.png" alt=""></span>
            </a>
            <ul class="nav nav-pills">
                <%-- 로그인이 안된상태 --%>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item"><a href="/user_login" class="nav-link fw-bold text-secondary"
                        aria-current="page">로그인</a>
                    </li>
                </sec:authorize>
                <%-- 로그인이 된 상태 --%>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-link">
                        ID : ${userDetailsBean.username}
                    </li>
                    <li class="nav-item"><a href="/user_mypage" class="nav-link text-secondary fw-bold">마이페이지</a>
                    </li>
                    <li class="nav-item"><a href="/logout" class="nav-link fw-bold text-secondary"
                        aria-current="page">로그아웃</a>
                    </li>
                </sec:authorize>
                <div class="dropdown-start dropstart">

                    <div class="btn dropdown-toggle" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-icons" style="font-size: 15px; color: #CCCCCC;">
                            menu
                        </span>
                    </div>
                    <div class="aside in dropdown-menu container" aria-labelledby="dropdownMenuLink" id="m_menu_aside" style="width: 1920px;">
                        <nav id="m_nav" role="navigation" class="row justify-content-center">
                            <ul class="th1 col-2 text-decoration-none">
                                <div id="field">
                                    최신마당
                                </div>
                                <li class="menu_li dropdown-item" data-url="/trend/news?currentPage=1">
                                    뉴스
                                </li>
                                <li class="th2_in dropdown-item" data-url="/trend/law">
                                    법, 시행령, 시행규칙
                                </li>
                                <li class="th2_in dropdown-item" data-url="/trend/guideline">
                                    고시, 지침
                                </li>
                                <li class="th2_in dropdown-item" data-url="/trend/trend_site">
                                    관련사이트
                                </li>
                            </ul>
                            <ul class="th1 col-2">
                                <div id="field">
                                    정보마당
                                </div>
                                <li class="menu_li dropdown-item" data-url="/info/info_raredisease">
                                    희귀질환정보검색
                                </li>
                                <li class="th2_in dropdown-item" data-url="/info/info_institution">
                                    의료기관검색
                                </li>
                                <li class="th2_in dropdown-item" data-url="/info/info_academicinfo">
                                    국내 학술정보
                                </li>
                                <li class="th2_in dropdown-item" data-url="/info/info_academicinfo_pub_med">
                                    해외 학술정보
                                </li>
                            </ul>
                            <ul class="th1 col-2">
                                <div id="field">
                                    참여마당
                                </div>
                                <li class="menu_li dropdown-item" data-url="/empo_community/selectSearch">
                                    커뮤니티
                                </li>
                                <li class="th2_in dropdown-item" data-url="/empo_program">
                                    프로그램
                                </li>
                            </ul>
                            <ul class="th1 col-2">
                                <div id="field">
                                    공지마당
                                </div>
                                <li class="menu_li dropdown-item" data-url="/other_notice">
                                    공지사항
                                </li>
                                <li class="th2_in dropdown-item" data-url="/other_QnA_main">
                                    QnA
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </ul>
        </div>
    </div>
</header>
