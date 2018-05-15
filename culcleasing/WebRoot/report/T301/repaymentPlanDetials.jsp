<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>还款计划明细 </title>
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

<form action="repaymentPlanDetials.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		还款计划明细</td>
	</tr>
</table>
<!--标题结束-->

<%
//获取查询类型
String drawings_id = getStr( request.getParameter("drawings_id") );
System.out.println("输出类型"+drawings_id);

String partSqlStr = "";


//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
System.out.println("项目名称"+project_name);
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if( partSqlStr!=null && !"".equals(partSqlStr) ){
	wherestr += partSqlStr;
}

countSql = "select count(*) as amount from vi_report_fina_refund_details ttt where 1=1 and drawings_id='"+drawings_id+"'";

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>提款编号:&nbsp;<input name="drawings_id"  type="text" size="15" value="<%=drawings_id %>"></td>
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
		<th>应还日期</th>
		<th>实收日期</th>
		<th>提款编号</th>
		<th>融资单位</th>
		<th>贷款类型</th>
		<th>币种</th>
		<th>本金金额（原币）</th>
		<th>本金金额（本币）</th>
		<th>利息金额（原币）</th>
		<th>利息金额（本币）</th>
		<th>本息合计（原币）</th>
		<th>本息合计（本币）</th>
		<th>其他金额（原币）</th>
		<th>其他金额（本币）</th>
		<th>其他金额类型</th>
		<th>还款小计（原币）</th>
		<th>还款小计（本币）</th>
      </tr>
      <tbody id="data">
<%
String col_str="vci.id,vci.refund_plan_date,vci.refund_fact_date,vci.crediter,vci.credit_type,vci.currency,"+
			"vci.refund_corpus,vci.refund_corpus1,vci.refund_interest,vci.refund_interest1,vci.refund_money,vci.refund_money1,"+
			"vci.refund_otherfee_money,vci.refund_otherfee_money1,vci.refund_otherfee_type,"+
			"vci.refund_subtotal,vci.refund_subtotal1 ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_report_fina_refund_details vci "+
"where vci.drawings_id='"+drawings_id+"' and  vci.id not in ( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_report_fina_refund_details where drawings_id='"+drawings_id+"' order by refund_plan_date  ) " ;
sqlstr += " order by vci.refund_plan_date " ;
System.out.println("输出sql语句"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%=getDBDateStr( rs.getString("refund_plan_date")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("refund_fact_date")) %></td>
		<td align="center"><%=drawings_id %> </td>
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<td align="center"><%=getDBStr( rs.getString("credit_type")) %></td>		
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_corpus")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("refund_corpus1")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_interest")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_interest1")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_money")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_money1")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_otherfee_money")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_otherfee_money1")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_otherfee_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_subtotal")) %></td>
		<td align="center"><%=getDBStr( rs.getString("refund_subtotal1")) %></td>
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
