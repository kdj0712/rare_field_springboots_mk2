<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/rarefield/views/commons/header.jsp" %>

<style>


</style>



<main class="row justify-content-between">

    <%@ include file="/WEB-INF/rarefield/views/commons/side_left_banner.jsp" %>

    <div class="col-8 row">
        
<form action="" class="p-5">

  <div class="justify-content-start text-start">
    <div class="fw-bold fs-5">
      {{ QnAs.ques_title }}
    </div>
    <div>

    </div>
    <div class="row text-start">
      <div class="col-1">
        {{ QnAs.ques_writer }}
      </div>
      <div class="col-2"> {{ QnAs.ques_time }}</div>
    </div>


    <hr>

    <div class="p-5 rounded">
      <div class="col-md-6">
        <p class="lead">{{ QnAs.ques_content }}</p>
      </div>
    </div>
    <div>

    </div>
    <div>
      답변
    </div>
    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
      <div class="col p-4 d-flex flex-column position-static">
        <p class="card-text mb-auto">{{ QnAs.ques_answer }}</p>
      </div>
    </div>
    <div style="text-align: end;" class="p-2">
      <button class="btn btn-primary" type="submit" formaction="/other/other_QnA_main" formmethod="get">목록</button>
    </div>





    <!-- </div>
<hr>
<textarea type="" class="form-control text-box" name="ques_answer" id="content" placeholder="답글은 최대 1개씩만 달 수 있습니다. 이 부분은 나중에 관리자 페이지로 이동할 예정"></textarea>
<br>
<div style="text-align: end;">
<button class="btn btn-primary" type="submit" formaction="/other/other_reply/{{QnAs.id}}" formmethod="post">답글달기</button>
<button class="btn btn-danger" type="submit" formaction="/other/other_delete/{{QnAs.id}}" formmethod="post">글 삭제</button>
</div> -->
</form>
    </div>

    <%@ include file="/WEB-INF/rarefield/views/commons/side_right_banner.jsp" %>

      
    </main>
    <hr>
    <%@ include file="/WEB-INF/rarefield/views/commons/footer.jsp" %>

    <script>
    

      
    </script>
    

    </html>