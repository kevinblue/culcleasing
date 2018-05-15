<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>fileUpload</title>
  <%--  <script src="<%=basePath%>scripts/jquery-1.11.1.js"></script>
    <script src="<%=basePath%>scripts/ajaxfileupload.js"></script>--%> 
    <script Language="Javascript" src="scripts/jquery.js"></script>
<script Language="Javascript" src="scripts/ajaxfileupload.js"></script>
</head>
<body>
<h3>文件上传</h3><br>

<h3>采用 fileUpload_multipartFile ， file.transferTo 来保存上传的文件</h3>
<form name="form1" action="<%=path%>/FileUpload/fileUpload_multipartFile.do" method="post" enctype="multipart/form-data">
    <input type="file" name="file_upload">
    <input type="submit" value="upload" onclick="return check()"/>
</form>
<hr>

<h3>采用 fileUpload_multipartRequest file.transferTo 来保存上传文件</h3>
<form name="form2" action="<%=path%>/FileUpload/fileUpload_multipartRequest.do" method="post" enctype="multipart/form-data">
    <input type="file" name="file_upload">
    <input type="submit" value="upload"/>
</form>
<hr>

<h3>采用 CommonsMultipartResolver file.transferTo 来保存上传文件</h3>
<form name="form3" action="<%=path%>/FileUpload/fileUpload_CommonsMultipartResolver.do" method="post" enctype="multipart/form-data">
    <input type="file" name="file_upload">
    <input type="submit" value="upload"/>
</form>
<hr>

<h3>通过流的方式上传文件</h3>
<form name="form4" action="<%=path%>/FileUpload/fileUpload_stream.do" method="post" enctype="multipart/form-data">
    <input type="file" name="file_upload">
    <input type="submit" value="upload"/>
</form>
<hr>

<h3>通过ajax插件 ajaxfileupload.js 来异步上传文件</h3>
<form name="form5" action="/" method="post" enctype="multipart/form-data">
    <input type="file" id="file_AjaxFile" name="file_AjaxFile">
    <input type="button" value="upload" onclick="fileUploadAjax()"/><span id="sp_AjaxFile"></span><br><br>
    上传进度：<span id="sp_fileUploadProgress">0%</span>
</form>
<script type="text/javascript">

function check() { 
    var userName =$("input[name='file_upload']").val(); 
    /*  var orgId =$("select[name='orgId']").val(); */ 
    if(checkSubmitMobil()==false){ 
    return false; 
} 
}
    function fileUploadAjax() {
        if ($("#file_AjaxFile").val().length > 0) {
            //progressInterval=setInterval(getProgress,500);
            $.ajaxFileUpload({
                url:'<%=path%>/FileUpload/fileUpload_ajax.do', //用于文件上传的服务器端请求地址
                type: "post",
                secureuri: false, //一般设置为false
                fileElementId: 'file_AjaxFile', //文件上传空间的id属性  <input type="file" id="file1" name="file" />
                dataType: 'application/json', //返回值类型 一般设置为json
                success: function (data)  //服务器成功响应处理函数
                {
                    var jsonObject = eval('(' + data + ')');
                    $("#sp_AjaxFile").html(" Upload Success ！ filePath:" + jsonObject.filePath);
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    alert(e);
                }
            });//end ajaxfile
        }
        else {
            alert("请选择文件!");
        }
    }
    var progressInterval = null;
    var i=0;
   /*  var getProgress=function (){
        $.get("/FileUpload/fileUploadprogress",
                {},
        function (data) {
            $("#sp_fileUploadProgress").html(i+++data);
            if(data==100||i==100)
                clearInterval(progressInterval);
        }
    );
    } */
</script>
<hr>

<h3>多文件上传 采用 MultipartFile[] multipartFile 上传文件方法</h3>
<form name="form5" action="<%=basePath%>/FileUpload/fileUpload_spring_list.do" method="post" enctype="multipart/form-data">
    <input type="file" name="file_upload">
    <input type="file" name="file_upload">
    <input type="file" name="file_upload">
    <input type="submit" value="upload"/>
</form>
<hr>

<h3>通过 a 标签的方式进行文件下载</h3><br>
<a href="<%=basePath%>files/download/mst.txt">通过 a 标签下载文件 mst.txt</a>
<hr>
<h3>通过 Response 文件流的方式下载文件</h3>
<a href="<%=basePath%>/FileUpload/fileDownload_servlet.do">通过 文件流 的方式下载文件 mst.txt</a>

</body>
</html>