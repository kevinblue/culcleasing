<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<% 
String custId=request.getParameter("custId");
%>
<script type="text/javascript">

</script>
<body>

<a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
<!--超链接   -->
    
   custId:<%=custId%>
     <br>
 <a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
</body>
</html>