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

String id = getStr( request.getParameter("id") );//KEY
String curr_date = getSystemDate(0);//�Ǽ�����
String stype = getStr( request.getParameter("savetype") );//�����ж����޸Ļ�����������
String fin_interest = getStr( request.getParameter("fin_interest") );//�޸ĵ�ȷ�������ֶ�


String sqlstr;
//ResultSet rs;
int flag = 0;
String message="";

if ( stype.equals("mod") ){ 
	sqlstr="update fund_rent_plan set fin_interest = '"+fin_interest+"',create_date='"+curr_date+"' where id='"+id+"'";
	//out.println("sqlstr======================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="�޸�ȷ������";
	//rs.close();
}
if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>�ɹ�!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>ʧ��!");
			opener.location.reload();
		</script>
<%}db.close();%>