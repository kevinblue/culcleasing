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
String pwd=request.getParameter("pwd");
String controller="";
String method="";
if(request.getParameter("controller")!=null){
	//中文乱码解决方式
	 controller=new String(request.getParameter("controller").getBytes("iso8859-1"),"UTF-8");//这个地方容易出现空指针异常a.b.c如果a为null就会出现异常
	 method=new String(request.getParameter("method").getBytes("iso8859-1"),"UTF-8");;
}

String id=request.getParameter("id");
%>
<script type="text/javascript">

</script>
<body>

<a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
<!--超链接   -->
     超链接：<%=id%>
     <br>
     <!--form表单get方式   -->
  form表单get1：
     <br>
     <%= name%>
     <%=pwd%>
     <br>
  form表单get2： 
     <br>
     <%= controller%>
     <%=method%>
     <br>
 <a href="<%=request.getContextPath()%>/dataInterface.jsp">返回上一页</a>
<br>
</body>
</html>