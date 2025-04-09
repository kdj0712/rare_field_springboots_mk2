<%@ page import="java.util.HashMap, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>read Form</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

</head>

<body>
    <!-- Menu -->
    <%@ include file="/WEB-INF/sample/views/commons/header.jsp" %>

    <!-- Main Content -->

    <form method="post" id="insertForm" enctype="multipart/form-data">
        <div class="container mt-5">
            <div class="container mt-4">
                <div class="row">
                    <h2>read Form</h2>
                    <input type="hidden" name="storePath" value="${storePath}">

                    <div class="mb-3">
                        <label for="title" class="form-label">Title</label>
                        <input type="text" class="form-control" id="title" name="title" value="${title}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editor" class="form-label">Content</label>
                        <div id="editor" style="height: 300px;" class="form-control"></div>
                        <input type="hidden" name="content" id="contentInput" />
                    </div>
                    <%
                    HashMap attachfile = (HashMap)request.getAttribute("attachfile");

                    String fileUnique = "";
                    String fileName = "";
                    if(attachfile != null){
                        fileUnique = (String)attachfile.get("FILE_UNIQUE");
                        fileName = (String)attachfile.get("FILE_NAME");
                    %>
                    <div class="mb-3">
                        <label for="fileUpload_0" class="form-label">File Upload</label>
                        <span>
                            <a href="${remoteServerUrl}<%= fileUnique %>/<%= fileName %>"><%= fileName %></a>
                            <img src="${remoteServerUrl}<%= fileUnique %>/<%= fileName %>" alt="" width="30">
                        </span>
                    </div>
                    <%
                    }
                    %>
                    <div class="d-inline-block">
                        <button type="submit" class="btn btn-primary" formaction="/files/form" formmethod="get">Insert</button>
                        <button type="submit" class="btn btn-primary" formaction="/files/update" formmethod="Post">Update</button>
                    </div>

                </div>
            </div>
        </div>

    </form>

    <!-- Footer -->
    <%@ include file="/WEB-INF/sample/views/commons/footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <script>
        let quill = new Quill('#editor', {
            readOnly: true,
        }); // 대상 지정과 css 적용

        quill.setContents(${content});
        // 다시 수정 가능 상태로 변경하기
        // quill.enable();

        // Set hidden input value before form submission
        let form = document.querySelector('#insertForm');
        form.onsubmit = function () {
            var contentInput = document.querySelector('#contentInput');
            contentInput.value = JSON.stringify(quill.getContents());
            return true;
        };
    </script>

</body>

</html>