<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="container">

    <div class="row justify-content-between">
        <div class="col-2">
            <h5>고객센터</h5>
            <ul class="nav flex-column">
                <li class="nav-item mb-2">대표번호 : 010-6511-58**</li>
                <li class="nav-item mb-2"><a href="/other/other_QnA_main"
                        class="nav-link p-0 text-body-secondary">QnA</a></li>
                <li class="nav-item mb-2"><a href="/other/other_notice"
                        class="nav-link p-0 text-body-secondary">Notice</a>
                </li>
            </ul>
        </div>
        <div class="col-4 ">
            <h5><a href="/rarefield" class="text-decoration-none">Rare Field</a></h5>
            <ul class="nav flex-column">
                <li class="nav-item mb-2">Company : (주)레어필드</li>
                <li>대표 : 조유경</li>
                <li class="nav-item mb-2">Address : 서울 구로구 디지털로26길 111 303호</li>
            </ul>
        </div>
        <div class="col-6 ">
            <form>
                <h5>무료 뉴스레터 구독</h5>
                <p>메일로 RareField 관련 소식을 받아보세요.</p>
                <div class="d-flex flex-column flex-sm-row w-100 gap-2">
                    <label for="newsletter1" class="visually-hidden">Email address</label>
                    <input type="email" id="newsletter1" type="text" class="form-control"
                        placeholder="Email address">
                    <button class="btn" type="button" style="background-color: #4b4b4b; color: white;">구독</button>
                </div>
            </form>
        </div>
    </div>

    <div class="d-flex flex-column flex-sm-row justify-content-between py-4 my-4 border-top">
        <p>© 2024 RareField, Inc. All rights reserved.</p>
        <ul class="list-unstyled d-flex">
            <li class="ms-3"><a class="link-body-emphasis" href="#"><svg class="bi" width="24" height="24">
                        <use xlink:href="#twitter"></use>
                    </svg></a></li>
            <li class="ms-3"><a class="link-body-emphasis" href="#"><svg class="bi" width="24" height="24">
                        <use xlink:href="#instagram"></use>
                    </svg></a></li>
            <li class="ms-3"><a class="link-body-emphasis" href="#"><svg class="bi" width="24" height="24">
                        <use xlink:href="#facebook"></use>
                    </svg></a></li>
        </ul>
    </div>
</footer>

<script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>