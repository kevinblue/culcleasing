<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资掉期台账信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../js/leasing_startflow.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<body onLoad="public_onload(0);">
<form name="dataNav" id="form01" method="get" action="project_info_list.jsp">

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	掉期台账</td>
    </tr>
  </table>
  <!--标题结束-->
<%
String drawings_id = getStr( request.getParameter("drawings_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String is_edit = getStr( request.getParameter("is_edit") );
if(drawings_id!=null && !"".equals(drawings_id)){
	wherestr+= " and drawings_id like '%" + drawings_id + "%'";
}
if(doc_id!=null && !"".equals(doc_id)){
	wherestr+= " and doc_id = '" + doc_id + "'";
}

countSql = "select count(id) as amount from financing_change_date_info where 1=1 "+wherestr;
//导出类型2--数据导出
String expsqlstr = "select swap_start_date_t 起息日,swap_delivery_date_t 交割日,swap_currency_t 币种,swap_nominal_money_t 名义金额,swap_fix FIX,swap_lib LIB,swap_rate_t 合同利率,rate_diff 利率差,interest_day_amount 计息天数,interest_diff 息差,fact_bank_diff 银行实际利差  from financing_change_date_info where 1=1 "+wherestr+"  ";

System.out.println("掉期coutSql = "+countSql);
%>
<input type="hidden" name="drawings_id" value="<%=drawings_id %>"/>
<input type="hidden" name="doc_id" value="<%= doc_id%>"/>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<%--
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		项目名称&nbsp;<input name="project_name" type="text" value="<%=drawings_id %>">
	</td>
	<td>
		合同编号&nbsp;<input name="contract_id" type="text" value="<%=doc_id %>">
	</td>	
	<td>
	<input type="button" value="查询" onclick="dataNav.submit();">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="清空" onclick="clearQuery();" >
	</td>
	</tr>
	<tr>
	</tr>
	</table>
	</fieldset> --%>
	</div>
<!--可折叠查询结束-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
  <tr class="maintab">
      	<td align="left" width="10%">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="InsurPay">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	   </td>
    	<td align="right" width="60%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>		
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>起息日</th>
	    <th>交割日</th>
	    <th>币种</th>
	    <th>名义金额</th>
		<th>FIX</th>
	    <th>LIB</th>
	    <th>合同利率</th>
	    <th>利率差</th>
	    <th>计息天数</th>
	    <th>息差</th>
	    <th>银行实际利差</th>
		
		<th>利息互换日</th>

	    <th>修改人</th>
	    <% if(!"1".equals(is_edit)){%>
	    <th>操作</th>
	    <%} %>
      </tr>
      <tbody id="data">
<%
String col_str="id,swap_start_date_t,swap_currency_t,swap_delivery_date_t,swap_nominal_money_t,swap_fix,swap_lib,swap_rate_t,rate_diff,isnull(interest_day_amount,datediff(dd,swap_start_date_t,swap_delivery_date_t)) interest_day_amount,interest_diff,fact_bank_diff,(select name from base_user where id=modifactor) modifactor,fxr_date ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from financing_change_date_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from financing_change_date_info where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr += " order by id desc ";
%>
<!--<%=sqlstr%>-->
<%
LogWriter.logDebug(request, "掉期台账信息界面###"+sqlstr);

rs = db.executeQuery(sqlstr);
int flag = 0;
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=getDBDateStr( rs.getString("swap_start_date_t") )  %></td>
		<td align="center"><%=getDBDateStr( rs.getString("swap_delivery_date_t") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("swap_currency_t") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("swap_nominal_money_t") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("swap_fix") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("swap_lib") ) %></td>	
		<td align="center"><%= getDBStr( rs.getString("swap_rate_t") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("rate_diff") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest_day_amount") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest_diff") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("fact_bank_diff") ) %></td>

		<td align="center"><%= getDBDateStr( rs.getString("fxr_date") ) %></td>


		<td align="center"><%= getDBStr( rs.getString("modifactor") ) %></td>
		<% if(!"1".equals(is_edit)){%>
		
		<td align="center">
     	<a href='financing_dqAccount_mod.jsp?Id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>
     	</td>	
		<%} %>
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
