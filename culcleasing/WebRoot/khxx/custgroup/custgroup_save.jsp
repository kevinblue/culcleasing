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

String group_name = getStr( request.getParameter("group_name") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from cust_group where group_name='"+group_name+"'";
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	message="�ü��������ظ�,���";
}
else
{
sqlstr="insert into cust_group (group_name) values('"+group_name+"')";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="��Ӽ���";
}
rs.close();
}

if ( stype.equals("mod") ){ 
sqlstr = "select * from cust_group where group_name='"+group_name+"' and  group_id<>'"+czid+"'";
rs=db.executeQuery(sqlstr);
if (rs.next())
{
	message="�ü��������ظ�,�޸�";
}
else
{
sqlstr="update cust_group set group_name='"+group_name+"' where group_id='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="�޸ļ���";
}
rs.close();
}
if ( stype.equals("del") ){ 
sqlstr="delete from cust_group_company where  group_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
sqlstr="delete from cust_group where  group_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="ɾ������";
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