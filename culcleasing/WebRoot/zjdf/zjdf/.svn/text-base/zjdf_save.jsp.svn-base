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
String contract_id = getStr( request.getParameter("contract_id") );
String advance_amt = getStr( request.getParameter("advance_amt") );
String advance_cust = getStr( request.getParameter("advance_cust") );
String close_date = getStr( request.getParameter("close_date") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into fund_rent_advance (contract_id,advance_amt,advance_cust,close_date,creator,create_date) values('"+contract_id+"',"+advance_amt+",'"+advance_cust+"','"+close_date+"','"+dqczy+"','"+curr_date+"')";
flag = db.executeUpdate(sqlstr);
message="添加租金垫付";
}
if ( stype.equals("mod") ){ 
sqlstr="update fund_rent_advance set contract_id='"+contract_id+"',advance_amt="+advance_amt+",advance_cust='"+advance_cust+"',close_date='"+close_date+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where id="+czid;
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改租金垫付";
}
if ( stype.equals("del") ){ 
sqlstr="delete from fund_rent_advance where  id="+czid;
flag = db.executeUpdate(sqlstr);
message="删除租金垫付";
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