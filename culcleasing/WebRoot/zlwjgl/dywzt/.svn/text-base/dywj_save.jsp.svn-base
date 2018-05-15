<%@ page contentType="text/html; charset=gbk" language="java"%>
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
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;

String id="";
String equip_status="";
String status_date="";


String n = getStr( request.getParameter("i") );
int i_num=0;
if(!n.equals("")){
	i_num=Integer.parseInt(n);
}
for(int i=0;i<i_num;i++){
	id = getStr(request.getParameter("equip_id"+i));
	equip_status = getStr(request.getParameter("equip_status"+i));
	status_date = getStr(request.getParameter("status_date"+i));
	sqlstr="update contract_guarantee_equip set equip_status='"+equip_status+"',status_date='"+status_date+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where contract_guarantee_equip.id="+id;
	db.executeUpdate(sqlstr);
}
db.close();
%>
<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>