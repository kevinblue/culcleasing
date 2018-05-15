<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String context = request.getContextPath();
String userId=(String) session.getAttribute("czyid");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>提前终止确认结果展示表 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">	
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
		
</script>



<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_end_confirm.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">
<input id="sqlIds" name="sqlIds" type="hidden" >
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="fee_name_list" id="fee_name_list"/>
<input type="hidden" name="fee_num_list" id="fee_num_list"/>
<input type="hidden" name="invoice_statues" id="invoice_statues"/>
<input type="hidden" name="invoice_statues_list" id="invoice_statues_list"/>


<!-- 资金计划数据 -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		提前终止确认结果展示表</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String advance_start_date = getStr(request.getParameter("advance_start_date"));
String advance_end_date = getStr(request.getParameter("advance_end_date"));
String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(advance_start_date!=null && !"".equals(advance_start_date) && advance_end_date!=null && !"".equals(advance_end_date)){
	wherestr +=" and advance_date>= '"+advance_start_date+"' and advance_date<='"+advance_end_date+"'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}



countSql = "select count(id) as amount from vi_contract_advance_show where 1=1 "+wherestr;

//导出类型2--数据导出
String  exportcolumn="contract_id 合同号,begin_id 起租编号,project_name 项目名称 , parent_deptname 部门,dept_name 大区,proj_manage_name 项目经理,";
	exportcolumn +="advance_date 提前结清日期,over_rent 逾期租金,over_corpus  剩余本金,rent_rate 租赁利率,interest_month 补偿利息月数,";
		exportcolumn +="interest_income 补偿利息收入,rent_diff  租金差异总和,interest_income  补偿利息收入,cur_interest  支付日利息,";
			exportcolumn +="guarantee_money 保证金余额,nominal_price  残值收入,	agree_interest  商定利息,agree_penalty  商定罚息,penalty_income  罚息回收,";
				exportcolumn +="irr  提前结束预计IRR,action_date 款项实际到账日期,real_money  应收提前结清款,action_money  实际到账提前结清款";
String expsqlstr = "select "+exportcolumn+" from vi_contract_advance_show where 1=1 "+wherestr;
String updSql="select id from vi_contract_advance_show where 1=1 "+wherestr;
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>项目经理:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 项目经理','(select distinct proj_manage_name as proj_manage_name from vi_contract_info) a ','proj_manage_name','','proj_manage_name','proj_manage_name','asc','dataNav.proj_manage_name','');">
</td>
<td>部门:&nbsp;<input  name="parent_deptname" id="parent_deptname" size="15"  type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 部门','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</td>
</tr>
<tr>
<td>大&nbsp;&nbsp;&nbsp;&nbsp;区:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 大区','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>
</tr>
<td >提前结清日期:&nbsp;<input name="advance_start_date" type="text" size="15" readonly dataType="Date" value="<%=advance_start_date %>">
<img  onClick="openCalendar(advance_start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="advance_end_date" type="text" size="15" readonly dataType="Date" value="<%=advance_end_date %>">
<img  onClick="openCalendar(advance_end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<tr>
 
</tr>
<tr>

<td ><input type="button" value="清空" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="查询" onclick="dataNav.submit();"></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td align="left" width="20%">
	<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
	<!--	<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','invoice_export_result.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>-->
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%">
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
		<th>项目编号</th>
	    <th>合同编号</th>
	    <th>起租编号</th>
		<th>项目名称</th>
		<th>部门名称</th>
		<th>大区名称</th>
		<th>项目经理</th>
		<th>提前结清日期</th>
		<th>逾期租金</th>
		<th>剩余本金(未到期本金)</th>
	 	<th>租赁利率</th>
		<th>补偿利息月数</th>
		<th>补偿利息收入</th>
		<th>租金差异总和</th>	
		<th>补偿利息收入</th>
		<th>支付日利息</th>
		<th>保证金余额</th>
		<th>残值收入</th>
		<th>商定利息</th>
		<th>商定罚息</th>
		<th>罚息回收</th>
		<th>提前结束预计IRR</th>
		<th>款项实际到账日期</th>
		<th>应收提前结清款</th>
		<th>实际到账提前结清款</th>	
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_contract_advance_show where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_contract_advance_show where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

System.out.println("sqlstr查询条件"+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">	
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("advance_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("over_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("over_corpus"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest_month"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest_income"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_diff"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest_income"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cur_interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("guarantee_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("nominal_price"))%></td>
     	<td align="left"><%=getDBStr(rs.getString("agree_interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("agree_penalty"))%></td>
		<td align="left"><%=getDBStr(rs.getString("penalty_income"))%></td>
		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("action_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("real_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("action_money"))%></td>
		
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
