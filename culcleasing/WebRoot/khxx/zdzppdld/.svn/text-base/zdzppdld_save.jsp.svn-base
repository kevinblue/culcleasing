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
String brand_id = getStr( request.getParameter("brand_id") );
String sale_id = getStr( request.getParameter("sale_id") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr="insert into cust_brand_sale (brand_id,sale_id) values ('"+brand_id+"','"+sale_id+"')";
flag = db.executeUpdate(sqlstr);
message="添加总对总客户品牌下属代理商";
}
if ( stype.equals("mod") ){ 
sqlstr="update cust_brand_sale set brand_id='"+brand_id+"',sale_id='"+sale_id+"' where id="+czid;
flag = db.executeUpdate(sqlstr);
message="修改总对总客户品牌下属代理商";
}
if ( stype.equals("del") ){ 
sqlstr="delete from cust_brand_sale where  id="+czid;
flag = db.executeUpdate(sqlstr);
message="删除总对总客户品牌下属代理商";
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