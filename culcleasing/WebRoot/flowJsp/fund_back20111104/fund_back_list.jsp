<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金退款 - 已退款资金</title>
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

<form action="fund_back_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资金退款&gt; 已退款资金</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

//本页查询参数
String project_name = getStr( request.getParameter("client_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

countSql = "select count(id) as amount from vi_fund_fund_back where 1=1 "+wherestr;

%>

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
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
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
		<th>项目名称</th>
		<th>合同编号</th>

        <th>款项内容</th>
        <th>期次</th>
        <th>款项名称</th>
        <th>退款金额</th>
        <th>退款日期</th>
      </tr>
      <tbody id="data">
<%
String col_str=" id,project_name,contract_id,fee_type_name,fee_name,fee_num,back_date,back_money ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fund_fund_back where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_fund_back where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("fee_type_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("fee_num")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("fee_name")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("back_money" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("back_date")) %></td>	
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
