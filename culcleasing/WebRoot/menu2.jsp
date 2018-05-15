<%@ page 
language="java"
contentType="text/html; charset=GB2312"
pageEncoding="GB2312"
%>
<%
String user=request.getParameter("userid");
out.print("user="+user);
String menuurl=request.getParameter("menuurl");
session.setAttribute("czyid",user);
String dqczy=(String) session.getAttribute("czyid");
out.print("dqczy="+dqczy);
%>
<script>
     window.location.href="<%=menuurl%>";
</script>