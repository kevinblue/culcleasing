<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<jsp:useBean id="fc" scope="page" class="com.filter.FilterCredit" /> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>CULC WAS Index</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
	<h3>�����������ṩ����</h3>
	<a href="report/penaReport/fact_hire_gap_static.jsp" target="new">����ʵ�ʼ����ѯ��</a> <br>
	<a href="report/penaReport/fact_hire_gap_diff_static.jsp" target="new">����ʵ�ʼ�������</a> <br>
	<a href="report/penaReport/fact_hire_gap_detail_static.jsp" target="new">����ʱ����Ŀ��ϸ��</a> <br>

  </body>
</html>
