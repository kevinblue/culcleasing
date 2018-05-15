<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );
System.out.println("dddddddddddddddd"+stype);
if ( stype.equals("del") ){ 
	//修改资金计划表flag字段值为0
	sqlstr = " Update contract_fund_fund_charge_plan_bxf set flag=0 where id in( select plan_id from apply_info_detail where apply_id ="+sql_bh_ids+")";
	LogWriter.logDebug(request, "sss"+sqlstr);
	flag += db.executeUpdate(sqlstr);
	
	sqlstr="delete apply_info where glide_id="+sql_bh_ids;
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete apply_info_detail where apply_id="+sql_bh_ids;
	flag += db.executeUpdate(sqlstr);
	
	//日志操作
	String sqlLog = LogWriter.getSqlIntoDB(request, "保险管理", "批量保费支付", dqczy+"删除保费编号,"+sql_bh_ids, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="删除保费支付";
} else if ( stype.equals("sub") ){ 
	sqlstr="Update apply_info set is_sub='已提交',status='流程中' where glide_id in ('"+sql_bh_ids+"') ";
	System.out.println("dddddddddddddddd"+sql_bh_ids);
	System.out.println("dddddddddddddddd"+sqlstr);
  // 'sss'  sss
	flag += db.executeUpdate(sqlstr);
	message="提交保费支付";
}
if(flag!=0){
%>
<script>
<% if (stype.equals("sub") ){%>
	window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Insurance.nsf/OSNewWorkFlowFromBFZF?openagent&priId=<%=sql_bh_ids %>");
<% }%>	
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
</body>
</html>