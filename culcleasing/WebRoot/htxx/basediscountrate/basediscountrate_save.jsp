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
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);

String start_date = getStr( request.getParameter("start_date") );
String discount_rate = getStr( request.getParameter("discount_rate") );

String stype = getStr( request.getParameter("savetype") );

String str_flag="";
if ( stype.equals("del") || stype.equals("")){
	sqlstr="select * from base_discount_rate where 1=0";
}else if ( stype.equals("add") ){ 
	sqlstr="select * from base_discount_rate where start_date='"+start_date+"'";
	
}else{ 
	sqlstr="select * from base_discount_rate where start_date='"+start_date+"' and id<>'"+czid+"'";
}
rs=db.executeQuery(sqlstr);
if(rs.next()){
	str_flag="1";
}rs.close();


int flag=0;
String message="";
if ( stype.equals("add")){ 
	if(str_flag.equals("")){
		sqlstr="insert into base_discount_rate (start_date,discount_rate,creator,create_date) values('"+start_date+"',"+discount_rate+",'"+dqczy+"','"+curr_date+"')";
		flag = db.executeUpdate(sqlstr);
	}
	message="添加折现率";
}
if ( stype.equals("mod")){ 
	if(str_flag.equals("")){
		sqlstr="update base_discount_rate set start_date='"+start_date+"',discount_rate="+discount_rate+",modificator='"+dqczy+"',modify_date='"+curr_date+"' where id="+czid;
		flag = db.executeUpdate(sqlstr);
	}
	message="修改折现率";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from base_discount_rate where  id="+czid;
	flag = db.executeUpdate(sqlstr);
	message="删除折现率";
}

if ( str_flag.equals("1")){

%>
<script>
			window.close();
			opener.alert("开始日期已经存在！");
			opener.location.reload();
		</script>
<%
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