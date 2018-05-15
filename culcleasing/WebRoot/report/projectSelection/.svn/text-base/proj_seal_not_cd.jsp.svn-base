<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款材料交接 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_seal_not_cd.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 已盖章未CD交接表-->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		已盖章未CD交接表</td>
	</tr>
</table> 

<%

wherestr = " and seal_date is not null and seal_date <> '1900-01-01 00:00:00.000' and contract_status='启用' and isseal='1' and ( place_flag <> 1 or place_flag is null  ) and cli.proj_id not in (select project_id from sys_flow_list where flow_name like '%CD交接%' and flow_end_time is null ) ";

String day = getStr( request.getParameter("day") );

if(day.equals("30")){
	wherestr +=" and getdate() >= dateadd(day,30,seal_date) "; 
}else if(day.equals("60")){
	wherestr +=" and getdate() >= dateadd(day,60,seal_date) ";
}else{
	wherestr +=" and getdate() >= dateadd(day,30,seal_date) "; 
}
String expsqlstr = "select cli.proj_id as '项目编号', vci.project_name as '项目名称',cli.make_contract_id as '合同编号',cli.contract_name as '合同名称',cli.contract_main_type as '合同主类型',cli.contract_type as '合同类型',vci.parent_deptname as '部门' ,vci.dept_name as '大区',vci.proj_manage_name as '项目经理',cli.seal_date as '盖章时间' from  contract_list_info AS cli INNER JOIN vi_contract_info AS vci ON cli.phy_contract_id = vci.contract_id where 1=1 "+wherestr+"order by cli.id";
countSql = "select count(cli.id) as amount from  contract_list_info AS cli INNER JOIN vi_contract_info AS vci ON cli.phy_contract_id = vci.contract_id where 1=1 "+wherestr;

%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<!-- 查询内容 -->
</tr>
<tr>

<td scope="row" id="bj_4">已经盖章未完成CD交接：&nbsp;
 <select name="day" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=day %>',"已盖章大于30天|已盖章大于60天","30|60"));
    </script>
 </select>
</td>
</tr>
<td align="right"> <input type="button" value="查询" onclick="dataNav.submit();">
<!-- <input type="button" value="清空" onclick="clearQuery();" ></td> -->
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->
<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
		<td>
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="seal_not_cd">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','proj_seal_not_cd.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	    </td>
		
		<!-- 翻页控制 -->
		<td width="60%" align="right"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->
		</td><!-- 翻页结束 -->
</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>项目编号</th>
		<th>项目名称</th>
		<th>合同编号</th>
		<th>合同名称</th>
		<th>合同主类型</th>
		<th>合同类型</th>
		<th>部门</th>
		<th>大区</th>
		<th>项目经理</th>
		<th>盖章时间</th>
      </tr>
   <tbody id="data">
<%

sqlstr = "select top "+ intPageSize +" cli.id,cli.proj_id,cli.phy_contract_id,cli.make_contract_id,cli.contract_name,cli.contract_main_type,cli.contract_type,cli.seal_date, vci.project_name , vci.parent_deptname ,vci.dept_name ,vci.proj_manage_name from  contract_list_info AS cli INNER JOIN vi_contract_info AS vci ON cli.phy_contract_id = vci.contract_id where cli.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" clii.id from  contract_list_info AS clii INNER JOIN vi_contract_info AS vcii ON clii.phy_contract_id = vcii.contract_id where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
%>
<%-- <tr><td>sqlstr</td><td colspan="100"><%=sqlstr %></td></tr>
<tr><td>expsqlstr</td><td colspan="100"><%=expsqlstr %></td></tr>
<tr><td>countSql</td><td colspan="100"><%=countSql %></td></tr> --%>
<%
while ( rs.next() ) {
%>   
     <tr >
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("make_contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_main_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("seal_date"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>  
     </tbody>
</table>
</div>
</form>

</body>
</html>
