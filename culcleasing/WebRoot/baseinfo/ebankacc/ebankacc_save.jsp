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

String account = getStr( request.getParameter("account") );
String code = getStr( request.getParameter("code") );


String sqlstr;
ResultSet rs;
int flag=0;
String message="";
//-----------------判断重复--------------
String repeat_flag="0";
if ( stype.equals("add") ){ 
	sqlstr="select * from inter_account_ebankcode where account='"+account+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else if ( stype.equals("mod") ){ 
	sqlstr="select * from inter_account_ebankcode where account='"+account+"' and id<>'"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else{}

if ( stype.equals("add") ){ 
	if(repeat_flag.equals("0")){
		sqlstr="insert into inter_account_ebankcode (account,code) values('"+account+"','"+code+"')";
		flag = db.executeUpdate(sqlstr);
		message="添加我司银行帐户网银代码对应";
	}else{
		message="数据重复，";
	}

}
if ( stype.equals("mod") ){ 
	if(repeat_flag.equals("0")){
		sqlstr="update inter_account_ebankcode set account='"+account+"',code='"+code+"' where id='"+czid+"'";
		//System.out.println("sqlstr======================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		message="修改我司银行帐户网银代码对应";
	}else{
		message="数据重复，";
	}

}
if ( stype.equals("del") ){ 
	sqlstr="delete from inter_account_ebankcode where  id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	message="删除我司银行帐户网银代码对应";
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
<%}
		db.close();%>