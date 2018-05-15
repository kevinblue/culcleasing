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
String cust_id = getStr( request.getParameter("cust_id") );
String brand_name = getStr( request.getParameter("brand_name") );
String brand_type = getStr( request.getParameter("brand_type") );
String brand_attribute = getStr( request.getParameter("brand_attribute") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into cust_brand (cust_id,brand_name,brand_type,brand_attribute) values ('"+cust_id+"','"+brand_name+"','"+brand_type+"','"+brand_attribute+"')";
flag = db.executeUpdate(sqlstr);
message="添加总对总客户下属品牌";
}
if ( stype.equals("mod") ){ 
sqlstr="update cust_brand set cust_id='"+cust_id+"',brand_name='"+brand_name+"',brand_type='"+brand_type+"',brand_attribute='"+brand_attribute+"' where brand_id="+czid;
flag = db.executeUpdate(sqlstr);
message="修改总对总客户下属品牌";
}
if ( stype.equals("del") ){ 
sqlstr="delete from cust_brand where  brand_id="+czid;
flag = db.executeUpdate(sqlstr);
message="删除总对总客户下属品牌";
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