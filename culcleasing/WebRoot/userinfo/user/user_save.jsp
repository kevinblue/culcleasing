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
	String  compid = getStr( request.getParameter("compid") );
	String	compname = getStr( request.getParameter("compname") );
	String	manage_id = getStr( request.getParameter("manage_id") );
	String	manage_name = getStr( request.getParameter("manage_name") );
	String	manage_phone = getStr( request.getParameter("manage_phone") );
	String	overArea = getStr( request.getParameter("overArea") );
	String	obligate2 = getStr( request.getParameter("obligate2") );
	String	obligate3 = getStr( request.getParameter("obligate3") );
	String	obligate4 = getStr( request.getParameter("obligate4") );
	String  obligate5 = getStr( request.getParameter("obligate5") );
	String savetype =  getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";

if ( savetype.equals("add") ){ 
sqlstr = "select max(manage_id) manage_id from userInfo where manage_id like 'MANA-US%'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 

if ( rs.next()) {
	manage_id = getDBStr( rs.getString("manage_id") );
	if(manage_id==null || manage_id=="")
	{
		manage_id = "MANA-US0001";
	}
	else
	{
	String temp = ("000"+(Integer.parseInt(manage_id.substring(7,manage_id.length()))+1));
	manage_id = "MANA-US" + temp.substring(temp.length()-4,temp.length());
	}
	System.out.print(manage_id);	
	}
	else{
		manage_id = "MANA-US0001";
	}
	
	sqlstr = "insert into userInfo(manage_id, compid, manage_name, manage_phone, overArea) values(";
	sqlstr += "'"+manage_id+"','"+compid+"','"+manage_name+"','"+manage_phone+"','"+overArea+"')";
	System.out.print(sqlstr);
	
	flag = db.executeUpdate(sqlstr);
	db.close();
	message="添加业务员信息";
}
if ( savetype.equals("mod") ){ 
	sqlstr = "update userInfo set compid='"+compid+"', manage_name='"+manage_name+"', manage_phone='"+manage_phone+"', overArea='"+overArea+"' where manage_id='"+manage_id+"'";
	System.out.print(sqlstr);
	flag = db.executeUpdate(sqlstr);
	db.close();
	message="修改业务员信息";
}
if ( savetype.equals("del") ){ 
	sqlstr = "delete from userInfo where manage_id='"+manage_id+"'";
	System.out.print(sqlstr);
	flag = db.executeUpdate(sqlstr);
	db.close();
	message="删除业务员信息";
}
if(flag!=0){
%>
<script>
			opener.alert("<%=message%>成功!");
			opener.location.reload();
			window.close();
		</script>
<%
}else{
%>
<script>
			
			opener.alert("<%=message%>失败!");
			opener.location.reload();
			window.close();
		</script>
<%}
db.close();%>