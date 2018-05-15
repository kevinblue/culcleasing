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
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String	contract_id = getStr( request.getParameter("contract_id") );
String	equip_sn = getStr( request.getParameter("equip_sn") );
String	remark = getStr( request.getParameter("remark") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
	sqlstr="insert into downpayment_info (contract_id,equip_sn,remark,confirm_date) values('"+contract_id+"','"+equip_sn+"','"+remark+"','"+curr_date+"')";
	System.out.println(sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="DownpaymentList信息保存";
}
if ( stype.equals("mod") ){ 
sqlstr="select contract_id from downpayment_info  where contract_id='"+czid+"'";
rs = db.executeQuery(sqlstr); 
if(rs.next()){
sqlstr="update downpayment_info set equip_sn='"+equip_sn+"',remark='"+remark+"',confirm_date='"+curr_date+"' where contract_id='"+czid+"'";
System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="DownpaymentList信息保存";
}else{
	sqlstr="insert into downpayment_info (contract_id,equip_sn,remark,confirm_date) values('"+contract_id+"','"+equip_sn+"','"+remark+"','"+curr_date+"')";
	System.out.println(sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="DownpaymentList信息保存";
}
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