<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.jspsmart.upload.SmartUpload"%>

<html>
<body>
<%
String fileName = request.getParameter("file_name");
String filePath = request.getParameter("file_path");
System.out.println("下载文件路径+文件名称是"+filePath+"____"+fileName);
//下载文件
SmartUpload su = new SmartUpload();
su.setContentDisposition(null);
su.initialize(pageContext);
su.downloadFile(pageContext.getServletContext().getRealPath("/")+filePath+fileName);

%>
<script>
	window.close();
</script>
</body>
</html>
