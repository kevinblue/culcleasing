<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>

<html>
<body>
<%
String fileName = request.getParameter("file_name");
System.out.println("�ļ�������"+fileName);
//�����ļ�
SmartUpload su = new SmartUpload();
su.setContentDisposition(null);
su.initialize(pageContext);
su.downloadFile(pageContext.getServletContext().getRealPath("/")+"/rent_cx_upload/"+fileName);

%>
<script>
	window.close();
</script>
</body>
</html>
