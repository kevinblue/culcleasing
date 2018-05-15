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

String credit_type_id = getStr( request.getParameter("credit_type_id") );
String credit_type_name = getStr( request.getParameter("credit_type_name") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into base_right_credit_type (credit_type_id,credit_type_name) values('"+credit_type_id+"','"+credit_type_name+"')";
flag = db.executeUpdate(sqlstr);
message="添加权限认证方式";
}
if ( stype.equals("mod") ){ 
sqlstr="update base_right_credit_type set credit_type_name='"+credit_type_name+"' where credit_type_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改权限认证方式";
}
if ( stype.equals("del") ){ 
sqlstr="delete from base_right_credit_type where  credit_type_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除权限认证方式";
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