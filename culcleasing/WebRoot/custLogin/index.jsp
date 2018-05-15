<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/frameset.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>人力资源管理系统</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.2900.3492" name=GENERATOR></HEAD>
<%
	  String cust_id = request.getParameter("cust_id");
	  String user_name = request.getParameter("user_name");
	  String password = request.getParameter("password");
	  int cust_person_id = Integer.parseInt(request.getParameter("cust_person_id"));
	%>
<FRAMESET frameSpacing=0 rows=80,* frameBorder=0>
<FRAME name=top src="index/YHTop.jsp" frameBorder=0 noResize scrolling=no>

<FRAMESET frameSpacing=0 frameBorder=0 cols=220,*>
<FRAME name=menu src="index/YHMenu.jsp?cust_id=<%=cust_id%>&user_name='<%=user_name%>'&password='<%=password%>'&cust_person_id=<%=cust_person_id%>" frameBorder=0 noResize>
<FRAME name=dmMain src="index/welcome.jsp" frameBorder=0 scrolling='NO'></FRAMESET>

</FRAMESET>
	
	</HTML>
