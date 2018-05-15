<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.CommonTool"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>

	<BODY>
<%
	
//获取基础参数
String item_id = getStr( request.getParameter("item_id") );//主键
String type = getStr( request.getParameter("type") );
String drawings_id = getStr( request.getParameter("drawings_id") );
//资金计划参数
String factorage_type = getStr( request.getParameter("factorage_type") );
String factorage_paytype = getStr( request.getParameter("factorage_paytype") );
System.out.println("=============="+factorage_paytype);
String factorage_date = getStr( request.getParameter("factorage_date") );
String factorage_money = getStr( request.getParameter("factorage_money") );
String factorage_remark = getStr( request.getParameter("factorage_remark") );
String currency_type = getStr( request.getParameter("currency_type") );
//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String msg = "";
ResultSet rs = null;

 
if("del".equals(type)){//删除该资金计划
	//2.2删除
	sqlstr = "delete from financing_drawings_factorage where id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "删除手续费";
}
if("add".equals(type)){
	
	
	int fee_num = 0;
	sqlstr = "insert into financing_drawings_factorage (doc_id,drawings_id,factorage_type,factorage_money,factorage_paytype,factorage_date,factorage_remark,creator,create_date,modifactor,modify_date,currency) values (null,'"+drawings_id+"','"+factorage_type+"','"+factorage_money+"','"+factorage_paytype+"','"+factorage_date+"','"+factorage_remark+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"','"+currency_type+"')";

		flag = db.executeUpdate(sqlstr);
		
		msg = "新增手续费";
	
	db.close();
	
}

//3返回判断
if(flag>0){%>
		<script type="text/javascript">
		window.opener.alert("<%=msg%>成功!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
</script>
		<%
			} else {
		%>
		<script type="text/javascript">
		window.opener.alert("<%=msg%>失败!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}	
	</script>
		<%
		}
		%>
	</BODY>
</HTML>
