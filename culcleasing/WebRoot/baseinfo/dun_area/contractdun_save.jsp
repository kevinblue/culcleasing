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

String dun = getStr( request.getParameter("dun") );



String sqlstr;
ResultSet rs;
int flag=0;
String message="";

if ( stype.equals("mod") ){ 
sqlstr="delete from contract_dun where contract_id='"+czid+"'";
flag = db.executeUpdate(sqlstr);
if (dun.length()>0){
sqlstr="insert into contract_dun(contract_id,dun) values ('"+czid+"','"+dun+"')";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
}
else
{
flag=1;
}
message="修改催款员负责合同划分";

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