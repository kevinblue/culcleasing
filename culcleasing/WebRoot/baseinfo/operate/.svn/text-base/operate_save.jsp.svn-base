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

String operate_id = getStr( request.getParameter("operate_id") );
String module_id = getStr( request.getParameter("module_id") );
String operate_name = getStr( request.getParameter("operate_name") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into base_operate (operate_id,module_id,operate_name) values('"+operate_id+"','"+module_id+"','"+operate_name+"')";
flag = db.executeUpdate(sqlstr);
message="添加权权限操作";
}
if ( stype.equals("mod") ){ 
sqlstr="update base_operate set module_id='"+module_id+"',operate_name='"+operate_name+"' where operate_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改权权限操作";
}
if ( stype.equals("del") ){ 
sqlstr="delete from base_operate where  operate_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除权权限操作";
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