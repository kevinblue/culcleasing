<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<jsp:directive.page import="com.rent.calc.tx.TransRateNew"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'txTest.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>&nbsp; 
<% 
	//TransRateNew trr = new TransRateNew();
	//List list = new ArrayList();
	//list.add("001");
	//list.add("002");
	//list.add("003");
	//list.add("004");
	//list.add("005");
	//list.add("006");
	//list.add("007");
	//10%,已付款的
	//trr.processInterest("56",list);
	//out.print("调息成功!");
	
 
 %>
 <jsp:forward page="tx_executeTx.jsp"></jsp:forward>
  </body>
</html>
