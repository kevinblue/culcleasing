<%@ page 
language="java"
contentType="text/html; charset=GB2312"
pageEncoding="GB2312"
%>
<%
String user=request.getParameter("userid");
session.setAttribute("czyid",user);
%>
<script>
     window.close();
</script>