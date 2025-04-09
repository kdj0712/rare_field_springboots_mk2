<%@ page import="java.util.HashMap, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>update Form</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

</head>

<body>
    <!-- Menu -->
    <%@ include file="/WEB-INF/sample/views/commons/header.jsp" %>

    <!-- Main Content -->

    <form action="/files/update" method="post" id="insertForm" enctype="multipart/form-data">
        <div class="container mt-5">
            <div class="container mt-4">
                <div class="row">
                    <h2>update Form</h2>
                    <input type="hidden" name="storePath" value="${storePath}">

                    <div class="mb-3">
                        <label for="title" class="form-label">Title</label>
                        <input type="text" class="form-control" id="title" name="title" value="${title}">
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
                        <input type="file" class="form-control-file" id="fileUpload_0" name="multipartFile"/>
                        <span>
                            <a href="${remoteServerUrl}<%= fileUnique %>/<%= fileName %>"><%= fileName %></a>
                            <img src="${remoteServerUrl}<%= fileUnique %>/<%= fileName %>" alt="" width="30">
                        </span>
                    </div>
                    <input type="hidden" name="fileUnique" value="<%= fileUnique %>">
                    <%
                    }
                    %>
                    
                    <div class="d-inline-block">
                        <button type="submit" class="btn btn-primary">Submit</button>
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
            theme: 'snow'
        }); // 대상 지정과 css 적용

        quill.setContents(${content});

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