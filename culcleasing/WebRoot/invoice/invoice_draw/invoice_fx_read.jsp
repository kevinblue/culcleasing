<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>票据管理 - 罚息增值税发票领取列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String glide_id= getStr( request.getParameter("glide_id") );

wherestr = " and id in(Select pri_id from invoice_draw_detail where apply_id='"+glide_id+"' and invoice_type='罚息')";

countSql = "select count(id) as amount from vi_func_penalty_manage_draw where 1=1 "+wherestr;

%>

<body onload="public_onload(0);">
<form action="invoice_fx_read.jsp" name="dataNav" onSubmit="return goPage()">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			票据管理 - 税罚息发票领取
		</td>
	</tr>
</table><!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			</td>
		</tr>
		</table>
		<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplit.jsp"%>
	</td><!--翻页控制结束-->	
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
	     	<th>项目编号</th>
			<th>起租编号</th>
		    <th>项目名称</th>
		    <th>客户名称</th>
			<th>部门名称</th>
		    <th>大区名称</th>
	     	<th>项目经理</th>
	 		<th>租金笔数</th>
	 		
			<th>租金应收日期</th>
			<th>租金实收日期</th>
			<th>罚息</th>
			<th>发票开具方式</th>
			
			<th>税种</th>
			<th>增值税发票类型</th>
		</tr>
<tbody id="data">
<%
sqlstr = "select top "+ intPageSize +" * from vi_func_penalty_manage_draw where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_penalty_manage_draw where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("penalty_rent_planDate"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("penalty_rent_hireDate"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type_name"))%></td>	

		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
	</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>

