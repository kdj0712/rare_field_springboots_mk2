<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 5 Template</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
</head>

<body>

    <!-- Menu -->
    <%@ include file="/WEB-INF/sample/views/commons/header.jsp" %>

    <!-- Main Content -->
    <%
        String name = (String)request.getAttribute("name");
    %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2>Search</h2>
                <div class="input-group mb-3">
                    <input type="text" value="<%= name %>" class="form-control" placeholder="Search..." id="keydownEnter">
                    <button class="btn btn-primary" type="button" onclick="carTableBody()">Go</button>
                </div>
            </div>
            <div class="col-5">
                <div>Spring Security Area</div>
                <sec:authentication property="principal" var="userDetailsBean" />
                <div> userDetails : ${userDetailsBean} </div>
                <div> Role List : ${userDetailsBean == "anonymousUser" ? "Not Yet!" : userDetailsBean.authorities} </div>
            </div>
            <div class="col-7">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Link(without CommonsCodeRestController, CarInforsRestController)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a href="/r/helloWorld">/helloWorld</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldGetRequest/yojulab/U-01">/helloWorldGetRequest/{name}/{Id}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldResponse/1/10/1">/helloWorldResponse/{currentPage}/{perPage}/{SN}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldResponseList/1/10/1">/helloWorldResponseList/{currentPage}/{perPage}/{SN}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldResponseWithService/1/10/1">/helloWorldResponseWithService/{currentPage}/{perPage}/{SN}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldResponseFake/C001">/helloWorldResponseFake/{companyId}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="/r/helloWorldResponseFakeWithExcepation/C001">/helloWorldResponseFakeWithExcepation/{companyId}</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
        <%@ include file="/WEB-INF/sample/views/commons/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>