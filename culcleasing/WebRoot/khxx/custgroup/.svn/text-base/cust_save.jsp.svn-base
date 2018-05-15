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

String group_id = getStr( request.getParameter("group_id") );
String cust_id = getStr( request.getParameter("cust_id") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from cust_group_company where group_id='"+group_id+"' and cust_id='"+cust_id+"'";
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	message="该集团成员重复,添加";
}
else
{
sqlstr="insert into cust_group_company (group_id,cust_id) values('"+group_id+"','"+cust_id+"')";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="添加集团";
}
rs.close();
}


if ( stype.equals("del") ){ 
sqlstr="delete from cust_group_company where  group_id='"+group_id+"' and cust_id='"+cust_id+"'";
flag = db.executeUpdate(sqlstr);
message="删除集团成员";
}
if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
			opener.opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
			opener.opener.location.reload();
		</script>
<%}db.close();%>