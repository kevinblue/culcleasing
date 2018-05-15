<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%


//获取基础参数
String title = getStr( request.getParameter("title") );
String exchange_rate= getStr( request.getParameter("exchange_rate") );


int flag = 0;
String msg = "";
//1.先删除
sqlstr="delete from base_currency where currency_name='"+title+"'";
flag=db.executeUpdate(sqlstr);
//2.后添加
String sqlStr1="insert into base_currency(currency_name,exchange_rate) values('"+title+"','"+exchange_rate+"')";
flag+=db.executeUpdate(sqlStr1);
	
	msg = "汇率修改";


//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>失败!");
		window.opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>