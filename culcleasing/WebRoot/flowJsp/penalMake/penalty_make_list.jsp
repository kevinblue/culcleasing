<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金管理 - 罚息制定</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function addNew(){
	document.dataNav.action="penalty_make_add.jsp";
	document.dataNav.target="_blank";
	document.dataNav.submit();
	document.dataNav.action="penalty_meke_list.jsp";
	document.dataNav.target="_self";
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">租金管理&gt; 罚息制定</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "and 1=1";

String project_name = getStr( request.getParameter("project_name") );


if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and vci.project_name like '%" + project_name + "%'";
}


countSql = "select count(medi.contract_id) as amount from fund_penalty_hy_plan_medi medi LEFT JOIN vi_contract_info vci ON vci.contract_id=medi.contract_id"+
" where 1=1 "+wherestr;

%>

<form action="penalty_make_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>

<td>
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
	        <table border="0" cellspacing="0" cellpadding="0" >
	        	<tr class="maintab">
		         <td align="left">
		           <BUTTON class="btn_2" name="btnHire" value="新增"  type="button" onclick="return addNew()">
        			<img src="../../images/sbtn_new.gif" align="absmiddle" alt="移交(Alt+Y)" border="0">
        			&nbsp;新增
        			</button>
        			<input type="hidden" id="add_proj_id" name="add_proj_id">
		          </td>
		         </tr>
	        </table>
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

	    <th>合同编号</th>
	    <th>项目名称</th>
	    <th>承租人</th>
	    <th>项目经理</th>
	    <th>罚息期次</th>
	    <th>逾期租金</th>
	    <th>计收日期</th>
     	<th>实收日期</th>
 		<th>逾期天数</th>
 		<th>罚息</th>
      </tr>
      <tbody id="data">
<%
String col_str="medi.contract_id,vci.project_name,vci.cust_name,vci.proj_manage_name,rent_list,penalty_rent,penalty_rent_planDate,"+
				"penalty_rent_hireDate,penalty_day_amount,penalty";

sqlstr = "select top "+ intPageSize +" "+col_str+" from fund_penalty_hy_plan_medi medi ";
sqlstr += " LEFT JOIN vi_contract_info vci ON vci.contract_id=medi.contract_id";
sqlstr += " where medi.contract_id not in(  ";
sqlstr += " select top "+ (intPage-1)*intPageSize + " medi.contract_id from fund_penalty_hy_plan_medi  medi " ;
sqlstr += " LEFT JOIN vi_contract_info vci ON vci.contract_id=medi.contract_id";
sqlstr += " where 1=1 "+wherestr+" order by contract_id ) "+wherestr;
sqlstr +=" order by contract_id ";
System.out.println("变更保底SQL==="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty_rent"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("penalty_rent_planDate"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("penalty_rent_hireDate"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_day_amount"))%></td>
        <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty"))%></td>
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
