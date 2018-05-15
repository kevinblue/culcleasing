<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="/public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>财务接口 - 资金收付计划表</title>
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

<form action="global_fundplan_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		财务接口&gt; 资金收付计划表</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

countSql = "Select count(id) as amount from FI_ERP_DATA_SYNC_LOG_NC where oper_name='NC资金收付计划表财务接口数据同步' "+wherestr;

%>

<!--可折叠查询开始-->
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="n" onClick="dataHander('add_modal','data_sync.jsp',dataNav.itemselect);">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="执行同步" align="absmiddle">执行同步</a></td>
	    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>操作日志Id</th>
        <th>操作类型</th>
        <th>操作名称</th>
        <th>操作时间</th>
        <th>新增数据量</th>

        <th>操作备注</th>
      </tr>
      <tbody id="data">
<%
String col_str="id,oper_id,oper_type,oper_name,oper_remark,oper_date,amount";

sqlstr = "select top "+ intPageSize +" "+col_str+" from FI_ERP_DATA_SYNC_LOG_NC where oper_name='NC资金收付计划表财务接口数据同步' and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from FI_ERP_DATA_SYNC_LOG_NC where oper_name='NC资金收付计划表财务接口数据同步' "+wherestr+" order by oper_date desc,id ) "+wherestr ;
sqlstr += " order by oper_date desc,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("oper_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("oper_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("oper_name")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("oper_date")) %></td>	
		
		<td align="center">
		<%= CurrencyUtil.convertIntAmount( rs.getString("amount" )) %>
		</td>
		<%-- 
		<td align="center">
			<a href="global_receive_sync_insert.jsp?oper_id=<%=getDBStr( rs.getString("oper_id")) %>" target="_blank">
				<%= CurrencyUtil.convertIntAmount( rs.getString("amount" )) %>
			</a>
		</td>	
		--%>
		<td align="left"><a href="global_receive_details.jsp?oper_id=<%=getDBStr( rs.getString("oper_id") )  %>" target="_blank"><%= getDBStr( rs.getString("oper_remark")) %></a></td>	
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
