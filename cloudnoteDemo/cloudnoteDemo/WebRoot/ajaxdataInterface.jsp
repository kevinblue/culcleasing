<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数据交互方式</title>
<script Language="Javascript" src="scripts/jquery.js"></script>
<script Language="Javascript" src="scripts/ajaxfileupload.js"></script>
<style type="text/css">
.divcss5{

} 
</style>
</head>
<script type="text/javascript">

function fileUploadAjax() {
    if ($("#file_AjaxFile").val().length > 0) {
        //progressInterval=setInterval(getProgress,500);
        $.ajaxFileUpload({
          url:'<%=request.getContextPath()%>/FileUpload/fileUpload_ajax.do', //用于文件上传的服务器端请求地址
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

</script>
 <body> 
 <a href="xiala.html">返回上一页</a>
 <br>
 <form name="form5" action="/" method="post" enctype="multipart/form-data">
    <input type="file" id="file_AjaxFile" name="file_AjaxFile">
    <input type="button" value="upload" onclick="fileUploadAjax()"/><span id="sp_AjaxFile"></span><br><br>
    上传进度：<span id="sp_fileUploadProgress">0%</span>
</form>

<br>
<div class="cnblogs_code">
 <div class="cnblogs_code_toolbar">
   <span class="cnblogs_code_copy">
     <a href="javascript:void(0);" onclick="copyCnblogsCode(this)">复制代码</a>
   </span>
 </div>
 <pre>
   标题头
 </pre>
<span>function fileUploadAjax() { </span>

 <span>   if ($("#file_AjaxFile").val().length > 0) { </span>
   <span>     //progressInterval=setInterval(getProgress,500); </span>
   <span>     $.ajaxFileUpload({  </span>
     <span>     url:'<%=request.getContextPath()%>/FileUpload/fileUpload_ajax.do', </span>
 
       <span>     type: "post",</span>
      <span>      secureuri: false, //一般设置为false</span>
            <br>
      <span>     fileElementId: 'file_AjaxFile', //文件上传空间的id属性  <input type="file" id="file1" name="file" /></span>
            <br>
       <span>     dataType: 'application/json', //返回值类型 一般设置为json</span>
            <br>
      <span>      success: function (data)  //服务器成功响应处理函数</span>
            <br>
       <span>     {</span>
            <br>
        <span>        var jsonObject = eval('(' + data + ')');</span>
                <br></span>
         <span>       $("#sp_AjaxFile").html(" Upload Success ！ filePath:" + jsonObject.filePath);<br></span>
        <span>    },</span>
         <span>   error: function (data, status, e)//服务器响应失败处理函数<br></span>
         <span>   {</span>
            <br>
         <span>       alert(e);<br></span>
         <span>   }</span>
            <br>
    <span>   });//end ajaxfile</span>
 

  <div>
</body>
</html>