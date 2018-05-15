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
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);

String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String status = getStr( request.getParameter("status") );
String business_flag = getStr( request.getParameter("business_flag") );
String client_name = getStr( request.getParameter("client_name") );
int flag=0;
String message="";

if ( stype.equals("mod") ){ 
	sqlstr="update fund_ebank_data set status='"+status+"',business_flag='"+business_flag+"',client_name='"+client_name+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where ebdata_id='"+czid+"'";
	//System.out.println("sqlstr======================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="修改";
}
db.close();
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
<%}%>