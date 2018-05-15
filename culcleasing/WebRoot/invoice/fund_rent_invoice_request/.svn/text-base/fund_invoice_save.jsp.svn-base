<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 

<%@ page import="dbconn.*"%>
<%@ page import="com.tenwa.culc.util.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common_simple.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/calend.js"></script>

</head>

<BODY>
<%

String invoice_type = getStr( request.getParameter("invoice_type") );
String tax_type_invoice = getStr( request.getParameter("tax_type_invoice") );
String id = getStr( request.getParameter("id") );


String sqlstr="";
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

		sqlstr="update contract_fund_fund_charge_plan set invoice_type='',tax_type_invoice='' where id= "+id;
		System.out.println("sqlstrsqlstr1=="+sqlstr);
		int i=0;
		i=db.executeUpdate(sqlstr); 
		if(i!=0){
%>
		<script>			
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.alert("修改失败!");
			window.history.go(-1);
		</script>
<%
		}

db.close();
%>
</BODY>
</HTML>
