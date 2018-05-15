<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>

	<BODY>
		<%
//===========================================
	//修改资金计划
//===========================================
	
//获取基础参数
String item_id = getStr( request.getParameter("item_id") );//主键

//获取资金计划数据参数
String plan_date = getStr( request.getParameter("plan_date") );
String fpnote = getStr( request.getParameter("fpnote") );

//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;

//修改资金计划
sqlstr = "update contract_fund_fund_charge_plan_temp set plan_date='"+plan_date+"',fpnote='"+fpnote+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";
flag = db.executeUpdate(sqlstr);

db.close();
if(flag>0){%>
	<script type="text/javascript">
	window.close();
	opener.alert("修改资金计划成功!");
	opener.location.reload();
	</script>
<%
	} else {
%>
	<script type="text/javascript">
	window.close();
	opener.alert("修改资金计划失败!");
	opener.location.reload();
	</script>
<%
	}
%>
</BODY>
</HTML>
