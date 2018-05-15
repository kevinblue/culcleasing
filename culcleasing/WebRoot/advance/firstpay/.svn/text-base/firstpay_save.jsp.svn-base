<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String	contract_id = getStr( request.getParameter("contract_id") );
String	savetype = getStr( request.getParameter("savetype") );
String	special_date_number = getStr( request.getParameter("special_date") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
sqlstr = "select * from downpayment_info where contract_id = '"+contract_id+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr);
if ( rs.next() == false) {
	stype="add";
}else{
	stype="mod";
}
if ( savetype.equals("mod") ){ 
sqlstr="update fund_rent_advance set special_date_number='"+special_date_number+"' where contract_id='"+contract_id+"'";
System.out.println(sqlstr);
flag = db.executeUpdate(sqlstr);
message="firstpayList信息修改";
}

if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}
		db.close();%>