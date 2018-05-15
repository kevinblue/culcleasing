<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<% 
String name=request.getParameter("name");
String pwd =request.getParameter("pwd");
/* if(request.form("name")!=null && request.form("name") !=""){
	//中文乱码解决方式
	 name=new String(request.form("name").getBytes("iso8859-1"),"UTF-8");//这个地方容易出现空指针异常a.b.c如果a为null就会出现异常
	 pwd=new String(request.form("pwd").getBytes("iso8859-1"),"UTF-8");;
} */
%>
<script type="text/javascript">

</script>
<body>
<a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
<!--form表单post提交 -->
  pwd:<%=pwd %>
   name:<%=name %>

   <br>
 <a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
</body>
//用于自动跳转父页面
<%if(1==0){ %>
<script type="text/javascript">
		window.close();
		opener.alert("返回上一个页面");
		opener.location.reload();
</script>
<%} %>
</html>