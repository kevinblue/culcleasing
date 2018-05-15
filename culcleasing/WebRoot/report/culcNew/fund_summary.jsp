<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金总表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
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

<form name="list" action="khyj.jsp" method="post" target="_blank">
<input type="hidden" name="khstr" id="khstr" value="">
</form>

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">资金总表</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String parent_deptname = "";
sqlstr = "select parent_deptname from v_base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	parent_deptname = rs.getString("parent_deptname");
	wherestr = " and parent_deptname = '"+parent_deptname+"' ";
}else{
	wherestr = " and 1<>1 ";
}
rs.close();


String department = getStr( request.getParameter("department") );
String dept_name = getStr( request.getParameter("dept_name") );
String industry_type_name = getStr( request.getParameter("industry_type_name") );

String project_name = getStr( request.getParameter("project_name") );

String plan_date_start = getStr( request.getParameter("plan_date_start") );
String plan_date_end = getStr( request.getParameter("plan_date_end") );

String fact_date_start = getStr( request.getParameter("fact_date_start") );
String fact_date_end = getStr( request.getParameter("fact_date_end") );

String plan_status = getStr( request.getParameter("plan_status") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String pay_obj_name = getStr( request.getParameter("pay_obj_name") );
String fee_type_name = getStr( request.getParameter("fee_type_name") );


if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if ( industry_type_name!=null && !industry_type_name.equals("") ) {
	wherestr += " and industry_type_name like '%" + industry_type_name + "%'";
}
if ( parent_deptname!=null && !parent_deptname.equals("") ) {
	wherestr += " and parent_deptname like '%" + parent_deptname + "%'";
}
if ( dept_name!=null && !dept_name.equals("") ) {
	wherestr += " and dept_name like '%" + dept_name + "%'";
}
if(plan_date_start!=null && !"".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"' and plan_date<='"+plan_date_end+"'";
}
if(plan_date_start!=null && !"".equals(plan_date_start) && "".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"'";
}
if("".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date <='"+plan_date_end+"'";
}
if(fact_date_start!=null && !"".equals(fact_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
	wherestr +=" and fact_date >= '"+fact_date_start+"' and fact_date<='"+fact_date_end+"'";
}
if(fact_date_start!=null && !"".equals(fact_date_start) && "".equals(fact_date_end)){
	wherestr +=" and fact_date >= '"+fact_date_start+"'";
}
if("".equals(plan_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
	wherestr +=" and fact_date <='"+fact_date_end+"'";
}
if ( plan_status!=null && !plan_status.equals("") ) {
	wherestr += " and plan_status like '%" + plan_status + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name = '" + proj_manage_name + "'";
}
if ( pay_obj_name!=null && !pay_obj_name.equals("") ) {
	wherestr += " and pay_obj_name = '" + pay_obj_name + "'";
}
if ( fee_type_name!=null && !fee_type_name.equals("") ) {
	wherestr += " and fee_type_name = '" + fee_type_name + "'";
}

countSql = "select count(id) as amount from vi_report_contract_fund_fund_charge_plan where 1=1 "+wherestr;


String expsqlstr = "select project_name  as '项目名称', proj_id  as '项目编号', contract_id as '合同编号' ,parent_deptname as '部门' ,"
		+" dept_name as '大区' ,proj_manage_name as '项目经理' ,cust_name as '承租人' , industry_type_name as '行业' ,"
		+" fee_type_name as '付款方式' ,fee_name as '款项名称' ,fee_num as '期次' ,plan_date as '计划日期' , "
		+" fact_date as '实收日期' ,plan_money as '计划金额' ,pay_way as '款项类型' ,pay_obj_name as '收/付款对象' , "
		+" pay_bank_name as '收/付款人银行' ,pay_bank_no as '收/付款人账号' ,plan_bank_name as '计划收/付开户银行' ,plan_bank_no as '计划收/付银行账号' , " 
		+" plan_statusName as '资金状态' ,plan_status as '状态' "
		+" from vi_report_contract_fund_fund_charge_plan where 1=1 "+wherestr+" order by contract_id , fee_num ";
%>

<form action="fund_summary.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;视图过滤
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
	<td scope="row">项目名称 ： 
		<input name="project_name"  type="text" size="13" value="<%=project_name %>">
	</td>
	<td scope="row">行&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业 ：
		<input style="width:100px;" name="industry_type_name" id="industry_type_name" type="text" value="<%=industry_type_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./industryTypeName.jsp',250,350)" >  
	</td>
	<%-- <td scope="row">部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门 ：
		<input style="width:100px;" name="parent_deptname" id="parent_deptname" type="text" value="<%=parent_deptname %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./department.jsp',250,350)" >  
	</td> --%>
	<td scope="row">大&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区 ：
		<input style="width:100px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./largeArea.jsp',250,350)" >  
	</td>
	</tr>

<tr>
<td scope="row">项目经理 ： 
		<input style="width:100px;" name="proj_manage_name" id="proj_manage_name" type="text" value="<%=proj_manage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./projManageName.jsp',250,350)" >  
</td>
<td>状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态 ：
 <select name=plan_status>
    <script type="text/javascript">
     	w(mSetOpt('<%=plan_status %>',"|已核销|未核销","|已核销|未核销"));
    </script>
 </select>
</td>
<td scope="row">收/付款对象：
		<input style="width:100px;" name="pay_obj_name" id="pay_obj_name" type="text" value="<%=pay_obj_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./payObjectName.jsp',250,350)" >  
</td>
<td scope="row">款项内容：
		<input style="width:100px;" name="fee_type_name" id="fee_type_name" type="text" value="<%=fee_type_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./feeTypeName.jsp',250,350)" >  
</td>
</tr>
<tr>
	<td colspan ="2">计划日期 ：
	     从<input type="text"  name="plan_date_start"
    			 readonly="readonly" 
    			 value="<%=plan_date_start %>" 
    			 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
    		  	 到<input type="text"  name="plan_date_end"
    			 readonly="readonly" 
    			 value="<%=plan_date_end %>" 
    			 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	</td>
	<td colspan ="2">实收日期 ：
	     从<input type="text"  name="fact_date_start"
    			 readonly="readonly" 
    			 value="<%=fact_date_start %>" 
    			 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
    		  	 到<input type="text"  name="fact_date_end"
    			 readonly="readonly" 
    			 value="<%=fact_date_end %>" 
    			 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	</td>
</tr>
<tr>	
<td colspan ="4" align="right">
<input type="button" value="查询" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->


<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
        <td align="left" width="1%"><!--操作按钮开始-->
	    <input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="opinion_list">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','fund_summary.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
        </td>
        <!--操作按钮结束-->
        
        <td align="right" width="95%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>项目名称</th>
	    <th>项目编号</th>
	    <th>合同编号</th>
     	<th>部门</th>
     	<th>大区</th>
     	<th>项目经理</th>
     	<th>承租人</th>
     	<th>行业</th>
     	<th>付款方式</th>
     	<th>款项名称</th>
     	<th>期次</th>
     	<th>计划日期</th>
     	<th>实收日期</th>
     	<th>计划金额</th>
     	<th>款项类型</th>
     	<th>收/付款对象</th>
     	<th>收/付款人银行</th>
     	<th>收/付款人账号</th>
     	<th>计划收/付开户银行</th>
     	<th>计划收/付银行账号</th>
     	<th>资金状态</th>
     	<th>状态</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_report_contract_fund_fund_charge_plan where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_report_contract_fund_fund_charge_plan where 1=1 "+wherestr+" order by contract_id , fee_num ) "+wherestr ;
sqlstr +=" order by contract_id , fee_num  ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_type_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_num"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("fact_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("plan_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_way"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_obj_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_bank_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_bank_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_statusName"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
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
