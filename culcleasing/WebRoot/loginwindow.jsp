<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%String userid = request.getParameter("uuid");
  boolean flag = false;
  if(userid!=null&&!userid.equals("")){
  	session.setAttribute("czyid",userid);
  	flag = true;
  }
%>
<script language="javascript">
window.close();
</script>