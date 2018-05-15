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

String contract_id = getStr( request.getParameter("contract_id") );
String invoice_number = getStr( request.getParameter("invoice_number") );
String invoice_date = getStr( request.getParameter("invoice_date") );
String invoice_amt = getStr( request.getParameter("invoice_amt") );
String all_flag = getStr( request.getParameter("all_flag") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into contract_equip_invoice (contract_id,invoice_number,invoice_date,invoice_amt,all_flag,creator,create_date) values('"+contract_id+"','"+invoice_number+"','"+invoice_date+"',"+invoice_amt+",'"+all_flag+"','"+dqczy+"','"+curr_date+"')";
System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="添加合同设备发票情况";
}
if ( stype.equals("mod") ){ 
sqlstr="update contract_equip_invoice set contract_id='"+contract_id+"',invoice_number='"+invoice_number+"',invoice_date='"+invoice_date+"',invoice_amt="+invoice_amt+",all_flag='"+all_flag+"' where id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改合同设备发票情况";
}
if ( stype.equals("del") ){ 
sqlstr="delete from contract_equip_invoice where  id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除合同设备发票情况";
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