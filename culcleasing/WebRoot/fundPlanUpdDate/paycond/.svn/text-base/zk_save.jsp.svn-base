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

	
//获取基础参数
String item_id = getStr( request.getParameter("item_id") );//主键
String zk_fee_name_val = getStr( request.getParameter("zk_fee_name_val") );//主键
String doc_id = getStr( request.getParameter("doc_id") );//主键
//基本变量
String sqlstr;
String sqlstr1="";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间
String sqlstr2="";
String sqlstr3="";
sqlstr3="update contract_fund_fund_charge_ZK set flag=2 where fund_uuid='"+item_id+"' and doc_id<>'"+doc_id+"'";
	db.executeUpdate(sqlstr3);

int flag = 0;
sqlstr1="delete from contract_fund_fund_charge_ZK where fund_uuid='"+item_id+"' and doc_id='"+doc_id+"'";
flag = db.executeUpdate(sqlstr1);
sqlstr = "insert into contract_fund_fund_charge_ZK (fund_uuid,fund_zkuuid,doc_id)";
sqlstr+="select '"+item_id+"','"+zk_fee_name_val+"','"+doc_id+"'";
flag += db.executeUpdate(sqlstr);

db.close();
if(flag>0){%>
	<script type="text/javascript">
	opener.alert("坐扣成功!");
	opener.location.reload();
	if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
	else{history.back()}
	</script>
<%
	} else {
%>
	<script type="text/javascript">
	opener.alert("坐扣失败!");
	opener.location.reload();
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
