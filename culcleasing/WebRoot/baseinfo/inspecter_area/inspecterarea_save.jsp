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

String inspecter = getStr( request.getParameter("inspecter") );



String sqlstr;
ResultSet rs;
int flag=0;
String message="";

if ( stype.equals("mod") ){ 
sqlstr="delete from inspect_area where city_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
if (inspecter.length()>0){
sqlstr="insert into inspect_area(city_id,inspecter) values ('"+czid+"','"+inspecter+"')";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
}
else
{
flag=1;
}
message="�޸Ŀ���Ա�������򻮷�";

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