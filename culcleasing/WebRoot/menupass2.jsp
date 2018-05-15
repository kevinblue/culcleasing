<%@ page 
language="java"
contentType="text/html; charset=GB2312"
pageEncoding="GB2312"
%>
<%
String user=request.getParameter("userid");
String menuurl=request.getParameter("menuurl");
session.setAttribute("czyid",user);
%>
<script>
     window.location.href="<%=menuurl%>";
</script>