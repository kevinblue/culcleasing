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
	String	advance_amt = getStr( request.getParameter("advance_amt") );
	String	special_flag = getStr( request.getParameter("special_flag") );
	String	special_date_number = getStr( request.getParameter("special_date_number") );
	String	special_date = getStr( request.getParameter("special_date") );
	String	income_total = getStr( request.getParameter("income_total") );
	String	id = getStr( request.getParameter("id") );
	String	contract_id = getStr( request.getParameter("contract_id") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
	sqlstr="insert into fund_rent_advance (contract_id,advance_amt,special_flag,special_date_number,special_date,income_total) values('"+contract_id+"','"+advance_amt+"','"+special_flag+"','"+special_date_number+"','"+special_date+"','"+income_total+"')";
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="添加垫付信息";
}
if ( stype.equals("mod") ){ 
sqlstr="update fund_rent_advance set advance_amt='"+advance_amt+"',special_flag='"+special_flag+"',special_date_number='"+special_date_number+"',special_date='"+special_date+"',income_total='"+income_total+"' where id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改垫付信息";
}
if ( stype.equals("del") ){ 
sqlstr="delete from fund_rent_advance where  id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除垫付信息";
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