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
String sort_year = getStr( request.getParameter("sort_year") );
String sort_month = getStr( request.getParameter("sort_month") );
String risk_dept_sort = getStr( request.getParameter("risk_dept_sort") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into contract_classification (contract_id,sort_year,sort_month,risk_dept_sort) values('"+contract_id+"',"+sort_year+","+sort_month+",'"+risk_dept_sort+"')";
flag = db.executeUpdate(sqlstr);
message="添加五级分类";
}
if ( stype.equals("mod") ){ 
sqlstr="update contract_classification set sort_year="+sort_year+",sort_month="+sort_month+",risk_dept_sort='"+risk_dept_sort+"' where id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改五级分类";
}
if ( stype.equals("del") ){ 
sqlstr="delete from contract_classification where  id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除五级分类";
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