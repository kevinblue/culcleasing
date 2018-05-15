<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金总表</title>
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
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">租金总表</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";




/*sqlstr = "select department ,parent_deptname , dept_name from v_base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	department = rs.getString("department");			//部门编号
	parent_deptname = rs.getString("parent_deptname");	//部门
	//dept_name = rs.getString("dept_name");				//大区
	wherestr = " and proj_dept = '"+department+"' ";
}else{
	wherestr += " and proj_dept like '%" + department + "%'";
}
rs.close();  */
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
//String parent_deptname = getStr( request.getParameter("department") );
String dept_name = getStr( request.getParameter("dept_name") );


String project_name = getStr( request.getParameter("project_name") );
String plan_date_start = getStr( request.getParameter("plan_date_start") );
String plan_date_end = getStr( request.getParameter("plan_date_end") );
String board_name = getStr( request.getParameter("board_name") );
String hire_date_start = getStr( request.getParameter("hire_date_start") );
String hire_date_end = getStr( request.getParameter("hire_date_end") );
String plan_status = getStr( request.getParameter("plan_status") );
String tax_type = getStr( request.getParameter("tax_type") );
String leas_type = getStr( request.getParameter("leas_type") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );

if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if ( board_name!=null && !board_name.equals("") ) {
	wherestr += " and board_name like '%" + board_name + "%'";
}
if ( parent_deptname!=null && !parent_deptname.equals("") ) {
	wherestr += " and parent_deptname like '%" + parent_deptname + "%'";
}
if ( dept_name!=null && !dept_name.equals("") ) {
	wherestr += " and dept_name like '%" + dept_name + "%'";
}
if ( plan_status!=null && !plan_status.equals("") ) {
	wherestr += " and plan_status like '%" + plan_status + "%'";
}
if ( tax_type!=null && !tax_type.equals("") ) {
	wherestr += " and tax_type like '%" + tax_type + "%'";
}
if ( leas_type!=null && !leas_type.equals("") ) {
	wherestr += " and leas_type like '%" + leas_type + "%'";
}
if ( plan_bank_no!=null && !plan_bank_no.equals("") ) {
	wherestr += " and plan_bank_no like '%" + plan_bank_no + "%'";
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
if(hire_date_start!=null && !"".equals(hire_date_start) && hire_date_end!=null && !"".equals(hire_date_end)){
	wherestr +=" and hire_date >= '"+hire_date_start+"' and hire_date<='"+hire_date_end+"'";
}
if(hire_date_start!=null && !"".equals(hire_date_start) && "".equals(hire_date_end)){
	wherestr +=" and hire_date >= '"+hire_date_start+"'";
}
if("".equals(plan_date_start) && hire_date_end!=null && !"".equals(hire_date_end)){
	wherestr +=" and hire_date <='"+hire_date_end+"'";
}

countSql = "select count(id) as amount from vi_fund_rent_plan_list where 1=1 "+wherestr;


String expsqlstr = "select proj_id  as '项目编号', contract_id  as '合同编号', begin_id as '起租编号' ,project_name as '项目名称' ,"
		+" parent_deptname as '项目部门' ,dept_name as '大区' ,cust_name as '承租客户' ,board_name as '板块名称' , "
		+" proj_manage_name as '项目经理' ,leas_type as '租赁类型' ,rent_list as '租金期次' ,plan_date as '计划日期' , "
		+" hire_date as '实收日期' ,rent as '租金' ,curr_rent as '剩余租金' ,rent_diff as '租金差异' , "
		+" corpus as '本金' ,curr_corpus as '剩余本金' ,interest as '利息' ,curr_interest as '剩余利息' , " 
		+" plan_status as '状态' ,tax_type as '税种' ,plan_bank_name as '计划银行' , " 
		+" plan_bank_no as '计划银行账户' ,factoring as '是否保理' "
		+" from vi_fund_rent_plan_list where 1=1 "+wherestr+" order by begin_id,rent_list ";
%>

<form action="rent_summary.jsp" name="dataNav" onSubmit="return goPage()">
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
		<input style="width:100px;" name="board_name" id="board_name" type="text" value="<%=board_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./trade.jsp',250,350)" >  
	</td>
	<%-- <td scope="row">部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门 ：
		<input style="width:100px;" name="parent_deptname" id="parent_deptname" type="text" value="<%=parent_deptname %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./department.jsp',250,350)" >  
	</td> --%>
	<td scope="row">大&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区 ：
		<input style="width:100px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./largeArea.jsp',250,350)" >  
	</td>
	</tr>

<tr>

<td>是否核销 ：
 <select name="plan_status">
    <script type="text/javascript">
     	w(mSetOpt('<%=plan_status %>',"|已回笼|未回笼|部分回笼","|已回笼|未回笼|部分回笼"));
    </script>
 </select>
</td>
<td>税&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;种 ：
 <select name="tax_type">
    <script type="text/javascript">
     	w(mSetOpt('<%=tax_type %>',"|营业税|增值税","|营业税|增值税"));
    </script>
 </select>
</td>
<td>租赁类型 ：
 <select name="leas_type">
    <script type="text/javascript">
     	w(mSetOpt('<%=leas_type %>',"|融资租赁|售后回租赁|新设备回租赁|结构分成式租赁","|融资租赁|售后回租赁|新设备回租赁|结构分成式租赁"));
    </script>
 </select>
</td>
<td scope="row">计划银行账户 ：
		<input style="width:100px;" name="plan_bank_no" id="plan_bank_no" type="text" value="<%=plan_bank_no %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('./planBankNo.jsp',250,350)" >  
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
	     从<input type="text"  name="hire_date_start"
    			 readonly="readonly" 
    			 value="<%=hire_date_start %>" 
    			 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
    		  	 到<input type="text"  name="hire_date_end"
    			 readonly="readonly" 
    			 value="<%=hire_date_end %>" 
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
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','rent_summary.jsp');">
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
	    <th>项目编号</th>
	    <th>合同编号</th>
	    <th>起租编号</th>
     	<th>项目名称</th>
     	<th>项目部门</th>
     	<th>大区</th>
     	<th>承租客户</th>
     	<th>板块名称</th>
     	<th>项目经理</th>
     	<th>租赁类型</th>
     	<th>租金期次</th>
     	<th>计划日期</th>
     	<th>实收日期</th>
     	<th>租金</th>
     	<th>剩余租金</th>
     	<th>租金差异</th>
     	<th>本金</th>
     	<th>剩余本金</th>
     	<th>利息</th>
     	<th>剩余利息</th>
     	<th>状态</th>
     	<th>税种</th>
     	<th>计划银行</th>
     	<th>计划银行账户</th>
     	<th>是否保理</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fund_rent_plan_list where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_rent_plan_list where 1=1 "+wherestr+" order by begin_id,rent_list ) "+wherestr ;
sqlstr +=" order by begin_id,rent_list  ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("board_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("hire_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("curr_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent_diff"))%></td>
		<td align="left"><%=getDBStr(rs.getString("corpus"))%></td>
		<td align="left"><%=getDBStr(rs.getString("curr_corpus"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("curr_interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_bank_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("factoring"))%></td>
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
