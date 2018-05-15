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


String lessor = getStr( request.getParameter("lessor") );
String leaseconsigner = getStr( request.getParameter("leaseconsigner") );
String lease_acc_number = getStr( request.getParameter("lease_acc_number") );
String client = getStr( request.getParameter("client") );
String clientconsigner = getStr( request.getParameter("clientconsigner") );
String client_acc_number = getStr( request.getParameter("client_acc_number") );
String client_linkman = getStr( request.getParameter("client_linkman") );
String client_postcode = getStr( request.getParameter("client_postcode") );
String client_address = getStr( request.getParameter("client_address") );
String client_mobile_number = getStr( request.getParameter("client_mobile_number") );
String client_tel = getStr( request.getParameter("client_tel") );
String client_fax = getStr( request.getParameter("client_fax") );
String client_email = getStr( request.getParameter("client_email") );



int flag=0;
String message="";

if ( stype.equals("mod") ){ 
sqlstr="update contract_signatory set contract_id='"+czid+"',lessor='"+lessor+"',leaseconsigner='"+leaseconsigner+"',lease_acc_number='"+lease_acc_number+"',client='"+client+"',clientconsigner='"+clientconsigner+"',client_acc_number='"+client_acc_number+"',client_linkman='"+client_linkman+"',client_postcode='"+client_postcode+"',client_address='"+client_address+"',client_mobile_number='"+client_mobile_number+"',client_tel='"+client_tel+"',client_fax='"+client_fax+"',client_email='"+client_email+"' where contract_id='"+czid+"'";
System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改合同各方";
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
<%}db.close();%>