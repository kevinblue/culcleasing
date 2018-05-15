<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="/func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理 - 网银申请</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
String curr_date = getSystemDate(0);
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String plan_start_date = getStr(request.getParameter("plan_start_date"));
String plan_end_date = getStr(request.getParameter("plan_end_date"));
String proj_id = getStr(request.getParameter("proj_id"));
String prod_id = getStr(request.getParameter("prod_id"));
String dld_name = getStr(request.getParameter("dld_name"));
String account_name = getStr(request.getParameter("account_name"));
String bank = getStr(request.getParameter("bank"));
String exp_state = getStr(request.getParameter("exp_state"));
String fee_type = getStr(request.getParameter("fee_type"));

wherestr=" and 1=1 ";

if(!exp_state.equals("")){
	if( "未导出".equals(exp_state) ){
		wherestr+=" and isnull(exp_state,0) = 0 ";
	}else{
		wherestr+=" and isnull(exp_state,0) > 0 ";
	}	
}


 if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),qz_date,21)>='"+start_date+"' ";
} 
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),qz_date,21)<='"+end_date+"' ";
}

 if(plan_start_date!=null && !"".equals(plan_start_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+plan_start_date+"' ";
} 
if(plan_end_date!=null && !"".equals(plan_end_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+plan_end_date+"' ";
}


if(!proj_id.equals("")){
	wherestr +=" and proj_id like '%"+proj_id+"%'";
}
if(!prod_id.equals("")){
	wherestr +=" and prod_id = '"+prod_id+"'";
}
if(!fee_type.equals("")){
	wherestr +=" and fee_type = '"+fee_type+"'";
}

if(!dld_name.equals("")){
	wherestr +=" and dld like '%"+dld_name+"%'";
}
if(!account_name.equals("")){
	wherestr +=" and account_name like '%"+account_name+"%'";
}
if(!bank.equals("")){
	wherestr +=" and bank ='"+bank+"'";
}

sqlstr=" select item_id as memo,proj_id,rent_list,isnull(costmoney,0) as costmoney, ";
sqlstr+=" fee_type,exp_state,khmc,account_name,account,bank,card_id,plan_date,proj_id as memo_projId from vi_report_rent_invoice ";
sqlstr+=" where hire_status='未核销' and item_method='网银' and rent_list<>1 and isnull(costmoney,0)>0 and";
sqlstr+=" (select case when CHARINDEX('_',item_id)>0 then substring(item_id,0,CHARINDEX('_',item_id)) else item_id end)";
sqlstr+=" not in(select cast(id as varchar(16)) from fund_rent_plan where export_flag='1') ";
sqlstr+=" and plan_date <= dateadd(dd,1,getdate()) "+wherestr;
sqlstr+=" and not exists( select id from apply_info_detail where plan_id=vi_report_rent_invoice.item_id) ";
sqlstr+=" order by proj_id,rent_list,fee_type ";

%>
<body onload="public_onload(0);">
<form action="wyhx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="expsqlstr" value="<%=sqlstr %>">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资产管理&gt; 网银申请
		</td>
	</tr>
</table><!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>持卡人:<input name="account_name" type="text" size="11" value="<%=account_name %>"></td>
<td>项目编号:<input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>租赁物类型:<select name="prod_id" style="width:100px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str%>"));</script>
     </select>
</td>
<td>

起租确认日期:<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     
&nbsp;至&nbsp;<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     
     
</td>
<td>
导出状态:</td><td><select name="exp_state" style="width:90px;">
 <script>w(mSetOpt('<%=exp_state%>',"|未核销|核销失败"));</script>
 </select>
</td>
</tr>
<tr>
<td>代理商:<input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>开户银行:<select name="bank" style="width:90px;">
<script>w(mSetOpt('<%=bank%>',"<%=bank_str%>"));</script>
</select></td>
<td>
租金&nbsp;&nbsp;类别:<select name="fee_type" style="width:100px;">
     <script>w(mSetOpt('<%=fee_type%>',"|租金|违约金"));</script>
     </select></td>
<td>
 计划收取日期:<input name="plan_start_date" type="text" size="10" readonly dataType="Date" value="<%=plan_start_date %>">
<img  onClick="openCalendar(plan_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
  
&nbsp;至&nbsp;<input name="plan_end_date" type="text" size="10" readonly dataType="Date" value="<%=plan_end_date %>">
<img  onClick="openCalendar(plan_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
    
</td>
<td align="left">
<input name="" type="button" value="查询" onclick="dataNav.submit();">
</td><td align="right">
<input type="button" value="清空" onclick="clearQuery();">&nbsp;
</td>
</tr>
</table>
</fieldset>
</div><!-- 查询条件结束 -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td nowrap>
				<BUTTON class="btn_2"  type="button" onclick="return validata_exp_do_all('export_save.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">申请导出</button>
				</td>
				<td nowrap>
				<span style="color:#154288;height:18px;font-size:13px;">核销银行(模板):</span>
				  <select name="hxBank">
					  <option value="">--请选择--</option>
					  <option value="jsBank">建设银行</option>
					  <option value="msBank">民生银行</option>
				   </select>
				</td>
			</tr>
		</table>
		</td><!--操作按钮结束-->
		<td align="right" width="90%">					 	
		<!--翻页控制开始-->
		<%@ include file="../../public/pageSplitNoCode.jsp" %>
		<!--翻页控制结束-->
		</td>
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>客户身份证号</th>
		<th>开户名</th>
		<th>开户银行</th>
		<th>客户帐号</th>
		<th>金额</th>
		<th>项目编号</th>
		<th>期次</th>
		<th>计划收取日期</th>		
		<th>类别</th>
		<th>备注</th>
		<th>状态</th>
      </tr>
<tbody id="data">
<%	 
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td align="left"><%=getDBStr(rs.getString("card_id") ) %></td>
        <td align="center"><%=getDBStr(rs.getString("account_name")) %></td>
		<td align="center"><%=getDBStr(rs.getString("bank")) %></td>
        <td align="left"><%=getDBStr(rs.getString("account")) %></td>
        <td align="right"><%=CurrencyUtil.convertFinance( rs.getDouble("costmoney")) %></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("rent_list")) %></td>
        <td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
        <td align="center"><%=getDBStr(rs.getString("fee_type")) %></td>
        <td align="left"><%=getDBStr(rs.getString("memo")) %></td>
		<td align="center"><%="0".equals(rs.getString("exp_state"))?"未核销":"核销失败"+rs.getString("exp_state")+"次" %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>