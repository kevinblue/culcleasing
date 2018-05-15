<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资还款批量调息</title>
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
<form action="refund_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">融资还款批量调息</td>
  </tr>
</table>
<!--标题结束-->
<%
String crediter = getStr( request.getParameter("crediter") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));


if ( crediter!=null && !crediter.equals("") ) {
	wherestr += " and crediter like '%" + crediter + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),refund_plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),refund_plan_date,21)<='"+end_date+"' ";
}

countSql = "select count(id) as amount from vi_fina_refund_execmod where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select id 标识字段,refund_list 期数,crediter 授信单位,refund_plan_date 还款日期,refund_corpus 还本金额,refund_interest 付息金额,refund_money 本息合计,"+
 "refund_otherfee_money 其他费用金额,refund_otherfee_type 其他费用类别,refund_subtotal 本次还款总计,remark 备注 from vi_fina_refund_execmod where 1=1"+wherestr;
 
%>
<!--可折叠查询开始-->

<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>授信单位:&nbsp;<input name="crediter"  type="text" size="15" value="<%=crediter %>"></td>
<td>计划日期:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
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
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td>
			<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
			<input name="excel_name" type="hidden" value="refund_list_tx">
			
			<a href="#" accesskey="n" onclick="return validata_data_report('../../func/exp_report.jsp','refund_list.jsp');">
		    <img align="absmiddle"  src="../../images/action_down.gif" alt="导出" align="absmiddle">导出还款计划</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		
			<td>
			<a href="#" accesskey="n" onClick="uploadNewRefund()">
		    <img align="absmiddle"  src="../../images/action_up.gif" alt="导入" align="absmiddle">上传还款计划</a></td>
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

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>期数</th>
     <th>授信单位</th>
     <th>还款日期</th>
     <th>还本金额</th>
     <th>付息金额</th>
     <th>本息合计</th>
     <th>其他费用金额</th>
     <th>其他费用类别</th>
     <th>本次还款总计</th>
     <th>备注</th>
   </tr>
   <tbody id="data">
<%

String col_str="id,refund_list,crediter,refund_plan_date,refund_rate,refund_corpus";
col_str += ",refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,remark";

//sqlstr = "select top  top "+ intPageSize +" "+col_str+" from vi_fina_refund_execmod where 1=1"+wherestr;


sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fina_refund_execmod where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fina_refund_execmod where 1=1 "+wherestr+" order by id) "+wherestr ;
sqlstr +=" order by id ";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("refund_list")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("crediter")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("refund_plan_date")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_corpus")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_interest")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_money")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_otherfee_money")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_otherfee_type")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_subtotal")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</form>
</body>

<script type="text/javascript">
//点击上传还款计划
function uploadNewRefund(){
	window.open("refund_upload.jsp");
}
</script>

</html>
