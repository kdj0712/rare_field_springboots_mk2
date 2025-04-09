<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.HashMap, java.util.ArrayList, com.yojulab.study_springboot.utils.Paginations" %>

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


            <sec:authentication property="principal" var="userDetailsBean" />
            <main class="row justify-content-between">

                <div class="side-banner-left col-2">
                    <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>
                </div>

                <div class="main-content col-8 row">
                    <form action="">
                        <main class="container">
                            <div>
                                <h2 class="text-center  fw-bold"> <a href="/empo_community/selectSearch">커뮤니티</a></h2>
                            </div>
                            <div style="height: 20px;"></div>

                            <% HashMap dataMap=(HashMap)request.getAttribute("dataMap"); String
                                searchStr=(String)dataMap.getOrDefault("search", "" ); HashMap
                                result=(HashMap)request.getAttribute("result"); %>

                                <div class="row justify-content-center text-center">
                                    <div class="row col-9 justify-content-center">
                                        <div class="col-3">
                                            <select style="border-radius: 25px;" class="form-control" name="key_name">
                                                <option value=""> 전체 </option>
                                                <option value="" <%=(searchStr.equals("community_title")) ? "selected"
                                                    : "" %> 제목 </option>
                                                <option value=""> 관련질환명 </option>
                                                <option value=""> 지역 </option>
                                                <option value=""> 작성날짜 </option>
                                            </select>
                                        </div>
                                        <div class="col-6">
                                            <input style="border-radius: 0px;" class="form-control"
                                                placeholder="Enter Search!" name="words"
                                                value='<%= dataMap.getOrDefault("words", "") %>'>
                                        </div>
                                        <div class="col-2">
                                            <button style="border: none; background: none;" type="submit"
                                                style="border:none; background: none;"
                                                formaction="/empo_community/selectSearch" formmethod="get"></button>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div style="width: 80%;" class="container">
                                    <!-- 카테고리별 탭 -->
                                    <ul class="nav nav-tabs">
                                        <li class="nav-item">
                                            <a class="nav-link active" href="#category1" data-toggle="tab"
                                                data-category="전체">전체</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#category2" data-toggle="tab"
                                                data-category="궁금해요">궁금해요</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#category3" data-toggle="tab"
                                                data-category="추천해요">추천해요</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#category4" data-toggle="tab"
                                                data-category="자랑해요">자랑해요</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#category5" data-toggle="tab"
                                                data-category="찾아요">찾아요</a>
                                        </li>
                                    </ul>
                                    <!-- 탭 내용 -->
                                    <% ArrayList resultList=(ArrayList)result.get("resultList"); for(int i=0; i <
                                        resultList.size(); i=i+1) { HashMap record=(HashMap)resultList.get(i); %>

                                        <br>
                                        <div class=" container" style="width: 100%;"
                                            onclick="location.href='/empo_community/read?key_name=&words=&community_ID=<%= record.get("community_ID") %>'" style="cursor: pointer;" name='' value='' >
                                            <div class="row justify-content-between">
                                                <h7 class="category col-4">
                                                    <!-- <a href="/empo_community/read" style="color: #4b4b4b;" class="" name ="community_ID" value='<%= record.get("community_ID") %>'> -->
                                                    제목 : <%= record.get("community_title") %>
                                                        <!-- </a> -->
                                                </h7>
                                                <h7 class="category col-2">
                                                    <!-- <a href="/empo_community/read" style="color: #4b4b4b;" class="" > -->
                                                    카테고리 : <%= record.get("community_choice") %>
                                                        <!-- </a> -->
                                                </h7>

                                                <h7 class="category col-2">
                                                    <!-- <a href="/empo_community/read" style="color: #4b4b4b;" class="" > -->
                                                    작성자 : <%= record.get("user_ID") %>
                                                        <!-- </a> -->
                                                </h7>
                                                <h7 class="category col-4">
                                                    <!-- <a href="/empo_community/read" style="color: #4b4b4b;" class="" > -->
                                                    작성일 : <%= record.get("community_date") %>
                                                        <!-- </a> -->
                                                </h7>
                                                <!-- <button formaction="/empo_community/read" name="community_ID" value='<%= record.get("community_ID") %>'>read</button> -->
                                            </div>

                                        </div>
                                        <hr>
                                        <% } %>



                                </div>
                                <div class="row">
                                    <div class="col-2">
                                    </div>
                                    <div class="mb-4 col-8">
                                        <button class="btn btn-lg " name="btn_type" value="insert"
                                            formaction="/empo_community/insert"
                                            style="background-color: #00CBFE; color: #ffffff; width: 100%; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);"
                                            type="submit">글쓰기

                                        </button>
                                    </div>

                                    <div class="col-2">
                                    </div>
                                </div>
                                <% Paginations paginations=(Paginations)result.get("paginations"); %>
                                    <div>총 갯수 : <%= paginations.getTotalCount() %>
                                    </div>
                                    <div style="height: 20px;"></div>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <!-- <li class="page-item {{ '' if pagination.has_previous_block else 'disabled' }}">
                            <button style="border: none; background: none;" type="submit" class="page-link"
                                formaction="/empo_community/{{pagination.first_page}}">
                                <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M18 3L12 9L18 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                            </button>
                        </li>
                        <li class="page-item {{ '' if pagination.has_previous_page else 'disabled' }}">
                            <button style="border: none; background: none;" type="submit" class="page-link"
                                formaction="/empo_community/{{pagination.previous_page}}"><svg width="13" height="18"
                                    viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M10 3L4 9L10 15" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg></button>
                        </li> -->



                                            <li class="page-item">
                                                <a class="page-link"
                                                    href="/empo_community/selectSearch?currentPage=<%= paginations.getPreviousPage() %>">Previous</a>
                                            </li>
                                            <% for(int i=paginations.getBlockStart();i <=paginations.getBlockEnd();
                                                i=i+1){ %>
                                                <li class="page-item">
                                                    <a class="page-link"
                                                        href="/empo_community/selectSearch?currentPage=<%= i %>">
                                                        <%= i %>
                                                    </a>
                                                </li>
                                                <% } %>

                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/empo_community/selectSearch?currentPage=<%= paginations.getNextPage() %>">Next</a>
                                                    </li>


                                                    <!-- <li class=" page-item {{ '' if pagination.has_next_page else 'disabled' }}">
                            <button style="border: none; background: none;" type=" submit" class="page-link"
                                formaction="/empo_community/{{ pagination.next_page }}"><svg width="13" height="18"
                                    viewBox="0 0 13 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                                <path d="M4 0V22" stroke="#EDEDED" stroke-width="7" />
                                </svg>
                            </button>
                        </li>
                        <li class=" page-item {{ '' if pagination.has_next_block else ' disabled' }}">
                            <button style="border: none; background: none;" type=" submit" class="page-link"
                                formaction="/empo_community/{{ pagination.last_page }}">
                                <svg width="21" height="18" viewBox="0 0 21 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 15L9 9L3 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                    <path d="M11 15L17 9L11 3" stroke="#696969" stroke-width="5" stroke-linecap="round" />
                                </svg>
                            </button>
                        </li> -->
                                        </ul>
                                    </nav>
                                    <div style="height: 20px;"></div>
                        </main>
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

                <script>
                    $(document).ready(function () {
                        // 카테고리별 탭을 클릭했을 때
                        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                            // 선택된 탭의 href 속성값을 가져옴
                            var target = $(e.target).data('category');

                            // 해당 탭의 데이터를 동적으로 로드
                            if (target === "#category1") {
                                loadCategoryData("전체");
                            } else if (target === "#category2") {
                                loadCategoryData("궁금해요");
                            } else if (target === "#category3") {
                                loadCategoryData("추천해요");
                            } else if (target === "#category4") {
                                loadCategoryData("자랑해요");
                            } else if (target === "#category5") {
                                loadCategoryData("찾아요");
                            }
                        });
                    });

                    function loadCategoryData(category) {
                        // 서버로 카테고리 정보를 전송하여 해당 카테고리의 데이터를 받아옴
                        $.ajax({
                            url: '/trend_news',  // 해당 API 엔드포인트로 설정
                            method: 'GET',
                            data: { category: category },
                            success: function (data) {
                                // 받아온 데이터를 화면에 출력하는 코드
                            },
                            error: function (error) {
                                console.log(error);
                            }
                        });
                    }
                </script>



                </html>