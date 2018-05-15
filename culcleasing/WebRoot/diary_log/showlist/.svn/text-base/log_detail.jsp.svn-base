<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目日程明细</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="proj_exec_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<!--标题结束-->

<%
String loadtime=getStr(request.getParameter("loadtime"));
LogWriter.logDebug(request,"我需要的loadtime2:"+loadtime);
String logType=getStr(request.getParameter("logType"));
wherestr = "";

wherestr += " and datediff(dd,loadtime,'"+loadtime+"')=0 ";//显示当天数据
//根据type显示不同类型数据
if ( "htsp".equals( logType )){
	wherestr +=" and (flow_name like '项目签约审批流程%' or flow_name like '项目签约变更流程%' or  flow_name in('资金计划上报流程','商务方案修订流程','合同废止流程','项目签约撤销流程'))";
}else if( "zjgl".equals( logType )){
	wherestr +=" and flow_name in ('起租流程','租前息确认流程','租金核销流程','租金红冲流程','罚息红冲流程')";
}else if("xmlxgl".equals( logType )){
	wherestr +=" and (flow_name like '项目立项流程%' or flow_name like '项目变更流程%')";
}else if("xmsp".equals( logType )){
	wherestr +=" and (flow_name like '资信评估流程%' or flow_name like '二次上会%' or flow_name like '%部资信评估子流程')";
}else if("cdgl".equals( logType )){
	wherestr +=" and flow_name like '%CD交接流程%'";
}else if("xjtf".equals( logType )){
	wherestr +=" and (flow_name like '%付款流程%' or flow_name like '%收款流程%')";
}else if("zhbg".equals( logType )){
	wherestr +=" and flow_name ='合同变更流程'";
}else if("rzgl".equals( logType )){
	wherestr +=" and  flow_name = '融资授信流程'";
}else if("bxgl".equals( logType )){
	wherestr +=" and flow_name in ('保险变更流程','租赁物件维护流程','保险续保客户流程','保险投保租赁流程','保险续保租赁流程')";
}else if("zhgl".equals( logType )){
	wherestr +=" and  flow_name in ('逾期通知流程','重大事故流程','风险预警流程','减免罚息流程')";
}
else if("htjq".equals( logType )){
	wherestr +=" and  flow_name like '%合同结清流程%'";
}
else if("htjs".equals( logType )){
	wherestr +=" and  flow_name like '%合同结束流程%'";
}else{
	wherestr +=" and 1=2 ";
}
%>

<!--可折叠查询开始-->
<!--可折叠查询结束-->

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>项目编号</th>
		<th>合同编号</th>
		<th>项目名称</th>
		<th>项目经理</th>
		
		<th>出单部门</th>
		<th>所属板块</th>
		<th>流程阶段</th>
		<th>正在处理人员</th>
		
		<th>接受时间</th>
		<th>处理人员耗时(时)</th>
		<th>本流程耗时(天)</th>
		<th>流程状态</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select "+col_str+" from SYS_diary_log_detail where 1=1 "+wherestr +" order by convert(int,flow_operact_hours) desc";
LogWriter.logDebug(request,"我需要的sqlstr4:"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td><%=getDBStr(rs.getString("project_id")) %></td>
		<td><%=getDBStr(rs.getString("contract_id")) %></td>
		<td><%=getDBStr(rs.getString("project_name")) %></td>
		<td><%=getDBStr(rs.getString("proj_manage_name")) %></td>
		<td><%=getDBStr(rs.getString("dept_name")) %></td>
		<td><%=getDBStr(rs.getString("board_name")) %></td>
		<td><%=getDBStr(rs.getString("flow_name")) %></td>
		<td><%=getDBStr(rs.getString("operactor_now")) %></td>
		<td><%=getDBStr(rs.getString("operactor_date")) %></td>
		<td><%=getDBStr(rs.getString("operact_hours")) %></td>
		<td><%=getDBStr(rs.getString("flow_operact_hours")) %></td>			
		<td><%=getDBStr(rs.getString("status_name")) %></td>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
